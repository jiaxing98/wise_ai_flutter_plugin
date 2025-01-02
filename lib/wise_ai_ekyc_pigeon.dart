import 'package:wise_ai_ekyc/src/ekyc.g.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_platform_interface.dart';

/// An implementation of [WiseAiEkycPlatform] that uses Pigeon.
class PigeonWiseAiEkyc extends WiseAiEkycPlatform {
  final EkycHostApi _api = EkycHostApi();

  @override
  Future<String> getPlatformVersion() {
    return _api.getPlatformVersion();
  }

  @override
  Future<void> initialize(PEkycConfig config) async {
    await _api.initialize(config);
  }

  @override
  Future<String> performEkyc(PEkycRequest request) async {
    return await _api.performEkyc(request);
  }
}
