import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ml_scan/google_ml_kit.dart';

import 'camera_view.dart';

class BarcodeScannerView extends StatefulWidget {
  const BarcodeScannerView({Key? key}) : super(key: key);

  @override
  _BarcodeScannerViewState createState() => _BarcodeScannerViewState();
}

class _BarcodeScannerViewState extends State<BarcodeScannerView> {
  final StreamController<FlashMode> _streamController = StreamController();
  IconData _icon = Icons.flash_off_outlined;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned.fill(
              child: CameraView(
                streamFlashMode: _streamController.stream,
              ),
            ),
            Positioned(
              bottom: 30,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(_icon, color: Colors.white),
                    onPressed: () => {
                      setState(
                        () {
                          if (_icon == Icons.flash_off_outlined) {
                            _streamController.sink.add(FlashMode.torch);
                            _icon = Icons.flash_on_outlined;
                          } else {
                            _streamController.sink.add(FlashMode.off);
                            _icon = Icons.flash_off_outlined;
                          }
                        },
                      )
                    },
                  ),
                  const SizedBox(width: 100),
                  IconButton(icon: const Icon(Icons.photo_album, color: Colors.white), onPressed: _getImageFromGallery)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ImagePicker? _imagePicker;

  Future _getImageFromGallery() async {
    _imagePicker ??= ImagePicker();
    final pickedFile = await _imagePicker?.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final inputImage = InputImage.fromFilePath(pickedFile.path);
      processImage(inputImage);
    } else {
      print('No image selected.');
    }
  }

  bool _isBusy = false;
  ///
  final BarcodeScanner _barcodeScanner = GoogleMlKit.vision.barcodeScanner([BarcodeFormat.qrCode]);

  @override
  void dispose() {
    _barcodeScanner.close();
    super.dispose();
  }

  Future<void> processImage(InputImage inputImage) async {
    if (_isBusy) return;
    _isBusy = true;
    final barcodes = await _barcodeScanner.processImage(inputImage);
    print('Found ${barcodes.length} barcodes');

    _isBusy = false;
    if (mounted) {
      setState(() {});
    }
  }
}
