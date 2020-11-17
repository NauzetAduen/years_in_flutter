import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class Pixel extends Equatable {
  final DateTime date;
  final int note;

  const Pixel({
    @required this.date,
    @required this.note,
  });

  @override
  List<Object> get props => [this.date, this.note];
}
