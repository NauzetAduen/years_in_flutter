import 'package:flutter/material.dart';

class Calendar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DayNumberColumn(),
          for (int month = 1; month <= 12; month++)
            Expanded(child: MonthColumn(month)),
        ],
      ),
    );
  }
}

class MonthColumn extends StatelessWidget {
  final int month;

  const MonthColumn(this.month);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(month.toString()),
        for (int day = 1; day < 32; day++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () {},
                child: CustomButton(month: month, day: day),
              ),
            ),
          ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final int month;
  final int day;

  const CustomButton({Key key, this.month, this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDayValid = isDateValid(2020, month, day);
    return GestureDetector(
      onTap: () {
        print("$month - $day");
      },
      child: Container(
        color: isDayValid ? Colors.blueAccent : Colors.grey,
      ),
    );
  }
}

class DayNumberColumn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(""),
        for (int i = 1; i < 32; i++) Text(i.toString()),
      ],
    );
  }
}

//Meses con 30 días: Abril, Junio, Septiembre y Noviembre.

bool isDateValid(int year, int month, int day) {
  if (month > 12 || day > 31) return false;

  if ((month == 4 || month == 6 || month == 9 || month == 11) && day == 31)
    return false;

  if (month == 2) {
    if (day > 29) return false;
    if (day == 29 && !isLeapYear(year)) return false;
  }

  DateTime date = DateTime.utc(year, month, day);
  if (date.isAfter(DateTime.now())) return false;
  return true;
}

bool isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
