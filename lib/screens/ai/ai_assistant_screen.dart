import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../services/api_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/alive.dart';
import '../../widgets/gradient_scaffold_background.dart';

/// Suggested first questions, in the app language (sent as typed).
List<String> _suggestedQuestions(AppLocalizations l10n) => [
      l10n.chatSuggest1,
      l10n.chatSuggest2,
      l10n.chatSuggest3,
      l10n.chatSuggest4,
      l10n.chatSuggest5,
      l10n.chatSuggest6,
    ];

/// Conversational "AI Health Assistant" (spec section 20). If [documentId]
/// is provided, every reply is grounded in that document; otherwise the
/// backend grounds replies in a summary of active medications and
/// upcoming appointments.
class AiAssistantScreen extends StatefulWidget {
  final String? documentId;
  const AiAssistantScreen({super.key, this.documentId});

  @override
  State<AiAssistantScreen> createState() => _AiAssistantScreenState();
}

class _ChatMessage {
  final String text;
  final bool isUser;
  const _ChatMessage(this.text, {this.isUser = false});
}

class _AiAssistantScreenState extends State<AiAssistantScreen> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<_ChatMessage> _messages = [];
  bool _isSending = false;
  bool _isLoadingHistory = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    try {
      final history = await apiService.getChatHistory(documentId: widget.documentId);
      if (!mounted) return;
      setState(() {
        _messages.addAll(history.map((m) => _ChatMessage(m['content'] ?? '', isUser: m['role'] == 'user')));
        if (_messages.isEmpty) {
          _messages.add(_ChatMessage(AppLocalizations.of(context).chatGreeting));
        }
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => _messages.add(_ChatMessage(AppLocalizations.of(context).chatGreeting)));
    } finally {
      if (mounted) setState(() => _isLoadingHistory = false);
    }
  }

  Future<void> _send([String? presetText]) async {
    final text = (presetText ?? _inputController.text).trim();
    if (text.isEmpty || _isSending) return;

    setState(() {
      _messages.add(_ChatMessage(text, isUser: true));
      _inputController.clear();
      _isSending = true;
    });
    _scrollToBottom();

    try {
      final reply = await apiService.sendChatMessage(message: text, documentId: widget.documentId);
      if (!mounted) return;
      setState(() => _messages.add(_ChatMessage(reply)));
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() => _messages.add(_ChatMessage(AppLocalizations.of(context).chatUnavailable(e.message))));
    } finally {
      if (mounted) setState(() => _isSending = false);
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      body: GradientScaffoldBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
                child: Row(children: [
                  const CircleAvatar(
                      radius: 18, backgroundColor: AppColors.darkCard, child: Icon(Icons.smart_toy_outlined, size: 18, color: AppColors.lightBlue)),
                  const SizedBox(width: AppSpacing.sm),
                  Text(l10n.chatTitle, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
                ]),
              ),
              if (_messages.length <= 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _suggestedQuestions(l10n)
                        .map((q) => ActionChip(
                              avatar: const Icon(Icons.auto_awesome_outlined, size: 16, color: AppColors.teal),
                              backgroundColor: AppColors.cardBackground,
                              label: Text(q, style: const TextStyle(fontSize: 12)),
                              onPressed: () => _send(q),
                            ))
                        .toList(),
                  ),
                ),
              Expanded(
                child: _isLoadingHistory
                    ? const Center(child: CircularProgressIndicator())
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.all(AppSpacing.md),
                        itemCount: _messages.length + (_isSending ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == _messages.length) return const _TypingIndicator();
                          return _MessageBubble(message: _messages[index]);
                        },
                      ),
              ),
              _ChatInputBar(controller: _inputController, onSend: () => _send(), enabled: !_isSending),
            ],
          ),
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final _ChatMessage message;
  const _MessageBubble({required this.message});

  @override
  Widget build(BuildContext context) {
    final align = message.isUser ? AlignmentDirectional.centerEnd : AlignmentDirectional.centerStart;
    final bubbleColor = message.isUser ? AppColors.darkCard : AppColors.cardBackground;
    final textColor = message.isUser ? Colors.white : AppColors.textPrimary;

    return Align(
      alignment: align,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadiusDirectional.only(
            topStart: const Radius.circular(16),
            topEnd: const Radius.circular(16),
            bottomStart: Radius.circular(message.isUser ? 16 : 4),
            bottomEnd: Radius.circular(message.isUser ? 4 : 16),
          ),
        ),
        child: Text(message.text, style: TextStyle(color: textColor, fontSize: 14.5, height: 1.35)),
      ),
    );
  }
}

class _TypingIndicator extends StatelessWidget {
  const _TypingIndicator();
  @override
  Widget build(BuildContext context) => const Align(
        alignment: AlignmentDirectional.centerStart,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 4),
          child: SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
        ),
      );
}

class _ChatInputBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final bool enabled;
  const _ChatInputBar({required this.controller, required this.onSend, this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: controller,
            enabled: enabled,
            onSubmitted: (_) => onSend(),
            decoration: InputDecoration(hintText: AppLocalizations.of(context).chatInputHint, fillColor: Colors.white),
          ),
        ),
        const SizedBox(width: 8),
        // Same teal send circle as the home "Ask DAWI" bar.
        PressableScale(
          onTap: enabled ? onSend : null,
          borderRadius: 26,
          child: Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: enabled ? AppColors.primary : AppColors.textSecondary,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.send_rounded, color: Colors.white, size: 22),
          ),
        ),
      ]),
    );
  }
}
