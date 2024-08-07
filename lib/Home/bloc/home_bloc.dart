import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomFavIconNavigation>(homFavIconNavigation);
    on<HomeFetchEvent>(homeFetchEvent);
  }

  FutureOr<void> homeFetchEvent(
      HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    await Future.delayed(const Duration(seconds: 3));

    emit(HomeSuccess());
  }

  FutureOr<void> homFavIconNavigation(
      HomFavIconNavigation event, Emitter<HomeState> emit) {
    log('button clicked');
    emit(HomeToFav());
  }
}
