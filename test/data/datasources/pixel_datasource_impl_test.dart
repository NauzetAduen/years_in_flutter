import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/core/extensions.dart';

import '../../helpers/method_channel.dart';

Future<void> main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  PixelDatasourceImpl pixelDatasourceImpl = PixelDatasourceImpl(Hive);
  Box testBox;
  String testBoxName = 'testBoxName';
  mockMethodChannel();
  await Hive.initFlutter();
  Pixel testPixel = Pixel(
    date: DateTime.utc(2020, 10, 10),
    note: PixelState.EXCELENT,
  );
  Pixel updatedPixel = Pixel(
    date: DateTime.utc(2020, 10, 10),
    note: PixelState.AWFUL,
  );
  Pixel otherPixel = Pixel(
    date: DateTime.utc(2020, 3, 3),
    note: PixelState.BAD,
  );

  setUp(() async {
    testBox = await Hive.openBox(testBoxName);
  });
  tearDown(() async {
    await testBox.clear();
    await testBox.close();
  });

  test('emptyBoxName should be open', () async {
    expect(testBox.isOpen, true);
  });

  group('createPixel', () {
    test('should add a Pixel into hive', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      expect(testBox.length, 1);
    });
    test('should not add a second pixel with same key', () async {
      //
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      expect(testBox.length, 1);
    });
  });
  group('deletePixel', () {
    test('should delete a pixel if contained', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      expect(testBox.length, 1);
      await pixelDatasourceImpl.deletePixel(testPixel, boxName: testBoxName);
      expect(testBox.isEmpty, true);
    });

    test('should not delete a pixel if not contained', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      expect(testBox.length, 1);
      await pixelDatasourceImpl.deletePixel(otherPixel, boxName: testBoxName);
      expect(testBox.length, 1);
    });
  });
  group('updatePixel', () {
    test('should update a pixel if they key exist', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      await pixelDatasourceImpl.updatePixel(updatedPixel, boxName: testBoxName);
      expect(testBox.length, 1);
      final result = testBox.getAt(0).toString().getPixelStateFromString();
      expect(result, PixelState.AWFUL);
    });
    test('should not update a pixel if they key doesn\'t exist', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      await pixelDatasourceImpl.updatePixel(otherPixel, boxName: testBoxName);
      expect(testBox.length, 1);
      final result = testBox.getAt(0).toString().getPixelStateFromString();
      expect(result, PixelState.EXCELENT);
    });
  });

  group('getPixelList', () {
    test('should return a list of pixels', () async {
      await pixelDatasourceImpl.createPixel(testPixel, boxName: testBoxName);
      await pixelDatasourceImpl.createPixel(otherPixel, boxName: testBoxName);
      final result =
          await pixelDatasourceImpl.getPixelsList(boxName: testBoxName);
      expect(result.length, 2);
    });
  });
}
