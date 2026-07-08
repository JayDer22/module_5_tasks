import 'package:flutter/material.dart';
import '../task-1/dbhelper.dart';
import '../task-2/movie_model.dart';

class SavedMoviesScreen extends StatefulWidget {
  const SavedMoviesScreen({super.key});

  @override
  State<SavedMoviesScreen> createState() => _SavedMoviesScreenState();
}

class _SavedMoviesScreenState extends State<SavedMoviesScreen> {
  List<Movie> _savedMovies = [];

  @override
  void initState() {
    super.initState();
    _loadSavedMovies();
  }

  Future<void> _loadSavedMovies() async {
    final rows = await DbHelper.instance.queryAllRows();
    setState(() {
      _savedMovies = rows.map((row) => Movie.fromMap(row)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Saved Movies")),
      body: _savedMovies.isEmpty
          ? const Center(child: Text("No saved movies yet."))
          : ListView.builder(
              itemCount: _savedMovies.length,
              itemBuilder: (context, index) {
                final movie = _savedMovies[index];
                return ListTile(
                  leading: Image.network(movie.posterUrl, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.movie)),
                  title: Text(movie.title),
                );
              },
            ),
    );
  }
}
