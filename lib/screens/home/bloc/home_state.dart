part of 'home_bloc.dart';


class HomeState {
  final BlocStateStatus status;
  final List<Movie>? movies;

  HomeState({
    required this.status,
    this.movies = const [],
  });


  factory HomeState.initial() => HomeState(
        status: BlocStateStatus.initial,
        movies: [],
      );

  HomeState copyWith({
    BlocStateStatus? status,
    List<Movie>? movies,
  }){
    return HomeState(
      status: status?? this.status,
      movies: movies?? this.movies,
    );
  }
}