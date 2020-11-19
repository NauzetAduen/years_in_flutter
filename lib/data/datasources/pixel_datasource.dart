import 'package:years_in_flutter/data/model/pixel.dart';

///Throws [DatabaseException]
abstract class PixelDatasource {
  //get all the pixels
  Future<List<Pixel>> getPixelsList();

  //update a pixel with the same date as the one passed
  Future<bool> updatePixel(Pixel pixel);

  //delete a pixel with the same date as the one passed
  Future<bool> deletePixel(Pixel pixel);

  //create a new pixel
  Future<bool> createPixel(Pixel pixel);
}

class PixelDatasourceImpl implements PixelDatasource {
  @override
  Future<bool> createPixel(Pixel pixel) {
    // TODO: implement createPixel
    throw UnimplementedError();
  }

  @override
  Future<bool> deletePixel(Pixel pixel) {
    // TODO: implement deletePixel
    throw UnimplementedError();
  }

  @override
  Future<List<Pixel>> getPixelsList() {
    // TODO: implement getPixelsList
    throw UnimplementedError();
  }

  @override
  Future<bool> updatePixel(Pixel pixel) {
    // TODO: implement updatePixel
    throw UnimplementedError();
  }
}
