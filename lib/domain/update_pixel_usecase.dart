import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../data/repository/pixel_repository.dart';
import 'usecases.dart';

class UpdatePixelUseCase implements UseCase<bool, Params> {
  final PixelRepository pixelRepository;

  UpdatePixelUseCase(this.pixelRepository);
  @override
  Future<Either<Failure, bool>> call(Params params) async =>
      await pixelRepository.updatePixel(params.pixel);
}
