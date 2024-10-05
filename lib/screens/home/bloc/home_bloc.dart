import 'dart:async';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/data/models/movie.dart';
import 'package:movie/data/repositories/movie_repository.dart';
import 'package:movie/utils/enum.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuildContext context;

  HomeBloc({required this.context}) : super(HomeState.initial()) {
    on<GetMoviesList>(_getMoviesList);
  }

  FutureOr<void> _getMoviesList(GetMoviesList event, Emitter<HomeState> emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));
    try {
      final repo = RepositoryProvider.of<MovieRepository>(context);
      final movies = await repo.fetchPopularMovies();
      emit(state.copyWith(status: BlocStateStatus.success, movies: movies));
    } catch (e) {
      emit(state.copyWith(status: BlocStateStatus.failure));
    }
  }
}