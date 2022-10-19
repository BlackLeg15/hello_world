import 'package:core/src/analytics/analytics_error.dart';
import 'package:core/src/analytics/analytics_event_type.dart';

abstract class AnalyticsService {
  Future<AnalyticsError?> screenOpened(Object parameters);
  Future<AnalyticsError?> logEvent(AnalyticsEventType eventType, Object parameters);
}
