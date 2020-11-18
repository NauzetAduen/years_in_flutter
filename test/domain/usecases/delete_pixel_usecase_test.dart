import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';
import 'package:years_in_flutter/domain/delete_pixel_usecase.dart';
import 'package:years_in_flutter/domain/usecases.dart';

class MockPixelRepository extends Mock implements PixelRepository {}

void main() {
  DeletePixelUseCase deletePixelUseCase;
  MockPixelRepository mockPixelRepository;

  setUp(() {
    mockPixelRepository = MockPixelRepository();
    deletePixelUseCase = DeletePixelUseCase(mockPixelRepository);
  });
  Pixel pixel = Pixel(note: PixelState.GOOD, date: DateTime.now());
  test('should delete a pixel', () async {
    //
    when(mockPixelRepository.deletePixel(pixel))
        .thenAnswer((_) async => Right(true));

    final result = await deletePixelUseCase(Params(pixel));

    expect(result, Right(true));
    verify(mockPixelRepository.deletePixel(pixel));
    verifyNoMoreInteractions(mockPixelRepository);
  });
}
