import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

part 'pixelsinyears_state.dart';

const String databaseFailureMessage = "The database has produced an error";

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  final PixelRepository pixelRepository;
  PixelsinyearsCubit(this.pixelRepository) : super(PixelsinyearsLoading());

  Future<void> getPixelList() async {
    emit(const PixelsinyearsLoading());
    final list = await pixelRepository.getPixelsList();

    list.fold(
      (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
      (list) => emit(PixelsinyearsLoaded(list)),
    );
  }
}
