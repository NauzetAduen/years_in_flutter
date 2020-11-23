import 'package:flutter_test/flutter_test.dart';
import 'package:years_in_flutter/core/extensions.dart';
import 'package:years_in_flutter/widgets/calendar.dart';

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

  group('isDateValid', () {
    test('leapyear should return true if the year is leap', () async {
      int year = 2020;
      expect(isLeapYear(year), true);
    });
    test('leapyear should return false if the year is not leap', () async {
      int year = 2021;
      expect(isLeapYear(year), false);
    });

    group('isDateValid', () {
      int year = 2020;
      test('should return true when the data is correct', () async {
        int month = 5;
        int day = 5;
        expect(isDateValid(year, month, day), true);
      });
      test('should return false when the month is bigger than 12', () async {
        int month = 13;
        int day = 5;
        expect(isDateValid(year, month, day), false);
      });
      test('should return false when the day is bigger than 31', () async {
        int month = 4;
        int day = 33;
        expect(isDateValid(year, month, day), false);
      });
      test(
          'should return false when the year is not leap and the date is 29feb',
          () async {
        int month = 2;
        int day = 29;
        int notLeapYear = 2021;
        expect(isDateValid(notLeapYear, month, day), false);
      });
      test('should return true when the year is  leap and the date is 29feb',
          () async {
        int month = 2;
        int day = 29;

        expect(isDateValid(year, month, day), true);
      });
      test('should return false if the date is after today', () async {
        int month = 1;
        int day = 20;
        year = 2323;
        expect(isDateValid(year, month, day), false);
      });
      test('should return false if the date is tomorrow', () async {
        DateTime tomorrow = DateTime.now().add(Duration(days: 1));
        expect(isDateValid(tomorrow.year, tomorrow.month, tomorrow.day), false);
      });
      test('should return true if the date is today', () async {
        DateTime today = DateTime.now();
        expect(isDateValid(today.year, today.month, today.day), true);
      });
    });
  });
}
