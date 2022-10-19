import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';

class FirebaseAnalyticsService extends AnalyticsService {
  late final FirebaseAnalytics _firebaseAnalytics;

  FirebaseAnalyticsService._();

  static FirebaseAnalyticsService _instance(FirebaseApp app) =>
      FirebaseAnalyticsService._().._firebaseAnalytics = FirebaseAnalytics.instanceFor(app: app);

  factory FirebaseAnalyticsService({required FirebaseApp firebaseApp}) => _instance(firebaseApp);

  @override
  Future<AnalyticsError?> logEvent(AnalyticsEventType eventType, Object parameters) async {
    Map<String, Object?>? parametersToSend;
    if (parameters is Map<String, Object?>) {
      parametersToSend = parameters;
    }
    try {
      await _firebaseAnalytics.logEvent(name: eventType.name, parameters: parametersToSend);
    } on FirebaseException {
      return AnalyticsLogEventError(eventType: eventType, parameters: parameters);
    } catch (e) {
      return AnalyticsLogEventError(eventType: eventType, parameters: parameters);
    }
    return null;
  }

  @override
  Future<AnalyticsError?> screenOpened(Object parameters) {
    return logEvent(AnalyticsEventType.screenOpened, parameters);
  }
}
