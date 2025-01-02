import 'package:flutter/material.dart';
import 'package:wise_ai_ekyc_example/ekyc_service.dart';

class SGEkycPage extends StatelessWidget {
  final EkycService ekycService;
  final void Function(String) onCompleted;

  const SGEkycPage({
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
            final result = await ekycService.performEmpPassEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Employment Pass eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSPassEkyc();
            onCompleted(result);
          },
          child: const Text('Perform S Pass eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGStudentEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Student Card eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGWPEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Work Permit eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGNRICEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Singapore ID eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGLongTermVisitEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Long Term Visit Pass eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGDependantPassEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Dependant Pass eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGArmedForceEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Armed Forces ID eKYC'),
        ),
        OutlinedButton(
          onPressed: () async {
            final result = await ekycService.performSGOverseasEkyc();
            onCompleted(result);
          },
          child: const Text('Perform Overseas Pass eKYC'),
        ),
      ];
}
