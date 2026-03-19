import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

extension CheckOutUploadStateX on ResultState<PreSignCreateEntity?> {
  PreSignCreateEntity? get presign =>
      this is Success<PreSignCreateEntity?> ? (this as Success).data : null;
}
