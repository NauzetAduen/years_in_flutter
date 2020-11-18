import 'package:flutter_test/flutter_test.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/core/extensions.dart';

void main() {
  test('should return the correct value without the enum name', () async {
    //
    PixelState state = PixelState.EXCELENT;
    String expectedResult = "EXCELENT";
    String result = state.toJson();

    expect(result, expectedResult);
  });
}
