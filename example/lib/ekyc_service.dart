import 'package:wise_ai_ekyc/ekyc_config.dart';
import 'package:wise_ai_ekyc/ekyc_request.dart';
import 'package:wise_ai_ekyc/wise_ai_ekyc.dart';
import 'package:wise_ai_ekyc_example/env.dart';

class EkycService {
  final _wiseAiEkycPlugin = WiseAiEkyc();

  final _config = const EkycConfig(
    token: Environment.token,
    endpoint: Environment.endpoint,
  );

  Future<String?> getPlatformVersion() async {
    return await _wiseAiEkycPlugin.getPlatformVersion();
  }

  Future<void> initialize() async {
    await _wiseAiEkycPlugin.initialize(config: _config);
  }

  Future<String> performMyKadEkyc() async {
    try {
      const request = EkycRequest(countryCode: "MYS", idType: "ID");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performPassportEkyc() async {
    try {
      const request = EkycRequest(countryCode: "", idType: "PASSPORT");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performMilitaryEkyc() async {
    try {
      const request = EkycRequest(countryCode: "MYS", idType: "TENTERA");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performMyPREkyc() async {
    try {
      const request = EkycRequest(countryCode: "MYS", idType: "PR");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performMyKasEkyc() async {
    try {
      const request = EkycRequest(countryCode: "MYS", idType: "KAS");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performIMM13Ekyc() async {
    try {
      const request = EkycRequest(countryCode: "MYS", idType: "WP");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performEmpPassEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "EMP_PASS");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSPassEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "SPASS");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGStudentEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "STUDENT");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGWPEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "WP");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGNRICEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "NRIC");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGLongTermVisitEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "LONGT_VISIT");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGDependantPassEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "DPD");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGArmedForceEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "11B");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }

  Future<String> performSGOverseasEkyc() async {
    try {
      const request = EkycRequest(countryCode: "SGP", idType: "Overseas");
      return await _wiseAiEkycPlugin.performEkyc(request: request);
    } catch (ex) {
      return ex.toString();
    }
  }
}
