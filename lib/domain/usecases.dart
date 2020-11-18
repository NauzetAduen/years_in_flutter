import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../core/failures.dart';
import '../data/model/pixel.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
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
