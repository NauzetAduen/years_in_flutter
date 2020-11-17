import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'pixelsinyears_state.dart';

class PixelsinyearsCubit extends Cubit<PixelsinyearsState> {
  PixelsinyearsCubit() : super(PixelsinyearsInitial());
}
