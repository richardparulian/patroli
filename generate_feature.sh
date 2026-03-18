#!/bin/bash

# Flutter Riverpod Clean Architecture - Feature Generator
# Generates a feature with modern Riverpod and Clean Architecture best practices.
# Pattern based on the current starter project structure

# Color definitions
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

usage() {
  echo -e "${YELLOW}Usage: $0 [options] --name <feature_name>${NC}"
  echo -e "\nOptions:"
  echo -e "  --name <feature_name>    Name of feature (required, use snake_case)"
  echo -e "  --no-ui                  Generate without UI/presentation layer"
  echo -e "  --help                   Display this help message"
  echo -e "\nExamples:"
  echo -e "  $0 --name user_profile"
  echo -e "  $0 --name product --no-ui"
  exit 1
}

# Defaults
FEATURE_NAME=""
WITH_UI="yes"

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --name)
      FEATURE_NAME="$2"; shift 2;;
    --no-ui)
      WITH_UI="no"; shift;;
    --help)
      usage;;
    *)
      echo -e "${RED}Unknown option: $1${NC}"; usage;;
  esac
done

if [[ -z "$FEATURE_NAME" ]]; then
  echo -e "${RED}Error: --name is required${NC}"; usage
fi

# Convert snake_case to PascalCase and camelCase
PASCAL_CASE=$(echo "$FEATURE_NAME" | awk -F_ '{for(i=1;i<=NF;i++) $i=toupper(substr($i,1,1)) substr($i,2)}1' OFS='')
CAMEL_CASE="$(tr '[:upper:]' '[:lower:]' <<< ${PASCAL_CASE:0:1})${PASCAL_CASE:1}"

BASE_DIR="lib/features/$FEATURE_NAME"

if [[ -d "$BASE_DIR" ]]; then
  echo -e "${RED}Error: Feature $FEATURE_NAME already exists at $BASE_DIR${NC}"; exit 1
fi

echo -e "${BLUE}Generating feature: $FEATURE_NAME ($PASCAL_CASE)${NC}"

# Create directories
mkdir -p "$BASE_DIR/data/datasources"
mkdir -p "$BASE_DIR/data/models"
mkdir -p "$BASE_DIR/data/dtos/request"
mkdir -p "$BASE_DIR/data/dtos/response"
mkdir -p "$BASE_DIR/data/repositories"
mkdir -p "$BASE_DIR/domain/entities"
mkdir -p "$BASE_DIR/domain/repositories"
mkdir -p "$BASE_DIR/domain/usecases"
mkdir -p "$BASE_DIR/application/providers"
mkdir -p "$BASE_DIR/application/services"
mkdir -p "$BASE_DIR/presentation/providers"
mkdir -p "$BASE_DIR/presentation/screens"

# ==========================================
# Domain Layer
# ==========================================

# Entity
write_entity() {
  local file="$1"
  cat > "$file" << 'ENTITYEOF'
import 'package:freezed_annotation/freezed_annotation.dart';

part '@FEATURE_NAME@_entity.freezed.dart';

@freezed
abstract class @PASCAL_CASE@Entity with _$@PASCAL_CASE@Entity {
  const factory @PASCAL_CASE@Entity({
    required int id,
    required String name,
  }) = _@PASCAL_CASE@Entity;

  // :: Empty @FEATURE_NAME@
  factory @PASCAL_CASE@Entity.empty() => const @PASCAL_CASE@Entity(id: 0, name: '');
}
ENTITYEOF
  # Replace placeholders
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_entity "$BASE_DIR/domain/entities/${FEATURE_NAME}_entity.dart"

# Repository Interface
write_repository_interface() {
  local file="$1"
  cat > "$file" << 'REPOEOF'
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/request/@FEATURE_NAME@_request.dart';
import '../entities/@FEATURE_NAME@_entity.dart';

abstract class @PASCAL_CASE@Repository {
  Future<Either<Failure, @PASCAL_CASE@Entity>> submit(@PASCAL_CASE@Request request);
}
REPOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_repository_interface "$BASE_DIR/domain/repositories/${FEATURE_NAME}_repository.dart"

# UseCase - Submit
write_usecase_submit() {
  local file="$1"
  cat > "$file" << 'USECASEEOF'
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/request/@FEATURE_NAME@_request.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';
import 'package:equatable/equatable.dart';

class Create@PASCAL_CASE@Params extends Equatable {
  final @PASCAL_CASE@Request request;

  const Create@PASCAL_CASE@Params({
    required this.request,
  });

  @override
  List<Object?> get props => [request];
}

class Create@PASCAL_CASE@UseCase implements UseCase<@PASCAL_CASE@Entity, Create@PASCAL_CASE@Params> {
  final @PASCAL_CASE@Repository _repository;

  Create@PASCAL_CASE@UseCase(this._repository);

  @override
  Future<Either<Failure, @PASCAL_CASE@Entity>> call(Create@PASCAL_CASE@Params params) {
    return _repository.submit(params.request);
  }
}
USECASEEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_usecase_submit "$BASE_DIR/domain/usecases/${FEATURE_NAME}_use_case.dart"

# ==========================================
# Data Layer
# ==========================================

# Model
write_model() {
  local file="$1"
  cat > "$file" << 'MODELEOF'
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/@FEATURE_NAME@_entity.dart';

part '@FEATURE_NAME@_model.freezed.dart';
part '@FEATURE_NAME@_model.g.dart';

@freezed
abstract class @PASCAL_CASE@Model with _$@PASCAL_CASE@Model {
  const @PASCAL_CASE@Model._();

  const factory @PASCAL_CASE@Model({
    required int id,
    required String name,
  }) = _@PASCAL_CASE@Model;

  factory @PASCAL_CASE@Model.fromJson(Map<String, dynamic> json) =>
      _$@PASCAL_CASE@ModelFromJson(json);

  @PASCAL_CASE@Entity toEntity() => @PASCAL_CASE@Entity(id: id, name: name);
}
MODELEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_model "$BASE_DIR/data/models/${FEATURE_NAME}_model.dart"

# DTOs - Create request DTO
write_request_dto() {
  local file="$1"
  cat > "$file" << 'REQDTOEOF'
import 'package:json_annotation/json_annotation.dart';

part '@FEATURE_NAME@_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class @PASCAL_CASE@Request {
  final String name;

  @PASCAL_CASE@Request({
    required this.name,
  });

  factory @PASCAL_CASE@Request.fromJson(Map<String, dynamic> json) =>
      _$@PASCAL_CASE@RequestFromJson(json);

  Map<String, dynamic> toJson() => _$@PASCAL_CASE@RequestToJson(this);

  @override
  String toString() => '@PASCAL_CASE@(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is @PASCAL_CASE@Request && other.name == name;
  }

  @override
  int get hashCode => Object.hash(name, runtimeType);
}
REQDTOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_request_dto "$BASE_DIR/data/dtos/request/${FEATURE_NAME}_request.dart"

# DTOs - Create response DTO
write_response_dto() {
  local file="$1"
  cat > "$file" << 'RESPDTOEOF'
import 'package:json_annotation/json_annotation.dart';
import '../../models/@FEATURE_NAME@_model.dart';

part '@FEATURE_NAME@_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class @PASCAL_CASE@Response {
  final @PASCAL_CASE@Model @CAMEL_CASE@;

  @PASCAL_CASE@Response({
    required this.@CAMEL_CASE@,
  });

  factory @PASCAL_CASE@Response.fromJson(Map<String, dynamic> json) =>
      _$@PASCAL_CASE@ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$@PASCAL_CASE@ResponseToJson(this);

  @override
  String toString() => '@PASCAL_CASE@(@CAMEL_CASE@: $@CAMEL_CASE@)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is @PASCAL_CASE@Response && other.@CAMEL_CASE@ == @CAMEL_CASE@;
  }

  @override
  int get hashCode => Object.hash(@CAMEL_CASE@, runtimeType);
}
RESPDTOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_response_dto "$BASE_DIR/data/dtos/response/${FEATURE_NAME}_response.dart"

# DTOs - Create dtos.dart export file
write_dtos_export() {
  local file="$1"
  cat > "$file" << 'DTOSXPTEOF'
library;
export 'request/@FEATURE_NAME@_request.dart';
export 'response/@FEATURE_NAME@_response.dart';
DTOSXPTEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
}

write_dtos_export "$BASE_DIR/data/dtos/dtos.dart"

# Remote DataSource
write_datasource() {
  local file="$1"
  cat > "$file" << 'DSOEOF'
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/request/@FEATURE_NAME@_request.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/response/@FEATURE_NAME@_response.dart';
import '../models/@FEATURE_NAME@_model.dart';

abstract class @PASCAL_CASE@RemoteDataSource {
  Future<@PASCAL_CASE@Model> submit@PASCAL_CASE@(@PASCAL_CASE@Request request);
}

class @PASCAL_CASE@RemoteDataSourceImpl implements @PASCAL_CASE@RemoteDataSource {
  final ApiClient _apiClient;

  @PASCAL_CASE@RemoteDataSourceImpl(this._apiClient);

  @override
  Future<@PASCAL_CASE@Model> submit@PASCAL_CASE@(@PASCAL_CASE@Request request) async {
    final result = await _apiClient.post('/@FEATURE_NAME@', data: request.toJson());

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => @PASCAL_CASE@Response.fromJson(response).@CAMEL_CASE@,
    );
  }
}
DSOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_datasource "$BASE_DIR/data/datasources/${FEATURE_NAME}_remote_data_source.dart"

# Repository Implementation
write_repository_impl() {
  local file="$1"
  cat > "$file" << 'REPOIMPLEOF'
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/request/@FEATURE_NAME@_request.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/datasources/@FEATURE_NAME@_remote_data_source.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';

class @PASCAL_CASE@RepositoryImpl implements @PASCAL_CASE@Repository {
  final @PASCAL_CASE@RemoteDataSource _remoteDataSource;

  @PASCAL_CASE@RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, @PASCAL_CASE@Entity>> submit(@PASCAL_CASE@Request request) async {
    try {
      final model = await _remoteDataSource.submit@PASCAL_CASE@(request);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to submit @FEATURE_NAME@'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
REPOIMPLEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_repository_impl "$BASE_DIR/data/repositories/${FEATURE_NAME}_repository_impl.dart"

# ==========================================
# Application Layer - Providers (Data)
# ==========================================

write_data_provider() {
  local file="$1"
  cat > "$file" << 'DATAPROVEOF'
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/datasources/@FEATURE_NAME@_remote_data_source.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/repositories/@FEATURE_NAME@_repository_impl.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '@FEATURE_NAME@_data_providers.g.dart';

@riverpod
ApiClient @CAMEL_CASE@ApiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
@PASCAL_CASE@RemoteDataSource @CAMEL_CASE@RemoteDataSource(Ref ref) {
  final apiClient = ref.watch(@CAMEL_CASE@ApiClientProvider);
  return @PASCAL_CASE@RemoteDataSourceImpl(apiClient);
}

@riverpod
@PASCAL_CASE@Repository @CAMEL_CASE@Repository(Ref ref) {
  final remoteDataSource = ref.watch(@CAMEL_CASE@RemoteDataSourceProvider);
  return @PASCAL_CASE@RepositoryImpl(remoteDataSource);
}
DATAPROVEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_data_provider "$BASE_DIR/application/providers/${FEATURE_NAME}_data_providers.dart"

# ==========================================
# Application Layer - Providers (DI)
# ==========================================

write_di_provider() {
  local file="$1"
  cat > "$file" << 'DIPROVEOF'
import 'package:patroli/features/@FEATURE_NAME@/application/providers/@FEATURE_NAME@_data_providers.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/@FEATURE_NAME@_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '@FEATURE_NAME@_di_provider.g.dart';

@riverpod
Create@PASCAL_CASE@UseCase @CAMEL_CASE@UseCase(Ref ref) {
  return Create@PASCAL_CASE@UseCase(ref.watch(@CAMEL_CASE@RepositoryProvider));
}
DIPROVEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_di_provider "$BASE_DIR/application/providers/${FEATURE_NAME}_di_provider.dart"

# ==========================================
# Application Layer - Services
# ==========================================

write_service() {
  local file="$1"
  cat > "$file" << 'SERVICEEOF'
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/@FEATURE_NAME@/application/providers/@FEATURE_NAME@_di_provider.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/dtos/request/@FEATURE_NAME@_request.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/@FEATURE_NAME@_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '@FEATURE_NAME@_service.g.dart';

class @PASCAL_CASE@Service {
  @PASCAL_CASE@Service(this.ref);

  final Ref ref;

  Future<ResultState<@PASCAL_CASE@Entity>> submit({
    required String name,
  }) async {
    try {
      final useCase = ref.read(@CAMEL_CASE@UseCaseProvider);
      final result = await useCase(
        Create@PASCAL_CASE@Params(
          request: @PASCAL_CASE@Request(name: name),
        ),
      );

      return result.fold(
        (failure) => Error(failure.message),
        (entity) => Success(entity),
      );
    } catch (e) {
      return Error(e.toString().replaceFirst('Exception: ', ''));
    }
  }
}

@riverpod
@PASCAL_CASE@Service @CAMEL_CASE@Service(Ref ref) {
  return @PASCAL_CASE@Service(ref);
}
SERVICEEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_service "$BASE_DIR/application/services/${FEATURE_NAME}_service.dart"

# ==========================================
# Presentation Layer - Providers
# ==========================================

write_provider() {
  local file="$1"
  cat > "$file" << 'PROVIDEREOF'
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/@FEATURE_NAME@/application/services/@FEATURE_NAME@_service.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '@FEATURE_NAME@_provider.g.dart';

@riverpod
class @PASCAL_CASE@ extends _$@PASCAL_CASE@ {
  @override
  ResultState<@PASCAL_CASE@Entity> build() {
    return const Idle();
  }

  Future<void> run({required String name}) async {
    state = const Loading();
    state = await ref.read(@CAMEL_CASE@ServiceProvider).submit(name: name);
  }
}
PROVIDEREOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_provider "$BASE_DIR/presentation/providers/${FEATURE_NAME}_provider.dart"

# ==========================================
# Presentation Layer - Screens
# ==========================================

if [[ "$WITH_UI" == "yes" ]]; then
  write_screen() {
    local file="$1"
    cat > "$file" << 'SCREENDOF'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/features/@FEATURE_NAME@/presentation/providers/@FEATURE_NAME@_provider.dart';

class @PASCAL_CASE@Screen extends ConsumerStatefulWidget {
  const @PASCAL_CASE@Screen({super.key});

  @override
  ConsumerState<@PASCAL_CASE@Screen> createState() => _@PASCAL_CASE@ScreenState();
}

class _@PASCAL_CASE@ScreenState extends ConsumerState<@PASCAL_CASE@Screen> {
  late final TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(@CAMEL_CASE@Provider);
    final data = state.dataOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('@PASCAL_CASE@'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Name',
                hintText: 'Enter a value',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: state.isLoading
                  ? null
                  : () {
                      ref.read(@CAMEL_CASE@Provider.notifier).run(
                            name: _nameController.text.trim(),
                          );
                    },
              child: state.isLoading
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Submit'),
            ),
            const SizedBox(height: 24),
            if (state.isError)
              Text(
                state.errorMessage ?? 'Unknown error',
                style: const TextStyle(color: Colors.red),
              ),
            if (data != null) ...[
              Text('Saved ID: \${data.id}'),
              Text('Saved Name: \${data.name}'),
            ],
          ],
        ),
      ),
    );
  }
}
SCREENDOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

  write_screen "$BASE_DIR/presentation/screens/${FEATURE_NAME}_screen.dart"
fi

echo -e "${GREEN}✓ Feature $FEATURE_NAME generated successfully!${NC}"
echo ""
echo -e "${YELLOW}Generated structure:${NC}"
echo -e "${CYAN}  $BASE_DIR/${NC}"
echo -e "    ├── data/"
echo -e "    │   ├── datasources/"
echo -e "    │   │   └── ${FEATURE_NAME}_remote_data_source.dart"
echo -e "    │   ├── models/"
echo -e "    │   │   └── ${FEATURE_NAME}_model.dart"
echo -e "    │   ├── dtos/"
echo -e "    │   │   ├── request/"
echo -e "    │   │   │   └── ${FEATURE_NAME}_request.dart"
echo -e "    │   │   ├── response/"
echo -e "    │   │   │   └── ${FEATURE_NAME}_response.dart"
echo -e "    │   │   └── dtos.dart"
echo -e "    │   └── repositories/"
echo -e "    │       └── ${FEATURE_NAME}_repository_impl.dart"
echo -e "    ├── domain/"
echo -e "    │   ├── entities/"
echo -e "    │   │   └── ${FEATURE_NAME}_entity.dart"
echo -e "    │   ├── repositories/"
echo -e "    │   │   └── ${FEATURE_NAME}_repository.dart"
echo -e "    │   └── usecases/"
echo -e "    │       └── ${FEATURE_NAME}_use_case.dart"
echo -e "    ├── application/"
echo -e "    │   ├── providers/"
echo -e "    │   │   ├── ${FEATURE_NAME}_data_providers.dart"
echo -e "    │   │   └── ${FEATURE_NAME}_di_provider.dart"
echo -e "    │   └── services/"
echo -e "    │       └── ${FEATURE_NAME}_service.dart"
echo -e "    └── presentation/"
echo -e "        ├── providers/"
echo -e "        │   └── ${FEATURE_NAME}_provider.dart"
if [[ "$WITH_UI" == "yes" ]]; then
echo -e "        └── screens/"
echo -e "            └── ${FEATURE_NAME}_screen.dart"
fi
echo ""
echo -e "${YELLOW}Next steps:${NC}"
echo -e "  ${BLUE}1. dart run build_runner build --delete-conflicting-outputs${NC}"
echo -e "  ${BLUE}2. Update API endpoints in ${BASE_DIR}/data/datasources/${FEATURE_NAME}_remote_data_source.dart${NC}"
echo -e "  ${BLUE}3. Add routes to the current app router if needed${NC}"
echo -e "  ${BLUE}4. Customize entity fields, models, DTOs, and use cases${NC}"
