import 'package:dartz/dartz.dart';

import '../../core/exceptions.dart';
import '../../core/failures.dart';
import '../datasources/pixel_datasource.dart';
import '../model/pixel.dart';

abstract class PixelRepository {
  //get all the pixels
  Future<Either<Failure, List<Pixel>>> getPixelsList();

  //update a pixel with the same date as the one passed
  Future<Either<Failure, bool>> updatePixel(Pixel pixel);

  //delete a pixel with the same date as the one passed
  Future<Either<Failure, bool>> deletePixel(Pixel pixel);

  //create a new pixel
  Future<Either<Failure, bool>> createPixel(Pixel pixel);
}

class PixelRepositoryImpl implements PixelRepository {
  final PixelDatasource pixelDatasource;

  PixelRepositoryImpl(this.pixelDatasource);

  @override
  Future<Either<Failure, bool>> createPixel(Pixel pixel) async =>
      await common(pixelDatasource.createPixel, pixel);

  @override
  Future<Either<Failure, bool>> deletePixel(Pixel pixel) async =>
      await common(pixelDatasource.deletePixel, pixel);

  @override
  Future<Either<Failure, bool>> updatePixel(Pixel pixel) async =>
      await common(pixelDatasource.updatePixel, pixel);

  Future<Either<Failure, bool>> common(Function fn, Pixel pixel) async {
    try {
      final actionResult = await fn(pixel);
      return Right(actionResult);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  //TODO
  //reuse common with List<Pixel>> return type
  @override
  Future<Either<Failure, List<Pixel>>> getPixelsList() async {
    try {
      final listResult = await pixelDatasource.getPixelsList();
      return Right(listResult);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
