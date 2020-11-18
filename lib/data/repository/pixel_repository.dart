import 'package:dartz/dartz.dart';

import '../../core/failures.dart';
import '../model/pixel.dart';

abstract class PixelRepository {
  //get all the pixels
  Future<Either<Failure, List<Pixel>>> getPixelsList();

  //update a pixel with the same date as the one passed
  Future<Either<Failure, bool>> updatePixel(Pixel pixel);

  //update a pixel with the same date as the one passed
  Future<Either<Failure, bool>> deletePixel(Pixel pixel);

  //create a new pixel
  Future<Either<Failure, bool>> createPixel(Pixel pixel);
}
