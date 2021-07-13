import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'barcode_scanner_view.dart';
import 'camera_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Scan'),
          style: TextButton.styleFrom(backgroundColor: Colors.blue, primary: Colors.white),
          onPressed: () =>
              {Navigator.push(context, MaterialPageRoute(builder: (context) => const BarcodeScannerView()))},
        ),
      ),
    );
  }
}
