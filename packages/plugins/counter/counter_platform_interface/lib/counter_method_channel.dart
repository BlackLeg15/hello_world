import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'counter_platform_interface.dart';

/// An implementation of [CounterPlatform] that uses method channels.
class MethodChannelCounter extends CounterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('counter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
