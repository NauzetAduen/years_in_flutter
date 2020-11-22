import 'package:hive/hive.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/core/extensions.dart';

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

const String defaultBoxName = "pixelsBox";

class PixelDatasourceImpl implements PixelDatasource {
  final HiveInterface hiveInterface;

  PixelDatasourceImpl(this.hiveInterface);

  @override
  Future<bool> createPixel(Pixel pixel,
      {String boxName = defaultBoxName}) async {
    final box = await hiveInterface.openBox(boxName);
    await box.put(pixel.date.getFormatedTime(), pixel.note.toJson());
    return true;
  }

  @override
  Future<bool> deletePixel(Pixel pixel,
      {String boxName = defaultBoxName}) async {
    final box = await hiveInterface.openBox(boxName);
    String key = pixel.date.getFormatedTime();
    if (box.containsKey(key)) await box.delete(key);
    return true;
  }

  @override
  Future<List<Pixel>> getPixelsList({String boxName = defaultBoxName}) async {
    List<Pixel> list = [];
    final Map<String, dynamic> map = Map<String, dynamic>.from(
        (await hiveInterface.openBox(boxName)).toMap());

    //TODO
    //better way to do this?

    map.forEach((key, value) {
      list.add(
        Pixel(
            date: key.getDateFromString(),
            note: value.toString().getPixelStateFromString()),
      );
    });

    return list;
  }

  @override
  Future<bool> updatePixel(Pixel pixel,
      {String boxName = defaultBoxName}) async {
    final box = await hiveInterface.openBox(boxName);
    String key = pixel.date.getFormatedTime();
    if (box.containsKey(key)) await box.put(key, pixel.note.toJson());
    return true;
  }
}
