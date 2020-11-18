import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';
import 'package:years_in_flutter/domain/create_pixel_usecase.dart';
import 'package:years_in_flutter/domain/usecases.dart';

class MockPixelRepository extends Mock implements PixelRepository {}

void main() {
  CreatePixelUseCase createPixelUseCase;
  MockPixelRepository mockPixelRepository;

  setUp(() {
    mockPixelRepository = MockPixelRepository();
    createPixelUseCase = CreatePixelUseCase(mockPixelRepository);
  });
  Pixel pixel = Pixel(note: PixelState.GOOD, date: DateTime.now());
  test('should get a list of pixels from the repository', () async {
    //
    when(mockPixelRepository.createPixel(pixel))
        .thenAnswer((_) async => Right(true));

    final result = await createPixelUseCase(Params(pixel));

    expect(result, Right(true));
    verify(mockPixelRepository.createPixel(pixel));
    verifyNoMoreInteractions(mockPixelRepository);
  });
}
