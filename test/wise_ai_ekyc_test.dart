import 'package:flutter_test/flutter_test.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_platform_interface.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWiseAiEkycPlatform
    with MockPlatformInterfaceMixin
    implements WiseAiEkycPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final WiseAiEkycPlatform initialPlatform = WiseAiEkycPlatform.instance;

  test('$MethodChannelWiseAiEkyc is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWiseAiEkyc>());
  });

  test('getPlatformVersion', () async {
    WiseAiEkyc wiseAiEkycPlugin = WiseAiEkyc();
    MockWiseAiEkycPlatform fakePlatform = MockWiseAiEkycPlatform();
    WiseAiEkycPlatform.instance = fakePlatform;

    expect(await wiseAiEkycPlugin.getPlatformVersion(), '42');
  });
}
