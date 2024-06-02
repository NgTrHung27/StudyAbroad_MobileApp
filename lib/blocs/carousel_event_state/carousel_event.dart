part of 'carousel_bloc.dart';

abstract class CarouselEvent extends Equatable {
  const CarouselEvent();
}

class FetchCarousel extends CarouselEvent {
  @override
  List<Object> get props => [];
}
