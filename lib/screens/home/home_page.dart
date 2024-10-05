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
      appBar: AppBar(
        title: const Text('Movies'),
      ),
      body: BlocProvider(
        create: (context) => _homeBloc,
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            debugPrint("====state: ${state.status}");
            if (state.status == BlocStateStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.status == BlocStateStatus.success) {
              return ListView.builder(
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
            } else if (state.status == BlocStateStatus.failure) {
              return const Center(child: Text('Failed to load movies'));
            }
            return const Placeholder();
          },
        ),
      ),
    );
  }
}
