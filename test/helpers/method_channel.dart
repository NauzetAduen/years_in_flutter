import 'package:flutter/services.dart';

void mockMethodChannel() {
  const MethodChannel channel =
      MethodChannel('plugins.flutter.io/path_provider');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    return ".";
  });
}
