import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../core/failures.dart';
import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class GetPixelsUseCase implements UseCase<List<Pixel>, NoParams> {
  final PixelRepository pixelRepository;

  GetPixelsUseCase(this.pixelRepository);

  Future<Either<Failure, List<Pixel>>> call(NoParams params) async =>
      await pixelRepository.getPixelsList();
}

class Params extends Equatable {
  final Pixel pixel;

  Params(this.pixel);
  @override
  List<Object> get props => [pixel];
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}
