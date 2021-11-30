import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_app/models/app_state.dart';
import 'package:redux/redux.dart';

class TitlesContainer extends StatelessWidget {
  const TitlesContainer({Key? key, required this.builder}) : super(key: key);
  final ViewModelBuilder<List<String>> builder;
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<String>>(
      converter: (Store<AppState> store) => store.state.titles,
      builder: builder,
    );
  }
}
