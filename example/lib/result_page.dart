import 'dart:convert';

import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final String result;

  const ResultPage({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final jsonStr = _decodeResult(result);
    if (jsonStr.isEmpty) Navigator.pop(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("eKYC Result"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ListView(
              children: [
                Text(jsonStr),
                const SizedBox(height: 16.0),
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Back'),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _decodeResult(String result) {
    const encoder = JsonEncoder.withIndent("     ");

    try {
      final jsonMap = json.decode(result);
      final transformedJsonMap = _removeImage(jsonMap);
      return encoder.convert(transformedJsonMap);
    } catch (ex) {
      final jsonMap = {"PARSE_ERROR": result};
      return encoder.convert(jsonMap);
    }
  }

  Map<String, dynamic> _removeImage(Map<String, dynamic> jsonMap) {
    if (jsonMap["idFront"] != null &&
        jsonMap["idFront"]["data"] != null &&
        jsonMap["idFront"]["data"]["documentImageBase64"] != null) {
      jsonMap["idFront"]["data"]["documentImageBase64"] = "";
    }

    if (jsonMap["idBack"] != null &&
        jsonMap["idBack"]["data"] != null &&
        jsonMap["idBack"]["data"]["documentImageBase64"] != null) {
      jsonMap["idBack"]["data"]["documentImageBase64"] = "";
    }

    return jsonMap;
  }
}
