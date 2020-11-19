import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/core/network/network_info.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';

class MockPixelDataSource extends Mock implements PixelDatasource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  PixelRepositoryImpl pixelRepositoryImpl;
  MockPixelDataSource mockPixelDataSource;
  MockNetworkInfo mockNetworkInfo;
  setUp(() {
    //
    pixelRepositoryImpl = PixelRepositoryImpl(
      mockPixelDataSource,
      mockNetworkInfo,
    );
  });
}
