import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/screens/home/bloc/home_bloc.dart';
import 'package:movie/screens/home/widgets/item_movie.dart';
import 'package:movie/utils/enum.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;
  bool isLoggedIn = false; // Example flag for login status

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetMoviesList());
  }

  @override
  void dispose() {
    _homeBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Image.asset(
                      'assets/images/img_logo.png',
                      height: 48,
                      width: 48,
                    ), // Image logo
                    const SizedBox(width: 10),
                    const Text(
                      'Eng',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ), // Language selector
                    const Spacer(),
                    SizedBox(
                      height: 40,
                      child: isLoggedIn
                          ? ElevatedButton(
                              onPressed: () {
                                // Navigate to profile
                              },
                              child: const Text(
                                'Profile',
                                style: TextStyle(color: Colors.white),
                              ),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                // Navigate to login
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                    // isLoggedIn
                    //     ? TextButton(
                    //         onPressed: () {
                    //           // Navigate to profile
                    //         },
                    //         child: const Text('Profile'),
                    //       )
                    //     : TextButton(
                    //         onPressed: () {
                    //           // Navigate to login
                    //         },
                    //         child: const Text('Login'),
                    //       ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Now in cinemas',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        // Handle search action
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(child: _buildLoadMovie()),
        ],
      ),
    );
  }

  Widget _buildLoadMovie() {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state.status == BlocStateStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == BlocStateStatus.success) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.55,
            ),
            itemCount: state.movies?.length ?? 0,
            itemBuilder: (context, index) {
              final movie = state.movies![index];
              return ItemMovie(
                movie: movie,
                onTapItem: (Movie movie) {
                  debugPrint("onTapItem ${movie.title}");
                },
              );
            },
          );
        } else {
          return const Center(child: Text('Failed to load movies'));
        }
      },
    );
  }
}
