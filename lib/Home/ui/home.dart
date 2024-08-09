import 'dart:developer';

import 'package:blogs/Home/bloc/home_bloc.dart';
import 'package:blogs/Home/services/services.dart';
import 'package:blogs/favorities/ui/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeBloc homeBloc = HomeBloc(apiServices: ApiServices());

  @override
  void initState() {
    context.read<HomeBloc>().add(HomeFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeToFavActionState) {
          log('state received');
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const Favorite()));
        }
      },
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (state is HomeSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('New Blogs'),
              backgroundColor: Colors.orange,
              actions: [
                IconButton(
                  onPressed: () {
                    homeBloc.add(HomFavIconNavigation());
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favorite()));
                  },
                  icon: const Icon(
                    Icons.favorite_border,
                    size: 30,
                  ),
                )
              ],
            ),
            body: ListView.builder(
              itemCount: state.blogs.length,
              itemBuilder: (context, index) {
                final blog = state.blogs[index];
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(
                          blog.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const Icon(Icons.broken_image,
                                size: 50, color: Colors.grey);
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Blog title
                      Text(
                        blog.title,
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        } else if (state is HomeFail) {
          return const Scaffold(
            body: Center(
              child: Text('Something went wrong'),
            ),
          );
        } else {
          return const Scaffold(
            body: Center(child: Text('Network error')),
          );
        }
      },
    );
  }
}
