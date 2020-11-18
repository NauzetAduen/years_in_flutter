import 'package:dartz/dartz.dart';

import '../core/failures.dart';
import '../data/repository/pixel_repository.dart';
import 'usecases.dart';

class DeletePixelUseCase implements UseCase<bool, Params> {
  final PixelRepository pixelRepository;

  DeletePixelUseCase(this.pixelRepository);
  @override
  Future<Either<Failure, bool>> call(Params params) async =>
      await pixelRepository.deletePixel(params.pixel);
}
