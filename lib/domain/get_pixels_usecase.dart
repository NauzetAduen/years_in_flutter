import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';
import 'usecases.dart';

class GetPixelsUseCase implements UseCase<List<Pixel>, NoParams> {
  final PixelRepository pixelRepository;

  GetPixelsUseCase(this.pixelRepository);

  Future<Either<Failure, List<Pixel>>> call(NoParams params) async =>
      await pixelRepository.getPixelsList();
}
