import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelWiseAiEkyc platform = MethodChannelWiseAiEkyc();
  const MethodChannel channel = MethodChannel('wise_ai_ekyc');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
