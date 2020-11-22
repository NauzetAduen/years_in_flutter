import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../data/model/pixel.dart';
import '../data/repository/pixel_repository.dart';

part 'pixelsinyears_state.dart';

const String databaseFailureMessage = "The database has produced an error";

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  final PixelRepository pixelRepository;
  PixelsinyearsCubit(this.pixelRepository) : super(PixelsinyearsLoading());

//TODO (1) ADD REST OF FUNCTIONS
  Future<void> getPixelList() async {
    emit(const PixelsinyearsLoading());
    final result = await pixelRepository.getPixelsList();

    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (list) => emit(PixelsinyearsLoaded(list)));
  }

  Future<void> updatePixel(Pixel pixel) async {
    emit(const PixelsinyearsLoading());
    final result = await pixelRepository.updatePixel(pixel);

    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (result) => emit(const PixelUpdatedOrCreated()));
  }

  Future<void> createPixel(Pixel pixel) async {
    emit(const PixelsinyearsLoading());
    final result = await pixelRepository.createPixel(pixel);

    result.fold(
        (failure) => emit(const PixelsinyearsError(databaseFailureMessage)),
        (result) => emit(const PixelUpdatedOrCreated()));
  }
}
