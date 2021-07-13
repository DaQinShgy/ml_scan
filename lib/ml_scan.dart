
import 'dart:async';

import 'package:flutter/services.dart';

class MlScan {
  static const MethodChannel _channel = MethodChannel('ml_scan');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
