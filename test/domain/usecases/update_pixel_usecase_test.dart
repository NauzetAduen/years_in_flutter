import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';
import 'package:years_in_flutter/domain/update_pixel_usecase.dart';
import 'package:years_in_flutter/domain/usecases.dart';

class MockPixelRepository extends Mock implements PixelRepository {}

void main() {
  UpdatePixelUseCase updatePIxelUseCase;
  MockPixelRepository mockPixelRepository;

  setUp(() {
    mockPixelRepository = MockPixelRepository();
    updatePIxelUseCase = UpdatePixelUseCase(mockPixelRepository);
  });
  Pixel pixel = Pixel(note: PixelState.GOOD, date: DateTime.now());
  test('should update a pixel', () async {
    //
    when(mockPixelRepository.updatePixel(pixel))
        .thenAnswer((_) async => Right(true));

    final result = await updatePIxelUseCase(Params(pixel));

    expect(result, Right(true));
    verify(mockPixelRepository.updatePixel(pixel));
    verifyNoMoreInteractions(mockPixelRepository);
  });
}
