import 'package:flutter/material.dart';
import 'package:wise_ai_ekyc_example/ekyc_service.dart';

class MYEkycPage extends StatelessWidget {
  final EkycService ekycService;
  final void Function(String) onCompleted;

  const MYEkycPage({
    super.key,
    required this.ekycService,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(16.0),
      itemCount: children.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16.0),
      itemBuilder: (context, index) => children[index],
    );
  }

  List<Widget> get children => [
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performMyKadEkyc();
            onCompleted(result);
          },
          child: const Text('Perform MyKad eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performPassportEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Passport eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performMilitaryEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Military eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performMyPREkyc();
            onCompleted(result);
          },
          child: const Text('Perform MyPR eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performMyKasEkyc();
            onCompleted(result);
          },
          child: const Text('Perform MyKAS eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performIMM13Ekyc();
            onCompleted(result);
          },
          child: const Text('Perform IMM13 eKYC'),
        ),
      ];
}
