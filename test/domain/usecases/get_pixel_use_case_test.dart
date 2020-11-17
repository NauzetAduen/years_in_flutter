import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';
import 'package:years_in_flutter/domain/usecases.dart';

class MockPixelRepository extends Mock implements PixelRepository {}

void main() {
  GetPixelsUseCase getPixelsUseCase;
  MockPixelRepository mockPixelRepository;

  setUp(() {
    mockPixelRepository = MockPixelRepository();
    getPixelsUseCase = GetPixelsUseCase(mockPixelRepository);
  });
  List<Pixel> list = [Pixel(note: 0, date: DateTime.now())];
  test('should get a list of pixels from the repository', () async {
    //
    when(mockPixelRepository.getPixelsList())
        .thenAnswer((_) async => Right(list));

    final result = await getPixelsUseCase(NoParams());

    expect(result, Right(list));
    verify(mockPixelRepository.getPixelsList());
    verifyNoMoreInteractions(mockPixelRepository);
  });
}
