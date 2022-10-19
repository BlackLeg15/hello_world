import 'analytics_event_type.dart';

abstract class AnalyticsError {
  final AnalyticsEventType eventType;
  final Object parameters;

  const AnalyticsError({required this.parameters, required this.eventType});

  @override
  String toString() => "Couldn't log event. Type: $eventType";
}

class AnalyticsLogEventError extends AnalyticsError {
  const AnalyticsLogEventError({required super.eventType, required super.parameters});
}
