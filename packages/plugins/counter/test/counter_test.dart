import 'package:flutter_test/flutter_test.dart';
import 'package:counter/counter.dart';
import 'package:counter/counter_platform_interface.dart';
import 'package:counter/counter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockCounterPlatform
    with MockPlatformInterfaceMixin
    implements CounterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final CounterPlatform initialPlatform = CounterPlatform.instance;

  test('$MethodChannelCounter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelCounter>());
  });

  test('getPlatformVersion', () async {
    Counter counterPlugin = Counter();
    MockCounterPlatform fakePlatform = MockCounterPlatform();
    CounterPlatform.instance = fakePlatform;

    expect(await counterPlugin.getPlatformVersion(), '42');
  });
}
