import 'package:pigeon/pigeon.dart';

// dart run pigeon --input pigeon/ekyc.dart
@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/ekyc.g.dart',
  dartOptions: DartOptions(),
  kotlinOut: 'android/src/main/kotlin/com/example/wise_ai_ekyc/ekyc.g.kt',
  kotlinOptions: KotlinOptions(),
  swiftOut: 'ios/Classes/ekyc.g.swift',
  swiftOptions: SwiftOptions(),
))
class PEkycRequest {
  final String countryCode;
  final String idType;
  final bool backCamera;

  PEkycRequest({
    required this.countryCode,
    required this.idType,
    required this.backCamera,
  });
}

class PEkycConfig {
  final String token;
  final String endpoint;

  PEkycConfig({
    required this.token,
    required this.endpoint,
  });
}

@HostApi()
abstract class EkycHostApi {
  @async
  String getPlatformVersion();

  @async
  void initialize(PEkycConfig config);

  @async
  String performEkyc(PEkycRequest request);
}
