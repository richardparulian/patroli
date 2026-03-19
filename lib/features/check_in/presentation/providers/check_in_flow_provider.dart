import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/check_in/application/services/check_in_submission_service.dart';
import 'package:patroli/features/check_in/domain/entities/check_in_entity.dart';
import 'package:patroli/features/pre_sign/application/services/pre_sign_upload_service.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';
import 'package:uuid/uuid.dart';

class CheckInFlowState {
  const CheckInFlowState({
    this.selfieImage,
    this.uploadState = const Idle<PreSignCreateEntity?>(),
    this.submissionState = const Idle<CheckInEntity?>(),
  });

  final XFile? selfieImage;
  final ResultState<PreSignCreateEntity?> uploadState;
  final ResultState<CheckInEntity?> submissionState;

  static const _unset = Object();

  CheckInFlowState copyWith({
    Object? selfieImage = _unset,
    ResultState<PreSignCreateEntity?>? uploadState,
    ResultState<CheckInEntity?>? submissionState,
  }) {
    return CheckInFlowState(
      selfieImage: identical(selfieImage, _unset)
          ? this.selfieImage
          : selfieImage as XFile?,
      uploadState: uploadState ?? this.uploadState,
      submissionState: submissionState ?? this.submissionState,
    );
  }

  bool get isUploading => uploadState.isLoading;
  bool get isSubmitting => submissionState.isLoading;
  bool get isBusy => isUploading || isSubmitting;
  bool get hasSelfie => selfieImage != null;
  bool get isUploadFailed => uploadState.isError;
  String? get uploadedImageUrl => uploadState.dataOrNull?.fileUrl;
  bool get isReadyToSubmit =>
      uploadState.isSuccess &&
      uploadedImageUrl != null &&
      uploadedImageUrl!.isNotEmpty;
}

class CheckInFlowNotifier extends Notifier<CheckInFlowState> {
  @override
  CheckInFlowState build() => const CheckInFlowState();

  Future<void> captureSelfie(XFile image) async {
    state = CheckInFlowState(
      selfieImage: image,
      uploadState: const Loading(),
      submissionState: const Idle(),
    );
    await _upload(image);
  }

  Future<void> retryUpload() async {
    final image = state.selfieImage;

    if (image == null) return;

    state = state.copyWith(
      uploadState: const Loading(),
      submissionState: const Idle(),
    );
    await _upload(image);
  }

  void retake() {
    state = const CheckInFlowState();
  }

  Future<void> submit({required int branchId}) async {
    final imageUrl = state.uploadedImageUrl;
    if (imageUrl == null || imageUrl.isEmpty) return;

    state = state.copyWith(submissionState: const Loading());

    final result = await ref
        .read(checkInSubmissionServiceProvider)
        .submit(branchId: branchId, imageUrl: imageUrl);

    if (!ref.mounted) return;

    state = state.copyWith(submissionState: result);
  }

  Future<void> _upload(XFile image) async {
    final result = await ref
        .read(preSignUploadServiceProvider)
        .createAndUpload(filename: await _buildFilename(), image: image);

    if (!ref.mounted) return;

    state = state.copyWith(uploadState: result);
  }

  Future<String> _buildFilename() async {
    final uuid = const Uuid().v4();

    DateTime now;
    try {
      now = await NTP.now();
    } catch (_) {
      now = DateTime.now();
    }

    return '${uuid}_${now.millisecondsSinceEpoch}.jpg';
  }
}

final checkInFlowProvider =
    NotifierProvider.autoDispose<CheckInFlowNotifier, CheckInFlowState>(
      CheckInFlowNotifier.new,
    );
