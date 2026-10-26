import 'package:flutter/material.dart';

import '../../l10n/app_localizations.dart';
import '../../theme/app_theme.dart';
import '../../widgets/auth_scaffold.dart';

/// UI for the "Forgot Password" flow (spec section 3). NOTE: this is a
/// front-end-only stub — there's no email-sending endpoint on the backend
/// yet, so tapping "Send reset link" just shows the confirmation message.
/// Wire this up to a real `/auth/forgot-password` endpoint before shipping.
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AuthScaffold(
      title: l10n.resetTitle,
      subtitle: l10n.resetSubtitle,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!_sent) ...[
            Text(
              l10n.resetIntro,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: l10n.fieldEmail, prefixIcon: const Icon(Icons.email_outlined)),
            ),
            const SizedBox(height: AppSpacing.lg),
            ElevatedButton(onPressed: () => setState(() => _sent = true), child: Text(l10n.resetSendButton)),
          ] else ...[
            const Icon(Icons.mark_email_read_outlined, size: 48, color: AppColors.success),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.resetSent(_emailController.text),
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: TextButton(onPressed: () => Navigator.pop(context), child: Text(l10n.backToLogin)),
            ),
          ],
        ],
      ),
    );
  }
}
