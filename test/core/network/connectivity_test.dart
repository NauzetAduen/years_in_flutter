import 'package:connectivity/connectivity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:years_in_flutter/core/network/network_info.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  MockConnectivity mockConnectivity;
  NetworkInfoImpl networkInfoImpl;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfoImpl = NetworkInfoImpl(mockConnectivity);
  });
  test('should forward to connectivity.checkConnectivity()', () async {
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.mobile);

    await networkInfoImpl.isConnected;

    verify(mockConnectivity.checkConnectivity());
  });
  test('should return true when the result is not none', () async {
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.mobile);

    final result = await networkInfoImpl.isConnected;

    expect(result, true);
  });
  test('should return false when result is none', () async {
    when(mockConnectivity.checkConnectivity())
        .thenAnswer((_) async => ConnectivityResult.none);

    final result = await networkInfoImpl.isConnected;
    verify(mockConnectivity.checkConnectivity());
    expect(result, false);
  });
}
