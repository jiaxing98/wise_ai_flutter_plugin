import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wise_ai_ekyc_example/ekyc_service.dart';
import 'package:wise_ai_ekyc_example/my_ekyc_page.dart';
import 'package:wise_ai_ekyc_example/result_page.dart';
import 'package:wise_ai_ekyc_example/sg_ekyc_page.dart';

void main() {
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final PageController controller = PageController();
  final _ekycService = EkycService();

  String _platformVersion = 'Unknown';
  Future? _ekycInitializeFuture;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _ekycInitializeFuture = _ekycService.initialize();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _ekycService.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('WISE AI eKYC Demo'),
        ),
        body: FutureBuilder(
          future: _ekycInitializeFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                children: [
                  Center(
                    child: Column(
                      children: [
                        Text('Running on: $_platformVersion\n'),
                        DobTitle(
                          currentPage: currentPage,
                          pageIndicator: PageIndicator(
                            pages: ekyc.length,
                            currentPage: currentPage,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PageView.builder(
                        controller: controller,
                        itemCount: ekyc.length,
                        itemBuilder: (context, index) => ekyc[index],
                        onPageChanged: (page) {
                          setState(() {
                            currentPage = page;
                          });
                        }),
                  ),
                ],
              );
            }

            return const Center(
              child: Text("Something went wrong"),
            );
          },
        ),
      ),
    );
  }

  List<Widget> get ekyc => [
        MYEkycPage(ekycService: _ekycService, onCompleted: showResult),
        SGEkycPage(ekycService: _ekycService, onCompleted: showResult),
      ];

  void showResult(String result) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(
          result: result,
        ),
      ),
    );
  }
}

//region Widgets
class DobTitle extends StatelessWidget {
  final int currentPage;
  final Widget pageIndicator;

  const DobTitle({
    super.key,
    required this.currentPage,
    required this.pageIndicator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          pageIndicator,
        ],
      ),
    );
  }

  String get title {
    return switch (currentPage) {
      0 => "MY eKYC",
      1 => "SG eKYC",
      _ => "eKYC",
    };
  }
}

class PageIndicator extends StatelessWidget {
  final int pages;
  final int currentPage;

  const PageIndicator({
    super.key,
    required this.pages,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        pages,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Container(
            width: 10.0,
            height: 10.0,
            decoration: BoxDecoration(
              color: currentPage == index ? Colors.black87 : Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
//endregion
