import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:years_in_flutter/core/colors.dart';
import 'package:years_in_flutter/cubit/pixelsinyears_cubit.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/core/extensions.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';

import '../injector.dart';

class Calendar extends StatelessWidget {
  final List<Pixel> pixelList;
  //TODO(n) Uuse provider instead of passing the reference
  const Calendar(this.pixelList);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DayNumberColumn(),
          for (int month = 1; month <= 12; month++)
            Expanded(child: MonthColumn(month, pixelList)),
        ],
      ),
    );
  }
}

class MonthColumn extends StatelessWidget {
  final int month;
  final List<Pixel> pixelList;

  const MonthColumn(this.month, this.pixelList);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(month.toString()),
        for (int day = 1; day < 32; day++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(1),
              child: CustomButton(
                month: month,
                day: day,
                pixelList: pixelList,
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
  final List<Pixel> pixelList;

  const CustomButton({Key key, this.month, this.day, this.pixelList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isDayValid = isDateValid(2020, month, day);
    String dateKey = sanityze(month, day);
    return isDayValid
        ? GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    // String dateKey = sanityze(month, day);
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(10),
                      title: Text(
                        dateKey,
                        textAlign: TextAlign.center,
                      ),
                      content: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CustomButtomIcon(FontAwesomeIcons.solidSadTear,
                              PixelState.AWFUL, dateKey),
                          CustomButtomIcon(FontAwesomeIcons.solidFrownOpen,
                              PixelState.BAD, dateKey),
                          CustomButtomIcon(FontAwesomeIcons.solidMeh,
                              PixelState.REGULAR, dateKey),
                          CustomButtomIcon(FontAwesomeIcons.solidSmile,
                              PixelState.GOOD, dateKey),
                          CustomButtomIcon(FontAwesomeIcons.solidGrinBeam,
                              PixelState.EXCELENT, dateKey),
                        ],
                      ),
                    );
                  });
            },
            child: ColoredContainer(
              dateKey,
              pixelList,
            ),
          )
        : DissabledGreyContainer();
  }

  String sanityze(int month, int day) {
    String sanitizedMonth = month.toString();
    String sanitizedDay = day.toString();
    if (month < 10) sanitizedMonth = "0$sanitizedMonth";
    if (day < 10) sanitizedDay = "0$sanitizedDay";

    return "2020-$sanitizedMonth-$sanitizedDay";
  }
}

class ColoredContainer extends StatelessWidget {
  final String dateKey;
  final List<Pixel> pixelList;

  const ColoredContainer(this.dateKey, this.pixelList);
  @override
  Widget build(BuildContext context) {
    final result = contains(pixelList, dateKey);
    if (result != null) {
      return Container(
        color: _getColor(result),
      );
    }
    return Container(
      color: Colors.grey[100],
    );
  }
}

PixelState contains(List<Pixel> pixelList, String dateKey) {
  for (Pixel pixel in pixelList) {
    if (pixel.date.getFormatedTime() == dateKey) {
      return pixel.note;
    }
  }
  return null;
}

class DissabledGreyContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(color: Colors.grey);
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

class CustomButtomIcon extends StatelessWidget {
  final IconData icon;
  final PixelState state;
  final String dateKey;

  const CustomButtomIcon(this.icon, this.state, this.dateKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<PixelsinyearsCubit, PixelsinyearsState>(
      listener: (context, s) {},
      cubit: PixelsinyearsCubit(sl()),
      child: GestureDetector(
        onTap: () async {
          //TODO (2) USE Update or ADD
          Pixel pixel = Pixel(date: dateKey.getDateFromString(), note: state);
          await context.read<PixelsinyearsCubit>().createPixel(pixel);
          Navigator.pop(context);
        },
        child: FaIcon(
          icon,
          color: _getColor(state),
          size: 36,
        ),
      ),
    );
  }
}

Color _getColor(PixelState state) {
  if (state.index == 0) return awful;
  if (state.index == 1) return bad;
  if (state.index == 2) return regular;
  if (state.index == 3) return good;
  return excelent;
}

bool isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));
