import 'package:movies_app/actions/get_movies.dart';
import 'package:movies_app/models/app_state.dart';
import 'package:movies_app/actions/get_movies.dart';
import 'package:redux/redux.dart';

Reducer<AppState> appReducer = combineReducers([
  TypedReducer<AppState, GetMovies>(_getMovies),
  TypedReducer<AppState, GetMoviesSuccessful>(_getMoviesSuccessful),
  TypedReducer<AppState, GetMoviesError>(_getMoviesError),
]);

AppState _getMovies(AppState state, GetMovies action) {
  return state.copyWith(
    isLoading: true,
  );
}

AppState _getMoviesSuccessful(AppState state, GetMoviesSuccessful action) {
  final List<String> titles = <String>[
    ...action.titles,
    ...state.titles,
  ];
  return state.copyWith(
    isLoading: false,
    page: state.page + 1,
    titles: titles,
  );
}

AppState _getMoviesError(AppState state, GetMoviesError action) {
  return state.copyWith(
    isLoading: false,
  );
}
