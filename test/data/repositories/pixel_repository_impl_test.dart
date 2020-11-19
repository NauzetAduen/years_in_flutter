import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/core/exceptions.dart';
import 'package:years_in_flutter/core/failures.dart';
import 'package:years_in_flutter/core/network/network_info.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';
import 'package:years_in_flutter/data/model/pixel.dart';
import 'package:years_in_flutter/data/model/pixel_state.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';

class MockPixelDataSource extends Mock implements PixelDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PixelRepositoryImpl pixelRepositoryImpl;
  MockPixelDataSource mockPixelDataSource;
  MockNetworkInfo mockNetworkInfo;
  Pixel pixel = Pixel(
    date: DateTime.utc(2020, 10, 10),
    note: PixelState.REGULAR,
  );
  setUp(() {
    //
    mockPixelDataSource = MockPixelDataSource();
    mockNetworkInfo = MockNetworkInfo();
    pixelRepositoryImpl = PixelRepositoryImpl(
      mockPixelDataSource,
      mockNetworkInfo,
    );
  });

  //HELPERS
  void _isConnectedAnswer(bool answer) async =>
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => answer);

  group('Connectivity ON', () {
    setUp(() => _isConnectedAnswer(true));
    //this setup will be called for each test in this group
    group('createPixel', () {
      test('should check if there is internet connection', () async {
        await pixelRepositoryImpl.createPixel(pixel);

        verify(mockNetworkInfo.isConnected);
      });

      test('should return true after creating a pixel', () async {
        //
        when(mockPixelDataSource.createPixel(pixel))
            .thenAnswer((_) async => true);

        final result = await pixelRepositoryImpl.createPixel(pixel);

        expect(result, Right(true));
      });

      test('should return DatabaseFailure when call is unsuccesful', () async {
        when(mockPixelDataSource.createPixel(pixel))
            .thenThrow(DatabaseException());

        final result = await pixelRepositoryImpl.createPixel(pixel);

        expect(result, Left(DatabaseFailure()));
      });
    });

    group("deletePixel", () {
      test('should check if there is internet connection', () async {
        await pixelRepositoryImpl.deletePixel(pixel);

        verify(mockNetworkInfo.isConnected);
      });
      test('should return true after deleting a pixel', () async {
        when(mockPixelDataSource.deletePixel(pixel))
            .thenAnswer((_) async => true);

        final result = await pixelRepositoryImpl.deletePixel(pixel);

        expect(result, Right(true));
      });
      test('should return DatabaseFailure when call is unsuccesful', () async {
        when(mockPixelDataSource.deletePixel(pixel))
            .thenThrow(DatabaseException());

        final result = await pixelRepositoryImpl.deletePixel(pixel);

        expect(result, Left(DatabaseFailure()));
      });
    });
    group("updatePixel", () {
      test('should check if there is internet connection', () async {
        await pixelRepositoryImpl.updatePixel(pixel);

        verify(mockNetworkInfo.isConnected);
      });
      test('should return true after updating a pixel', () async {
        when(mockPixelDataSource.updatePixel(pixel))
            .thenAnswer((_) async => true);

        final result = await pixelRepositoryImpl.updatePixel(pixel);

        expect(result, Right(true));
      });
      test('should return DatabaseFailure when call is unsuccesful', () async {
        when(mockPixelDataSource.updatePixel(pixel))
            .thenThrow(DatabaseException());

        final result = await pixelRepositoryImpl.updatePixel(pixel);

        expect(result, Left(DatabaseFailure()));
      });
    });

    group("getPixels", () {
      test('should check if there is internet connection', () async {
        await pixelRepositoryImpl.getPixelsList();

        verify(mockNetworkInfo.isConnected);
      });
      test('should return a list of pixels', () async {
        List<Pixel> list = [pixel];
        when(mockPixelDataSource.getPixelsList()).thenAnswer((_) async => list);

        final result = await pixelRepositoryImpl.getPixelsList();

        expect(result, Right(list));
      });
      test('should return DatabaseFailure when call is unsuccesful', () async {
        when(mockPixelDataSource.getPixelsList())
            .thenThrow(DatabaseException());

        final result = await pixelRepositoryImpl.getPixelsList();

        expect(result, Left(DatabaseFailure()));
      });
    });
  });

  group('Connectivity OFF', () {
    //this setup will be called for each test in this group
    setUp(() => _isConnectedAnswer(false));

    group('createPixel', () {
      test('should return ConectionFailure', () async {
        final result = await pixelRepositoryImpl.createPixel(pixel);
        expect(result, Left(ConectionFailure()));
      });
    });
    group('deletePixel', () {
      test('should return ConectionFailure', () async {
        final result = await pixelRepositoryImpl.deletePixel(pixel);
        expect(result, Left(ConectionFailure()));
      });
    });
    group('updatePixel', () {
      test('should return ConectionFailure', () async {
        final result = await pixelRepositoryImpl.updatePixel(pixel);
        expect(result, Left(ConectionFailure()));
      });
    });
    group("getPixels", () {
      test('should return ConectionFailure', () async {
        final result = await pixelRepositoryImpl.getPixelsList();
        expect(result, Left(ConectionFailure()));
      });
    });
  });
}
