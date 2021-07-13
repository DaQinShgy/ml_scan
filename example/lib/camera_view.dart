import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

List<CameraDescription> cameras = [];

class CameraView extends StatefulWidget {
  /// the quality of image capture
  final ResolutionPreset resolutionPreset;

  /// Sets the flash mode
  final Stream<FlashMode>? streamFlashMode;

  const CameraView({Key? key, this.resolutionPreset = ResolutionPreset.max, this.streamFlashMode}) : super(key: key);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  CameraController? controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], widget.resolutionPreset, enableAudio: false);
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
    widget.streamFlashMode?.listen((event) {
      controller?.setFlashMode(event);
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null || !controller!.value.isInitialized) {
      return Container();
    }
    return CameraPreview(controller!);
  }
}
