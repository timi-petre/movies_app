import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const MyHomePage(title: 'Movies App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _controller = ScrollController();
  final List<String> _titles = <String>[];
  bool _isLoading = false;
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _getMovies();

    _controller.addListener(() {
      if (!_isLoading &&
          _controller.offset > _controller.position.maxScrollExtent - MediaQuery.of(context).size.height) {
        _page++;
        _getMovies();
      }
    });
  }

  Future<void> _getMovies() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'yts.mx',
      pathSegments: <String>['api', 'v2', 'list_movies.json'],
      queryParameters: <String, dynamic>{
        'page': '$_page',
        'limit': '50',
      },
    );
    setState(() => _isLoading = true);
    final Response response = await get(uri);

    if (response.statusCode != 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok'))
            ],
            title: const Text('Error'),
          );
        },
      );
      return;
    }
    final Map<String, dynamic> body = jsonDecode(response.body) as Map<String, dynamic>;
    final Map<String, dynamic> movies = body['data'] as Map<String, dynamic>;
    final List<dynamic> titles = movies['movies'] as List<dynamic>;

    setState(() {
      for (final movie in titles) {
        _titles.add(movie['title']);
        _isLoading = false;
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: _titles.length,
        itemBuilder: (BuildContext context, int index) {
          final String title = _titles[index];
          return ListTile(
            title: Text(title),
          );
        },
      ),
    );
  }
}
