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
mkdir -p "$BASE_DIR/presentation/controllers"
mkdir -p "$BASE_DIR/presentation/providers"
mkdir -p "$BASE_DIR/presentation/screens"

if [[ "$WITH_UI" == "yes" ]]; then
  mkdir -p "$BASE_DIR/presentation/widgets"
fi

# ==========================================
# Domain Layer
# ==========================================

# Entity
write_entity() {
  local file="$1"
  cat > "$file" << 'ENTITYEOF'
import 'package:equatable/equatable.dart';
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
import '../entities/@FEATURE_NAME@_entity.dart';

abstract class @PASCAL_CASE@Repository {
  Future<Either<Failure, List<@PASCAL_CASE@Entity>>> get@PASCAL_CASE@s();
  Future<Either<Failure, @PASCAL_CASE@Entity>> get@PASCAL_CASE@(int id);
}
REPOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_repository_interface "$BASE_DIR/domain/repositories/${FEATURE_NAME}_repository.dart"

# UseCase - Get All
write_usecase_getall() {
  local file="$1"
  cat > "$file" << 'USECASEEOF'
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';

class Get@PASCAL_CASE@sUseCase implements UseCase<List<@PASCAL_CASE@Entity>, NoParams> {
  final @PASCAL_CASE@Repository _repository;

  Get@PASCAL_CASE@sUseCase(this._repository);

  @override
  Future<Either<Failure, List<@PASCAL_CASE@Entity>>> call(NoParams params) {
    return _repository.get@PASCAL_CASE@s();
  }
}
USECASEEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_usecase_getall "$BASE_DIR/domain/usecases/get_${FEATURE_NAME}s_use_case.dart"

# UseCase - Get By ID
write_usecase_getbyid() {
  local file="$1"
  cat > "$file" << 'USECASEEOF'
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';

// :: Parameters for get @FEATURE_NAME@ by id use case
class Get@PASCAL_CASE@ByIdParams extends Equatable {
  final int id;

  const Get@PASCAL_CASE@ByIdParams({required this.id});

  @override
  List<Object?> get props => [id];
}

class Get@PASCAL_CASE@ByIdUseCase implements UseCase<@PASCAL_CASE@Entity, Get@PASCAL_CASE@ByIdParams> {
  final @PASCAL_CASE@Repository _repository;

  Get@PASCAL_CASE@ByIdUseCase(this._repository);

  @override
  Future<Either<Failure, @PASCAL_CASE@Entity>> call(Get@PASCAL_CASE@ByIdParams params) {
    return _repository.get@PASCAL_CASE@(params.id);
  }
}
USECASEEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
}

write_usecase_getbyid "$BASE_DIR/domain/usecases/get_${FEATURE_NAME}_by_id_use_case.dart"

# ==========================================
# Data Layer
# ==========================================

# Model
write_model() {
  local file="$1"
  cat > "$file" << 'MODELEOF'
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
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
  final @PASCAL_CASE@Model @FEATURE_NAME@;

  @PASCAL_CASE@Response({
    required this.@FEATURE_NAME@,
  });

  factory @PASCAL_CASE@Response.fromJson(Map<String, dynamic> json) =>
      _$@PASCAL_CASE@ResponseFromJson(json);

  Map<String, dynamic> toJson() => _$@PASCAL_CASE@ResponseToJson(this);

  @override
  String toString() => '@PASCAL_CASE@(@FEATURE_NAME@: $@FEATURE_NAME@)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is @PASCAL_CASE@Response && other.@FEATURE_NAME@ == @FEATURE_NAME@;
  }

  @override
  int get hashCode => Object.hash(@FEATURE_NAME@, runtimeType);
}
RESPDTOEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/core/network/api_endpoints.dart';
import 'package:patroli/core/providers/network_providers.dart';
import '../models/@FEATURE_NAME@_model.dart';

abstract class @PASCAL_CASE@RemoteDataSource {
  // :: Fetch all @FEATURE_NAME@s
  Future<List<@PASCAL_CASE@Model>> fetch@PASCAL_CASE@s();
  Future<@PASCAL_CASE@Model> fetch@PASCAL_CASE@(int id);
}

class @PASCAL_CASE@RemoteDataSourceImpl implements @PASCAL_CASE@RemoteDataSource {
  final ApiClient _apiClient;

  @PASCAL_CASE@RemoteDataSourceImpl(this._apiClient);

  @override
  Future<List<@PASCAL_CASE@Model>> fetch@PASCAL_CASE@s() async {
    final result = await _apiClient.get('/@FEATURE_NAME@s');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) {
        final List<dynamic> data = response;
        return data
            .map((json) => @PASCAL_CASE@Model.fromJson(json))
            .toList();
      },
    );
  }

  @override
  Future<@PASCAL_CASE@Model> fetch@PASCAL_CASE@(int id) async {
    final result = await _apiClient.get('/@FEATURE_NAME@s/$id');

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => @PASCAL_CASE@Model.fromJson(response),
    );
  }
}

// Provider
final @CAMEL_CASE@RemoteDataSourceProvider =
    Provider<@PASCAL_CASE@RemoteDataSource>((ref) {
  final apiClient = ref.watch(apiClientProvider);
  return @PASCAL_CASE@RemoteDataSourceImpl(apiClient);
});
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
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/datasources/@FEATURE_NAME@_remote_data_source.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/models/@FEATURE_NAME@_model.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/repositories/@FEATURE_NAME@_repository.dart';

class @PASCAL_CASE@RepositoryImpl implements @PASCAL_CASE@Repository {
  final @PASCAL_CASE@RemoteDataSource _remoteDataSource;

  @PASCAL_CASE@RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, List<@PASCAL_CASE@Entity>>> get@PASCAL_CASE@s() async {
    try {
      final models = await _remoteDataSource.fetch@PASCAL_CASE@s();
      return Right(models.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch @FEATURE_NAME@s'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, @PASCAL_CASE@Entity>> get@PASCAL_CASE@(int id) async {
    try {
      final model = await _remoteDataSource.fetch@PASCAL_CASE@(id);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to fetch @FEATURE_NAME@'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

// Provider
final @CAMEL_CASE@RepositoryProvider =
    Provider<@PASCAL_CASE@Repository>((ref) {
  final remoteDataSource = ref.watch(@CAMEL_CASE@RemoteDataSourceProvider);
  return @PASCAL_CASE@RepositoryImpl(remoteDataSource);
});
REPOIMPLEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_repository_impl "$BASE_DIR/data/repositories/${FEATURE_NAME}_repository_impl.dart"

# ==========================================
# Presentation Layer - Providers (DI)
# ==========================================

write_di_provider() {
  local file="$1"
  cat > "$file" << 'DIPROVEOF'
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/features/@FEATURE_NAME@/data/repositories/@FEATURE_NAME@_repository_impl.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/get_@FEATURE_NAME@s_use_case.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/get_@FEATURE_NAME@_by_id_use_case.dart';

final get@PASCAL_CASE@sUseCaseProvider = Provider<Get@PASCAL_CASE@sUseCase>((ref) {
  return Get@PASCAL_CASE@sUseCase(ref.watch(@CAMEL_CASE@RepositoryProvider));
});

final get@PASCAL_CASE@ByIdUseCaseProvider = Provider<Get@PASCAL_CASE@ByIdUseCase>((ref) {
  return Get@PASCAL_CASE@ByIdUseCase(ref.watch(@CAMEL_CASE@RepositoryProvider));
});
DIPROVEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_di_provider "$BASE_DIR/presentation/providers/${FEATURE_NAME}_di_provider.dart"

# ==========================================
# Presentation Layer - Controllers
# ==========================================

write_controller() {
  local file="$1"
  cat > "$file" << 'CONTROLEOF'
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/get_@FEATURE_NAME@s_use_case.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/usecases/get_@FEATURE_NAME@_by_id_use_case.dart';
import 'package:patroli/features/@FEATURE_NAME@/presentation/providers/@FEATURE_NAME@_di_provider.dart';

class @PASCAL_CASE@Controller extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  // :: Fetch all @FEATURE_NAME@s
  Future<Either<String, List<@PASCAL_CASE@Entity>>> fetch@PASCAL_CASE@s() async {
    final useCase = ref.read(get@PASCAL_CASE@sUseCaseProvider);

    final result = await useCase(NoParams());

    return result.fold(
      (failure) => Left(failure.message),
      (entities) => Right(entities),
    );
  }

  // :: Fetch @FEATURE_NAME@ by ID
  Future<Either<String, @PASCAL_CASE@Entity>> fetch@PASCAL_CASE@ById(int id) async {
    final useCase = ref.read(get@PASCAL_CASE@ByIdUseCaseProvider);

    final result = await useCase(Get@PASCAL_CASE@ByIdParams(id: id));

    return result.fold(
      (failure) => Left(failure.message),
      (entity) => Right(entity),
    );
  }
}

final @CAMEL_CASE@ControllerProvider =
    AsyncNotifierProvider<@PASCAL_CASE@Controller, void>(
        @PASCAL_CASE@Controller.new);
CONTROLEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_controller "$BASE_DIR/presentation/controllers/${FEATURE_NAME}_controller.dart"

# ==========================================
# Presentation Layer - Providers (State)
# ==========================================

write_state_provider() {
  local file="$1"
  cat > "$file" << 'STATEPROVEOF'
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';

class @PASCAL_CASE@ListNotifier extends Notifier<AsyncValue<List<@PASCAL_CASE@Entity>>> {
  @override
  AsyncValue<List<@PASCAL_CASE@Entity>> build() {
    return const AsyncValue.loading();
  }

  Future<void> load@PASCAL_CASE@s() async {
    final controller = ref.read(@CAMEL_CASE@ControllerProvider.notifier);

    final result = await controller.fetch@PASCAL_CASE@s();

    result.fold(
      (error) {
        state = AsyncValue.error(error, StackTrace.current);
      },
      (entities) {
        state = AsyncValue.data(entities);
      },
    );
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    await load@PASCAL_CASE@s();
  }

  void clear() {
    state = const AsyncValue.data([]);
  }
}

final @CAMEL_CASE@ListProvider =
    NotifierProvider<@PASCAL_CASE@ListNotifier, AsyncValue<List<@PASCAL_CASE@Entity>>>(
        @PASCAL_CASE@ListNotifier.new);
STATEPROVEOF
  sed -i '' "s/@FEATURE_NAME@/$FEATURE_NAME/g" "$file"
  sed -i '' "s/@PASCAL_CASE@/$PASCAL_CASE/g" "$file"
  sed -i '' "s/@CAMEL_CASE@/$CAMEL_CASE/g" "$file"
}

write_state_provider "$BASE_DIR/presentation/providers/${FEATURE_NAME}_state_provider.dart"

# ==========================================
# Presentation Layer - Screens
# ==========================================

if [[ "$WITH_UI" == "yes" ]]; then
  write_screen() {
    local file="$1"
    cat > "$file" << 'SCREENDOF'
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/features/@FEATURE_NAME@/domain/entities/@FEATURE_NAME@_entity.dart';
import 'package:patroli/features/@FEATURE_NAME@/presentation/providers/@FEATURE_NAME@_state_provider.dart';

class @PASCAL_CASE@Screen extends ConsumerStatefulWidget {
  const @PASCAL_CASE@Screen({super.key});

  @override
  ConsumerState<@PASCAL_CASE@Screen> createState() =>
      _@PASCAL_CASE@ScreenState();
}

class _@PASCAL_CASE@ScreenState extends ConsumerState<@PASCAL_CASE@Screen> {
  @override
  void initState() {
    super.initState();
    // Load @FEATURE_NAME@s when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(@CAMEL_CASE@ListProvider.notifier).load@PASCAL_CASE@s();
    });
  }

  @override
  Widget build(BuildContext context) {
    final @CAMEL_CASE@ListState = ref.watch(@CAMEL_CASE@ListProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('@PASCAL_CASE@'),
      ),
      body: @CAMEL_CASE@ListState.when(
        data: (items) {
          if (items.isEmpty) {
            return const Center(
              child: Text('No @FEATURE_NAME@s found'),
            );
          }

          return ListView.builder(
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return ListTile(
                title: Text(item.name),
                subtitle: Text('ID: \${item.id}'),
                leading: const CircleAvatar(
                  child: Icon(Icons.list),
                ),
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(
                'Error: \$error',
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  ref
                      .read(@CAMEL_CASE@ListProvider.notifier)
                      .load@PASCAL_CASE@s();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.read(@CAMEL_CASE@ListProvider.notifier).refresh();
        },
        child: const Icon(Icons.refresh),
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
echo -e "    │       ├── get_${FEATURE_NAME}s_use_case.dart"
echo -e "    │       └── get_${FEATURE_NAME}_by_id_use_case.dart"
echo -e "    └── presentation/"
echo -e "        ├── providers/"
echo -e "        │   ├── ${FEATURE_NAME}_di_provider.dart"
echo -e "        ├── controllers/"
echo -e "        │   └── ${FEATURE_NAME}_controller.dart"
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
