import 'package:flutter_test/flutter_test.dart';
import 'package:years_in_flutter/core/extensions.dart';

void main() {
  final DateTime tTime = DateTime.utc(2020, 6, 5);
  final DateTime fullTime = DateTime.now();
  group('getFormatedTime', () {
    test('should return a valid formated string when using a utc date',
        () async {
      const String expectedResult = "2020-06-05";

      final result = tTime.getFormatedTime();
      expect(result, expectedResult);
    });
    test('should return a valid formated string when using a full date',
        () async {
      String expectedResult =
          "${fullTime.year}-${fullTime.month}-${fullTime.day}";

      final result = fullTime.getFormatedTime();
      expect(result, expectedResult);
    });
  });
}
