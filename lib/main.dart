import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:firebase_analytics_service/firebase_analytics_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

void mobxStateChangesListener(SpyEvent event) {
  if (event is ObservableValueSpyEvent) {
    debugPrint(event.toString());
  }
  if (event is ActionSpyEvent) {
    debugPrint(event.toString());
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kDebugMode) {
    mainContext.config = mainContext.config.clone(isSpyEnabled: true);
    mainContext.spy(mobxStateChangesListener);
  }

  final firebaseApp = await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final analytics = FirebaseAnalyticsService(firebaseApp: firebaseApp);

  runApp(AppFeature(
    baseDependencies: {
      AnalyticsService: analytics,
    },
  ));
}

class AppFeature extends Feature {
  @override
  Widget get child => const AppWidget();

  @override
  Map<Type, Object> dependencies({DependencyInjectionWidget? injector}) {
    return baseDependencies;
  }

  final Map<Type, Object> baseDependencies;

  const AppFeature({super.key, this.baseDependencies = const {}});
}
