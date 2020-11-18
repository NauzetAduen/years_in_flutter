import 'package:intl/intl.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';

extension FormatedDate on DateTime {
  String getFormatedTime() => DateFormat('yyyy-MM-dd').format(this);
}

extension SerializedEnum on PixelState {
  String toJson() => this.toString().split(".").last;
}

extension DateFromString on String {
  DateTime getDateFromString() {
    List<String> stringParts = this.split("-");
    List<int> intParts = [];
    stringParts.forEach((element) => intParts.add(int.parse(element)));
    return DateTime.utc(intParts[0], intParts[1], intParts[2]);
  }

  PixelState getPixelStateFromString() {
    if (this == "EXCELENT") return PixelState.EXCELENT;
    if (this == "GOOD") return PixelState.GOOD;
    if (this == "REGULAR") return PixelState.REGULAR;
    if (this == "BAD") return PixelState.BAD;
    if (this == "AWFUL") return PixelState.AWFUL;
    return PixelState.AWFUL;
  }
}
