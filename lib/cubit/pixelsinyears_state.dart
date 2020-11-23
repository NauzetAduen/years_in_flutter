part of 'pixelsinyears_cubit.dart';

@immutable
abstract class PixelsinyearsState {
  final List<Pixel> pixelList;
  const PixelsinyearsState(this.pixelList);
}

class PixelsinyearsLoading extends PixelsinyearsState {
  const PixelsinyearsLoading() : super(const []);
}

class PixelUpdatedOrCreated extends PixelsinyearsState {
  final List<Pixel> pixelList;
  const PixelUpdatedOrCreated(this.pixelList) : super(pixelList);
}

class PixelsinyearsLoaded extends PixelsinyearsState {
  final List<Pixel> pixelList;
  const PixelsinyearsLoaded(this.pixelList) : super(pixelList);

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
  const PixelsinyearsError(this.message) : super(const []);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    return o is PixelsinyearsError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
