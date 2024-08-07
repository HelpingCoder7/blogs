import 'dart:developer';

import 'package:blogs/Home/bloc/home_bloc.dart';
import 'package:blogs/favorities/ui/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    // homeBloc.add(HomeFetchEvent());
    context.read<HomeBloc>().add(HomeFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        bloc: homeBloc,
        listenWhen: (previous, current) => current is HomeActionState,
        buildWhen: (previous, current) => current is! HomeActionState,
        listener: (context, state) {
          if (state is HomeToFav) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Favorite()));
          } else if (state is HomeLoading) {
            log('success');
          }
        },
        builder: (context, state) {
          switch (state) {
            case HomeLoading _:
              return const Scaffold(
                body: CircularProgressIndicator(),
              );
            case HomeSuccess _:
              return Scaffold(
                  backgroundColor: Colors.orange,
                  appBar: AppBar(
                    actions: [
                      IconButton(
                          onPressed: () {
                            homeBloc.add(HomFavIconNavigation());
                          },
                          icon: const Icon(
                            Icons.favorite_border,
                            size: 30,
                          ))
                    ],
                  ));

            case HomeFail _:
              return const Scaffold(
                body: Center(
                  child: Text('Something went wrong'),
                ),
              );

            default:
              return const Scaffold(
                body: ScaffoldMessenger(
                    child: Center(child: Text('Network error'))),
              );
          }
        });
  }
}
