import 'package:core/core.dart';
import 'package:dependencies/dependencies.dart';
import 'package:firebase_analytics_service/firebase_analytics_service.dart';
import 'package:flutter/material.dart';

import 'app/app_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
