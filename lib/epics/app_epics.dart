import 'package:movies_app/actions/get_movies.dart';
import 'package:movies_app/data/movies_api.dart';
import 'package:movies_app/models/app_state.dart';
import 'package:redux_epics/redux_epics.dart';
import 'package:rxdart/rxdart.dart';

class AppEpics {
  final MoviesApi _api;

  AppEpics(this._api);

  Epic<AppState> get epics => combineEpics<AppState>([
        TypedEpic<AppState, GetMovies>(getMovies),
      ]);
  Stream<dynamic> getMovies(
      Stream<GetMovies> actions, EpicStore<AppState> store) {
    return actions //
        .flatMap((GetMovies action) => Stream<void>.value(null)
            .asyncMap((_) => _api.getMovies(store.state.page))
            .map<Object>((List<String> titles) => GetMoviesSuccessful(titles))
            .onErrorReturnWith((error, stackTrace) => GetMoviesError(error))
            .doOnData(action.result));
  }
}
