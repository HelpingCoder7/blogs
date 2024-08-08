part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<Blogmodel> blogs;

  HomeSuccess({required this.blogs});
}

class HomeFail extends HomeState {}

class HomeToFavActionState extends HomeActionState {}
