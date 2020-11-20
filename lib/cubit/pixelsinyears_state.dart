part of 'pixelsinyears_cubit.dart';

@immutable
abstract class PixelsinyearsState {
  const PixelsinyearsState();
}

class PixelsinyearsInitial extends PixelsinyearsState {
  const PixelsinyearsInitial();
}

class PixelsinyearsLoading extends PixelsinyearsState {
  const PixelsinyearsLoading();
}

class PixelsinyearsLoadedEmpty extends PixelsinyearsState {
  const PixelsinyearsLoadedEmpty();
}

class PixelsinyearsLoaded extends PixelsinyearsState {
  final List<Pixel> pixelList;
  const PixelsinyearsLoaded(this.pixelList);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PixelsinyearsLoaded && o.pixelList == pixelList;
  }

  @override
  int get hashCode => pixelList.hashCode;
}

class PixelsinyearsError extends PixelsinyearsState {
  final String message;
  const PixelsinyearsError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PixelsinyearsError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
