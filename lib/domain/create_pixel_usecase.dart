import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../data/repository/pixel_repository.dart';
import 'usecases.dart';

class CreatePixelUseCase implements UseCase<bool, Params> {
  final PixelRepository pixelRepository;

  CreatePixelUseCase(this.pixelRepository);
  @override
  Future<Either<Failure, bool>> call(Params params) async =>
      await pixelRepository.createPixel(params.pixel);
}
