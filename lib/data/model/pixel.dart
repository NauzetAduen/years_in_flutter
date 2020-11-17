import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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
}
