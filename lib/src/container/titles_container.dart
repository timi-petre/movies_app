import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movies_app/src/models/app_state.dart';
import 'package:redux/redux.dart';

class TitlesContainer extends StatelessWidget {
  const TitlesContainer({Key? key, required this.builder}) : super(key: key);

  final ViewModelBuilder<List<String>> builder;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, List<String>>(
      //                  state-ul aplicatiei, ce vrem sa scoatem din el
      converter: (Store<AppState> store) =>
          store.state.titles, //converter: extragem din state o anumita parte
      builder: builder, //e apelat de fiecare ccare data se schimba titles
    );
  }
}
