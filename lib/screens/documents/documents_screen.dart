import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/constants.dart';
import '../../models/api_models.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../../widgets/empty_state.dart';
import 'document_details_screen.dart';
import 'ocr_analysis_screen.dart';

/// Central document management page (spec section 6): categorized list,
/// search-free filter chips, and a scan/upload entry point.
class DocumentsScreen extends StatefulWidget {
  const DocumentsScreen({super.key});

  @override
  State<DocumentsScreen> createState() => DocumentsScreenState();
}

class DocumentsScreenState extends State<DocumentsScreen> {
  final ImagePicker _picker = ImagePicker();
  String? _typeFilter;
  late Future<List<ApiDocument>> _future;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _future = apiService.listDocuments();
  }

  /// Public so other screens (e.g. the home dashboard's quick actions) can
  /// trigger the same scan/upload flow via a GlobalKey, if desired.
  void refresh() => setState(() => _future = apiService.listDocuments(documentType: _typeFilter));

  Future<void> _pickAndScan(ImageSource source) async {
    try {
      final XFile? picked = await _picker.pickImage(source: source, imageQuality: 90, maxWidth: 2000);
      if (picked == null) return;

      setState(() => _isUploading = true);
      final result = await apiService.scanDocument(picked);
      if (!mounted) return;

      final saved = await Navigator.push<bool>(
        context,
        MaterialPageRoute(builder: (_) => OcrAnalysisScreen(scanResult: result)),
      );
      if (saved == true) refresh();
    } on ApiException catch (e) {
      _showError(e.message);
    } catch (e) {
      _showError('Could not access camera/gallery: $e');
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }

  void _showError(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.redAccent));
  }

  void _showScanUploadSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.photo_camera_outlined, color: AppColors.primary),
              title: const Text('Scan document'),
              subtitle: const Text('Use your camera'),
              onTap: () {
                Navigator.pop(context);
                _pickAndScan(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.image_outlined, color: AppColors.primary),
              title: const Text('Upload from gallery'),
              subtitle: const Text('Photos, JPG or PNG'),
              onTap: () {
                Navigator.pop(context);
                _pickAndScan(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Documents')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _isUploading ? null : _showScanUploadSheet,
        icon: const Icon(Icons.add, color: AppColors.lightBlue),
        label: const Text('Add document'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 44,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    children: [
                      _FilterChip(label: 'All', selected: _typeFilter == null, onTap: () {
                        setState(() => _typeFilter = null);
                        refresh();
                      }),
                      ...DocumentTypes.all.map((t) => Padding(
                            padding: const EdgeInsets.only(left: AppSpacing.sm),
                            child: _FilterChip(
                              label: DocumentTypes.label(t),
                              selected: _typeFilter == t,
                              onTap: () {
                                setState(() => _typeFilter = t);
                                refresh();
                              },
                            ),
                          )),
                    ],
                  ),
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async => refresh(),
                    child: FutureBuilder<List<ApiDocument>>(
                      future: _future,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        if (snapshot.hasError) {
                          return ListView(children: [
                            EmptyState(icon: Icons.cloud_off, message: "Couldn't load documents.\n${snapshot.error}"),
                          ]);
                        }
                        final docs = snapshot.data ?? [];
                        if (docs.isEmpty) {
                          return ListView(children: const [
                            EmptyState(icon: Icons.folder_open_outlined, message: 'No medical documents yet.'),
                          ]);
                        }
                        return ListView.builder(
                          padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.md, AppSpacing.md, 96),
                          itemCount: docs.length,
                          itemBuilder: (context, i) => _DocumentCard(document: docs[i]),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            if (_isUploading)
              Container(
                color: Colors.black.withValues(alpha: 0.35),
                child: const Center(
                  child: Card(
                    child: Padding(
                      padding: EdgeInsets.all(AppSpacing.lg),
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
                        CircularProgressIndicator(),
                        SizedBox(height: AppSpacing.md),
                        Text('Analyzing your document...'),
                      ]),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;
  const _FilterChip({required this.label, required this.selected, required this.onTap});

  /// Colors come from the chip theme: dark pill when selected.
  @override
  Widget build(BuildContext context) => ChoiceChip(
        label: Text(label),
        selected: selected,
        showCheckmark: false,
        onSelected: (_) => onTap(),
      );
}

class _DocumentCard extends StatelessWidget {
  final ApiDocument document;
  const _DocumentCard({required this.document});

  @override
  Widget build(BuildContext context) {
    final imageUrl = apiService.resolveImageUrl(document.fileUrl);
    final dateStr = document.documentDate.isNotEmpty
        ? document.documentDate
        : DateFormat('d MMM yyyy').format(document.createdAt);

    return AppTile(
      title: DocumentTypes.label(document.documentType),
      subtitle: document.doctorName.isEmpty ? dateStr : '${document.doctorName} · $dateStr',
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => DocumentDetailsScreen(documentId: document.id)),
      ),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: SizedBox(
          width: 52,
          height: 52,
          child: imageUrl.isEmpty
              ? const _ThumbPlaceholder()
              : Image.network(imageUrl, fit: BoxFit.cover, errorBuilder: (_, __, ___) => const _ThumbPlaceholder()),
        ),
      ),
    );
  }
}

class _ThumbPlaceholder extends StatelessWidget {
  const _ThumbPlaceholder();
  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: AppColors.mint,
        child: Icon(Icons.description_outlined, color: AppColors.teal),
      );
}
