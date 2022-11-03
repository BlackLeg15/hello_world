import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:counter_platform_interface/counter_method_channel.dart';

void main() {
  MethodChannelCounter platform = MethodChannelCounter();
  const MethodChannel channel = MethodChannel('counter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
