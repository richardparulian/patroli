import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:patroli/app/constants/app_review_constants.dart';
import 'package:patroli/core/providers/storage_providers.dart';
import 'package:patroli/core/utils/app_review_service.dart';
import 'package:patroli/l10n/l10n.dart';

final inAppReviewProvider = Provider<InAppReview>((ref) {
  return InAppReview.instance;
});

final appReviewServiceProvider = Provider<AppReviewService>((ref) {
  final inAppReview = ref.watch(inAppReviewProvider);
  final preferences = ref.watch(sharedPreferencesProvider);

  final service = AppReviewServiceImpl(
    inAppReview: inAppReview,
    preferences: preferences,
    minSessionsBeforeReview: AppReviewConstants.minSessionsBeforeReview,
    minDaysBeforeReview: AppReviewConstants.minDaysBeforeReview,
    minActionsBeforeReview: AppReviewConstants.minActionsBeforeReview,
  );

  service.init();
  return service;
});

final shouldRequestReviewProvider = FutureProvider.autoDispose<bool>((ref) async {
  final reviewService = ref.watch(appReviewServiceProvider);
  return await reviewService.shouldRequestReview();
});

class SmartReviewPrompt extends ConsumerWidget {
  final Widget child;

  const SmartReviewPrompt({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<bool>>(shouldRequestReviewProvider, (_, state) {
      state.whenData((shouldRequest) {
        if (shouldRequest && context.mounted) {
          _showReviewFlow(context, ref);
        }
      });
    });

    return child;
  }

  Future<void> _showReviewFlow(BuildContext context, WidgetRef ref) async {
    final reviewService = ref.read(appReviewServiceProvider);

    final shouldContinue =
        await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(context.tr('enjoying_app')),
            content: Text(context.tr('share_feedback_prompt')),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(context.tr('no_thanks')),
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(context.tr('sure')),
              ),
            ],
          ),
        ) ??
        false;

    if (!shouldContinue || !context.mounted) return;

    final hasFeedback = await reviewService.showFeedbackForm(
      context: context,
      title: context.tr('feedback_matters'),
      message: context.tr('feedback_request_message'),
    );

    if (!hasFeedback) {
      await reviewService.requestReview();
    }
  }
}
