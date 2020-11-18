import 'package:intl/intl.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';

extension FormatedDate on DateTime {
  String getFormatedTime() => DateFormat('yyyy-MM-dd').format(this);
}

extension SerializedEnum on PixelState {
  String toJson() => this.toString().split(".").last;
}
