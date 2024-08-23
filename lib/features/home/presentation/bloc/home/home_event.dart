part of "home_bloc.dart";

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class CategoriesWithProductEvent extends HomeEvent {
  const CategoriesWithProductEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class BannersEvent extends HomeEvent {
  const BannersEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class ShipperEvent extends HomeEvent {
  const ShipperEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class TagsAllEvent extends HomeEvent {
  const TagsAllEvent();

  @override
  List<Object?> get props => <Object?>[];
}

class TagSelectedEvent extends HomeEvent {
  const TagSelectedEvent({
    required this.isSelected,
    required this.index,
  });

  final int index;
  final bool isSelected;

  @override
  List<Object?> get props => <Object?>[isSelected, index];
}

class FilterSubmitEvent extends HomeEvent {
  const FilterSubmitEvent({
    required this.tags,
  });

  final List<Tags> tags;

  @override
  List<Object?> get props => <Object?>[tags];
}

class FilterResetEvent extends HomeEvent {
  const FilterResetEvent();

  @override
  List<Object?> get props => <Object?>[];
}
