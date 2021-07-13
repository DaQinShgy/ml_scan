import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ml_scan/ml_scan.dart';

void main() {
  const MethodChannel channel = MethodChannel('ml_scan');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await MlScan.platformVersion, '42');
  });
}
