import 'package:pos/core/extensions/result_state_extension.dart';
import 'package:pos/features/pre_sign/domain/entities/pre_sign_create_entity.dart';

extension UploadFileStateX on ResultState<PreSignCreateEntity?> {
  PreSignCreateEntity? get presign => this is Success<PreSignCreateEntity?> ? (this as Success).data : null;
}