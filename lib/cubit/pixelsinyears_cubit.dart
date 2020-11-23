import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

part 'pixelsinyears_state.dart';

const String databaseFailureMessage = "The database has produced an error";

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  final PixelRepository pixelRepository;
  // List<Pixel> pixelList;
  PixelsinyearsCubit(this.pixelRepository) : super(PixelsinyearsLoading());

//TODO (1) ADD REST OF FUNCTIONS
  Future<void> getPixelList() async {
    emit(const PixelsinyearsLoading());
    final result = await pixelRepository.getPixelsList();

    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (list) {
      // pixelList = list;
      emit(PixelsinyearsLoaded(list));
    });
  }

  Future<void> updatePixel(Pixel pixel) async {
    emit(const PixelsinyearsLoading());
    final result = await pixelRepository.updatePixel(pixel);

    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (result) {
      List<Pixel> list = (state as PixelUpdatedOrCreated).pixelList;
      emit(PixelUpdatedOrCreated(list));
    });
  }

  Future<void> createPixel(Pixel pixel) async {
    //TODO GET THE LIST BEFORE EMITING
    // emit(const PixelsinyearsLoading());
    final result = await pixelRepository.createPixel(pixel);
    print("CALING CREATE PIXEL");
    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (result) {
      List<Pixel> newList = [];

      //smart casting
      if (state is PixelsinyearsLoaded) newList.addAll(state.pixelList);

      if (state is PixelUpdatedOrCreated) newList.addAll(state.pixelList);

      newList.add(pixel);
      emit(PixelUpdatedOrCreated(newList));
    });
  }
}
