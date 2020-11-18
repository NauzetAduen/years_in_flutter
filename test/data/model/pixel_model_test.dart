import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';

import '../../fixtures/reader.dart';

void main() {
  final Pixel pixel = Pixel(
    date: DateTime.utc(2020, 11, 18),
    note: PixelState.BAD,
  );
  group('fromJson', () {
    test('should return a valid model', () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('pixel.json'));
      final Pixel result = Pixel.fromJson(jsonMap);
      expect(pixel, result);
    });
  });
  group('toJson', () {
    test('should return a valid json map from a Pixel', () async {
      final result = pixel.toJson();
      final Map<String, dynamic> jsonMap = json.decode(fixture('pixel.json'));
      expect(result, jsonMap);
    });
  });
}
