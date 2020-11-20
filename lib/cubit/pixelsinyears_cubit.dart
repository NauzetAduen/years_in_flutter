import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:years_in_flutter/core/failures.dart';

import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

part 'pixelsinyears_state.dart';

const String databaseFailureMessage = "The database has produced an error";
const String connectionFailureMessage = "Not conntected to a network";

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  final PixelRepositoryImpl pixelRepositoryImpl;
  PixelsinyearsCubit(this.pixelRepositoryImpl) : super(PixelsinyearsInitial());

  Future<void> getPixelList() async {
    emit(const PixelsinyearsLoading());

    final list = await pixelRepositoryImpl.getPixelsList();

    list.fold((failure) {
      if (failure is DatabaseFailure)
        emit(PixelsinyearsError(databaseFailureMessage));
      else if (failure is ConectionFailure)
        emit(PixelsinyearsError(connectionFailureMessage));
    }, (list) {
      if (list.isEmpty)
        emit(PixelsinyearsLoadedEmpty());
      else
        emit(PixelsinyearsLoaded(list));
    });
  }
}
