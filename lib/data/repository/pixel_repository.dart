import 'package:dartz/dartz.dart';
import 'package:years_in_flutter/core/network/network_info.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';

import '../../core/failures.dart';
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
  final NetworkInfo networkInfo;

  PixelRepositoryImpl(this.pixelDatasource, this.networkInfo);

  @override
  Future<Either<Failure, bool>> createPixel(Pixel pixel) {
    // TODO: implement createPixel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> deletePixel(Pixel pixel) {
    // TODO: implement deletePixel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Pixel>>> getPixelsList() {
    // TODO: implement getPixelsList
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> updatePixel(Pixel pixel) {
    // TODO: implement updatePixel
    throw UnimplementedError();
  }
}
