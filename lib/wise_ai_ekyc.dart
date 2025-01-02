import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:wise_ai_ekyc/ekyc_config.dart';
import 'package:wise_ai_ekyc/ekyc_request.dart';
import 'package:wise_ai_ekyc/src/ekyc.g.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc_platform_interface.dart';

class WiseAiEkyc {
  Future<String?> getPlatformVersion() {
    return WiseAiEkycPlatform.instance.getPlatformVersion();
  }

  Future<void> initialize({required EkycConfig config}) async {
    final pigeonConfig = PEkycConfig(token: config.token, endpoint: config.endpoint);
    await WiseAiEkycPlatform.instance.initialize(pigeonConfig);
  }

  Future<String> performEkyc({required EkycRequest request}) async {
    try {
      final pigeonRequest = PEkycRequest(
        countryCode: request.countryCode,
        idType: request.idType,
        backCamera: request.backCamera,
      );
      return await WiseAiEkycPlatform.instance.performEkyc(pigeonRequest);
    } on PlatformException catch (ex) {
      final exception = {ex.code: ex.message};
      return json.encode(exception);
    }
  }
}
