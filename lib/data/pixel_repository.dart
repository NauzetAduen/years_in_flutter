import 'package:dartz/dartz.dart';
import 'package:years_in_flutter/core/failures.dart';
import 'package:years_in_flutter/model/pixel.dart';

abstract class PixelRepository {
  //get all the pixels
  Future<Either<Failure, List<Pixel>>> getPixelsList();

  //update a pixel with the same date as the one passed
  Future<Either<Failure, void>> updatePixel(Pixel pixel);

  //create a new pixel
  Future<Either<Failure, void>> createPixel(Pixel pixel);
}
