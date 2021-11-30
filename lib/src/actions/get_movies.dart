class GetMovies {
  GetMovies(this.result);

  final void Function(dynamic action) result;
}

class GetMoviesSuccessful {
  GetMoviesSuccessful(this.titles);

  final List<String> titles;
}

class GetMoviesError {
  GetMoviesError(this.error);

  final Object error;
}
