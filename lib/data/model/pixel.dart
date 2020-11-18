import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:years_in_flutter/core/extensions.dart';

import 'pixel_state.dart';

class Pixel extends Equatable {
  final DateTime date;
  final PixelState note;

  const Pixel({
    @required this.date,
    @required this.note,
  });

  @override
  List<Object> get props => [this.date, this.note];

  factory Pixel.fromJson(Map<String, dynamic> json) => Pixel(
        date: json['date'].toString().getDateFromString(),
        note: json['note'].toString().getPixelStateFromString(),
      );

  Map<String, dynamic> toJson() =>
      {'date': date.getFormatedTime(), 'note': note.toJson()};

  @override
  String toString() => "$date | $note";
}
