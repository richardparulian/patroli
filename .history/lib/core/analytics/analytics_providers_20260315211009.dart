export 'package:patroli/app/analytics/analytics_providers.dart';

/// A widget that automatically tracks screen views
class AnalyticsScreenView extends StatefulWidget {
  final String screenName;
  final Map<String, dynamic>? parameters;
  final Widget child;

  const AnalyticsScreenView({
    super.key,
    required this.screenName,
    this.parameters,
    required this.child,
  });

  @override
  State<AnalyticsScreenView> createState() => _AnalyticsScreenViewState();
}

class _AnalyticsScreenViewState extends State<AnalyticsScreenView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final analytics = ProviderScope.containerOf(context).read(analyticsProvider);
      analytics.logScreenView(widget.screenName, parameters: widget.parameters);
    });
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
