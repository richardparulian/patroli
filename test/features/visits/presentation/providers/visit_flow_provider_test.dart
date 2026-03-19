import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:patroli/core/extensions/result_state_extension.dart';
import 'package:patroli/features/visits/application/services/visit_create_service.dart';
import 'package:patroli/features/visits/data/dtos/request/visit_request.dart';
import 'package:patroli/features/visits/domain/entities/visit_entity.dart';
import 'package:patroli/features/visits/presentation/providers/visit_flow_provider.dart';
import 'package:patroli/features/visits/presentation/providers/visit_form_provider.dart';

class MockVisitCreateService extends Mock implements VisitCreateService {}

class FakeVisitRequest extends Fake implements VisitRequest {}

void main() {
  late MockVisitCreateService mockVisitCreateService;
  late ProviderContainer container;
  late ProviderSubscription<VisitFlowState> visitFlowSubscription;

  const visitEntity = VisitEntity(id: 99);

  setUpAll(() {
    registerFallbackValue(FakeVisitRequest());
  });

  setUp(() {
    mockVisitCreateService = MockVisitCreateService();
    container = ProviderContainer(
      overrides: [
        visitCreateServiceProvider.overrideWithValue(mockVisitCreateService),
      ],
    );

    visitFlowSubscription = container.listen(
      visitFlowProvider,
      (previous, next) {},
    );
  });

  tearDown(() {
    visitFlowSubscription.close();
    container.dispose();
  });

  void fillValidForm() {
    final notifier = container.read(visitFormProvider.notifier);
    notifier.setLampuBanner('On');
    notifier.setBannerUtama('Good');
    notifier.setRollingDoor('Closed');
    notifier.setRollingDoorChecklist({'flashlight', 'knock'});
    notifier.setConditionRight('Safe');
    notifier.setConditionLeft('Safe');
    notifier.setConditionBack('Safe');
    notifier.setConditionAround('Quiet');
  }

  test(
    'submit returns false and populates validation errors when form invalid',
    () async {
      final didSubmit = await container
          .read(visitFlowProvider.notifier)
          .submit(reportId: 10, notes: 'note');

      final formState = container.read(visitFormProvider);
      expect(didSubmit, isFalse);
      expect(
        formState.errorKeyFor(VisitFormFields.lightsStatus),
        'visit_error_lights_required',
      );
      verifyNever(
        () => mockVisitCreateService.submit(
          request: any(named: 'request'),
          reportId: any(named: 'reportId'),
        ),
      );
    },
  );

  test(
    'submit sends request and stores submission result when form valid',
    () async {
      fillValidForm();
      when(
        () => mockVisitCreateService.submit(
          request: any(named: 'request'),
          reportId: 10,
        ),
      ).thenAnswer((_) async => const Success(visitEntity));

      final didSubmit = await container
          .read(visitFlowProvider.notifier)
          .submit(reportId: 10, notes: 'catatan');

      final state = container.read(visitFlowProvider);
      expect(didSubmit, isTrue);
      expect(state.submissionState, isA<Success<VisitEntity>>());
      verify(
        () => mockVisitCreateService.submit(
          request: any(named: 'request'),
          reportId: 10,
        ),
      ).called(1);
    },
  );
}
