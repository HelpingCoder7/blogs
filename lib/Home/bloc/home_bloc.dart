import 'dart:async';
import 'dart:developer';
import 'package:blogs/Home/model/model.dart';
import 'package:blogs/Home/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ApiServices apiServices;

  HomeBloc( {required this.apiServices}) : super(HomeInitial()) {
    on<HomFavIconNavigation>(homFavIconNavigation);
    on<HomeFetchEvent>(homeFetchEvent);
  }

  FutureOr<void> homeFetchEvent(
      HomeFetchEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final List<Blogmodel> blogs = await apiServices.fetchBlogs();
      emit(HomeSuccess(blogs: blogs));
    } catch (e) {
      emit(HomeFail());
    }
  }

  FutureOr<void> homFavIconNavigation(
      HomFavIconNavigation event, Emitter<HomeState> emit) {
    log('success');
    emit(HomeToFavActionState());
  }
}
