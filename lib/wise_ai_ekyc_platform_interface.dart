import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:wise_ai_ekyc/src/ekyc.g.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_pigeon.dart';

abstract class WiseAiEkycPlatform extends PlatformInterface {
  /// Constructs a WiseAiEkycPlatform.
  WiseAiEkycPlatform() : super(token: _token);

  static final Object _token = Object();

  static WiseAiEkycPlatform _instance = PigeonWiseAiEkyc();

  /// The default instance of [WiseAiEkycPlatform] to use.
  ///
  /// Defaults to [PigeonWiseAiEkyc].
  static WiseAiEkycPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WiseAiEkycPlatform] when
  /// they register themselves.
  static set instance(WiseAiEkycPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initialize(PEkycConfig config) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String> performEkyc(PEkycRequest request) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
