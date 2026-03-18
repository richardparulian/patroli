library;

import 'dart:io';

class FeatureGenerator {
  FeatureGenerator({
    required this.featureName,
    this.withUi = true,
    this.withTests = true,
    this.withDocs = true,
  })  : pascalCase = _toPascalCase(featureName),
        camelCase = _toCamelCase(featureName);

  final String featureName;
  final bool withUi;
  final bool withTests;
  final bool withDocs;
  final String pascalCase;
  final String camelCase;

  Future<void> generate() async {
    stdout.writeln('Generating feature: $featureName');
    await _createDirectories();
    await _createFiles();
    stdout.writeln('Feature $featureName generated successfully!');
  }

  Future<void> _createDirectories() async {
    final baseDir = 'lib/features/$featureName';

    await _createDir('$baseDir/data/datasources');
    await _createDir('$baseDir/data/models');
    await _createDir('$baseDir/data/dtos/request');
    await _createDir('$baseDir/data/dtos/response');
    await _createDir('$baseDir/data/repositories');
    await _createDir('$baseDir/domain/entities');
    await _createDir('$baseDir/domain/repositories');
    await _createDir('$baseDir/domain/usecases');
    await _createDir('$baseDir/application/providers');
    await _createDir('$baseDir/application/services');
    await _createDir('$baseDir/presentation/providers');
    await _createDir('$baseDir/presentation/screens');

    if (withTests) {
      await _createDir('test/features/$featureName/data');
      await _createDir('test/features/$featureName/domain');
      await _createDir('test/features/$featureName/presentation');
    }

    if (withDocs) {
      await _createDir('docs/features');
    }
  }

  Future<void> _createFiles() async {
    final baseDir = 'lib/features/$featureName';

    await _createFile('$baseDir/domain/entities/${featureName}_entity.dart', '''
import 'package:freezed_annotation/freezed_annotation.dart';

part '${featureName}_entity.freezed.dart';

@freezed
abstract class ${pascalCase}Entity with _\$${pascalCase}Entity {
  const factory ${pascalCase}Entity({
    required int id,
    required String name,
  }) = _${pascalCase}Entity;

  factory ${pascalCase}Entity.empty() => const ${pascalCase}Entity(id: 0, name: '');
}
''');

    await _createFile('$baseDir/domain/repositories/${featureName}_repository.dart', '''
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/$featureName/data/dtos/request/${featureName}_request.dart';
import '../entities/${featureName}_entity.dart';

abstract class ${pascalCase}Repository {
  Future<Either<Failure, ${pascalCase}Entity>> submit(${pascalCase}Request request);
}
''');

    await _createFile('$baseDir/domain/usecases/${featureName}_use_case.dart', '''
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/core/usecases/usecase.dart';
import 'package:patroli/features/$featureName/data/dtos/request/${featureName}_request.dart';
import 'package:patroli/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:patroli/features/$featureName/domain/repositories/${featureName}_repository.dart';

class Create${pascalCase}Params extends Equatable {
  const Create${pascalCase}Params({
    required this.request,
  });

  final ${pascalCase}Request request;

  @override
  List<Object?> get props => [request];
}

class Create${pascalCase}UseCase implements UseCase<${pascalCase}Entity, Create${pascalCase}Params> {
  Create${pascalCase}UseCase(this._repository);

  final ${pascalCase}Repository _repository;

  @override
  Future<Either<Failure, ${pascalCase}Entity>> call(Create${pascalCase}Params params) {
    return _repository.submit(params.request);
  }
}
''');

    await _createFile('$baseDir/data/models/${featureName}_model.dart', '''
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:patroli/features/$featureName/domain/entities/${featureName}_entity.dart';

part '${featureName}_model.freezed.dart';
part '${featureName}_model.g.dart';

@freezed
abstract class ${pascalCase}Model with _\$${pascalCase}Model {
  const ${pascalCase}Model._();

  const factory ${pascalCase}Model({
    required int id,
    required String name,
  }) = _${pascalCase}Model;

  factory ${pascalCase}Model.fromJson(Map<String, dynamic> json) =>
      _\$${pascalCase}ModelFromJson(json);

  ${pascalCase}Entity toEntity() => ${pascalCase}Entity(id: id, name: name);
}
''');

    await _createFile('$baseDir/data/dtos/request/${featureName}_request.dart', '''
import 'package:json_annotation/json_annotation.dart';

part '${featureName}_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ${pascalCase}Request {
  ${pascalCase}Request({
    required this.name,
  });

  final String name;

  factory ${pascalCase}Request.fromJson(Map<String, dynamic> json) =>
      _\$${pascalCase}RequestFromJson(json);

  Map<String, dynamic> toJson() => _\$${pascalCase}RequestToJson(this);

  @override
  String toString() => '$pascalCase(name: \$name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ${pascalCase}Request && other.name == name;
  }

  @override
  int get hashCode => Object.hash(name, runtimeType);
}
''');

    await _createFile('$baseDir/data/dtos/response/${featureName}_response.dart', '''
import 'package:json_annotation/json_annotation.dart';
import '../../models/${featureName}_model.dart';

part '${featureName}_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ${pascalCase}Response {
  ${pascalCase}Response({
    required this.$camelCase,
  });

  final ${pascalCase}Model $camelCase;

  factory ${pascalCase}Response.fromJson(Map<String, dynamic> json) =>
      _\$${pascalCase}ResponseFromJson(json);

  Map<String, dynamic> toJson() => _\$${pascalCase}ResponseToJson(this);

  @override
  String toString() => '$pascalCase($camelCase: \$$camelCase)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ${pascalCase}Response && other.$camelCase == $camelCase;
  }

  @override
  int get hashCode => Object.hash($camelCase, runtimeType);
}
''');

    await _createFile('$baseDir/data/dtos/dtos.dart', '''
library;

export 'request/${featureName}_request.dart';
export 'response/${featureName}_response.dart';
''');

    await _createFile('$baseDir/data/datasources/${featureName}_remote_data_source.dart', '''
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/$featureName/data/dtos/request/${featureName}_request.dart';
import 'package:patroli/features/$featureName/data/dtos/response/${featureName}_response.dart';
import '../models/${featureName}_model.dart';

abstract class ${pascalCase}RemoteDataSource {
  Future<${pascalCase}Model> submit$pascalCase(${pascalCase}Request request);
}

class ${pascalCase}RemoteDataSourceImpl implements ${pascalCase}RemoteDataSource {
  ${pascalCase}RemoteDataSourceImpl(this._apiClient);

  final ApiClient _apiClient;

  @override
  Future<${pascalCase}Model> submit$pascalCase(${pascalCase}Request request) async {
    final result = await _apiClient.post('/$featureName', data: request.toJson());

    return result.fold(
      (failure) => throw Exception(failure.message),
      (response) => ${pascalCase}Response.fromJson(response).$camelCase,
    );
  }
}
''');

    await _createFile('$baseDir/data/repositories/${featureName}_repository_impl.dart', '''
import 'package:fpdart/fpdart.dart';
import 'package:patroli/core/error/exceptions.dart';
import 'package:patroli/core/error/failures.dart';
import 'package:patroli/features/$featureName/data/datasources/${featureName}_remote_data_source.dart';
import 'package:patroli/features/$featureName/data/dtos/request/${featureName}_request.dart';
import 'package:patroli/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:patroli/features/$featureName/domain/repositories/${featureName}_repository.dart';

class ${pascalCase}RepositoryImpl implements ${pascalCase}Repository {
  ${pascalCase}RepositoryImpl(this._remoteDataSource);

  final ${pascalCase}RemoteDataSource _remoteDataSource;

  @override
  Future<Either<Failure, ${pascalCase}Entity>> submit(${pascalCase}Request request) async {
    try {
      final model = await _remoteDataSource.submit$pascalCase(request);
      return Right(model.toEntity());
    } on ServerException {
      return Left(ServerFailure(message: 'Failed to submit $featureName'));
    } on NetworkException {
      return Left(NetworkFailure(message: 'No internet connection'));
    } on Exception catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}
''');

    await _createFile('$baseDir/application/providers/${featureName}_data_providers.dart', '''
import 'package:patroli/app/network/network_providers.dart';
import 'package:patroli/core/network/api_client.dart';
import 'package:patroli/features/$featureName/data/datasources/${featureName}_remote_data_source.dart';
import 'package:patroli/features/$featureName/data/repositories/${featureName}_repository_impl.dart';
import 'package:patroli/features/$featureName/domain/repositories/${featureName}_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_data_providers.g.dart';

@riverpod
ApiClient ${camelCase}ApiClient(Ref ref) {
  final dio = ref.watch(dioWithAuthProvider);
  return ApiClient(dio);
}

@riverpod
${pascalCase}RemoteDataSource ${camelCase}RemoteDataSource(Ref ref) {
  final apiClient = ref.watch(${camelCase}ApiClientProvider);
  return ${pascalCase}RemoteDataSourceImpl(apiClient);
}

@riverpod
${pascalCase}Repository ${camelCase}Repository(Ref ref) {
  final remoteDataSource = ref.watch(${camelCase}RemoteDataSourceProvider);
  return ${pascalCase}RepositoryImpl(remoteDataSource);
}
''');

    await _createFile('$baseDir/application/providers/${featureName}_di_provider.dart', '''
import 'package:patroli/features/$featureName/application/providers/${featureName}_data_providers.dart';
import 'package:patroli/features/$featureName/domain/usecases/${featureName}_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_di_provider.g.dart';

@riverpod
Create${pascalCase}UseCase ${camelCase}UseCase(Ref ref) {
  return Create${pascalCase}UseCase(ref.watch(${camelCase}RepositoryProvider));
}
''');

    await _createFile('$baseDir/application/services/${featureName}_service.dart', '''
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/$featureName/application/providers/${featureName}_di_provider.dart';
import 'package:patroli/features/$featureName/data/dtos/request/${featureName}_request.dart';
import 'package:patroli/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:patroli/features/$featureName/domain/usecases/${featureName}_use_case.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_service.g.dart';

class ${pascalCase}Service {
  ${pascalCase}Service(this.ref);

  final Ref ref;

  Future<ResultState<${pascalCase}Entity>> submit({
    required String name,
  }) async {
    try {
      final useCase = ref.read(${camelCase}UseCaseProvider);
      final result = await useCase(
        Create${pascalCase}Params(
          request: ${pascalCase}Request(name: name),
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
${pascalCase}Service ${camelCase}Service(Ref ref) {
  return ${pascalCase}Service(ref);
}
''');

    await _createFile('$baseDir/presentation/providers/${featureName}_provider.dart', '''
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/$featureName/application/services/${featureName}_service.dart';
import 'package:patroli/features/$featureName/domain/entities/${featureName}_entity.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part '${featureName}_provider.g.dart';

@riverpod
class $pascalCase extends _\$${pascalCase} {
  @override
  ResultState<${pascalCase}Entity> build() {
    return const Idle();
  }

  Future<void> run({required String name}) async {
    state = const Loading();
    state = await ref.read(${camelCase}ServiceProvider).submit(name: name);
  }
}
''');

    if (withUi) {
      await _createFile('$baseDir/presentation/screens/${featureName}_screen.dart', '''
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patroli/core/extensions/helper_state_extension.dart';
import 'package:patroli/features/$featureName/presentation/providers/${featureName}_provider.dart';

class ${pascalCase}Screen extends ConsumerStatefulWidget {
  const ${pascalCase}Screen({super.key});

  @override
  ConsumerState<${pascalCase}Screen> createState() => _${pascalCase}ScreenState();
}

class _${pascalCase}ScreenState extends ConsumerState<${pascalCase}Screen> {
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
    final state = ref.watch(${camelCase}Provider);
    final data = state.dataOrNull;

    return Scaffold(
      appBar: AppBar(
        title: const Text('$pascalCase'),
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
                      ref.read(${camelCase}Provider.notifier).run(
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
''');
    }
  }

  Future<void> _createDir(String path) async {
    final dir = Directory(path);
    if (!await dir.exists()) {
      await dir.create(recursive: true);
      stdout.writeln('Created directory: $path');
    }
  }

  Future<void> _createFile(String path, String content) async {
    final file = File(path);
    await file.writeAsString(content);
    stdout.writeln('Created file: $path');
  }

  static String _toPascalCase(String input) {
    return input
        .split('_')
        .map((word) => word.isEmpty ? '' : word[0].toUpperCase() + word.substring(1).toLowerCase())
        .join();
  }

  static String _toCamelCase(String input) {
    final pascal = _toPascalCase(input);
    return pascal.isEmpty ? '' : pascal[0].toLowerCase() + pascal.substring(1);
  }
}

void main(List<String> args) {
  if (args.isEmpty) {
    stdout.writeln('Please provide a feature name in snake_case format.');
    return;
  }

  final generator = FeatureGenerator(featureName: args.first);
  generator.generate();
}
