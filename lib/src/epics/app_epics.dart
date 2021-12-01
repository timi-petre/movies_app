import 'package:movies_app/src/actions/get_movies.dart';
import 'package:movies_app/src/data/movies_api.dart';
import 'package:movies_app/src/models/app_state.dart';
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
        //unde tipul este de GetMovies
        .flatMap((GetMovies action) => Stream<void>.value(null)
            .asyncMap((_) => _api.getMovies(store.state.page)) //cheama API , asteapta rezultatul
            .map<Object>((List<String> titles) => GetMoviesSuccessful(titles)) //daca api returneaza un list de string
            .onErrorReturnWith((error, stackTrace) => GetMoviesError(error))
            .doOnData(action.result));
  }
}
