import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

part 'pixelsinyears_state.dart';

const String databaseFailureMessage = "The database has produced an error";
const String connectionFailureMessage = "Not conntected to a network";

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  final PixelRepositoryImpl pixelRepositoryImpl;
  PixelsinyearsCubit(this.pixelRepositoryImpl) : super(PixelsinyearsLoading());

  Future<void> getPixelList() async {
    emit(const PixelsinyearsLoading());
    final list = await pixelRepositoryImpl.getPixelsList();

    list.fold(
      (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
      (list) => emit(PixelsinyearsLoaded(list)),
    );
  }
}
