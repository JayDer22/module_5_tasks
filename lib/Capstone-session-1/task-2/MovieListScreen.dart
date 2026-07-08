import 'package:flutter/material.dart';
import '../task-1/dbhelper.dart';
import 'movie_model.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({super.key});

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  final List<Movie> _movies = [
    Movie(id: 1, title: "Inception", posterUrl: "https://image.tmdb.org/t/p/w500/9gk7Fn9sVAsS969O9oqysOEaHBo.jpg"),
    Movie(id: 2, title: "Interstellar", posterUrl: "https://image.tmdb.org/t/p/w500/gEU2QniE6E77NI6lCU6MxlSv7rP.jpg"),
    Movie(id: 3, title: "The Dark Knight", posterUrl: "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDr9p1uJJbrqb0UdcEJ.jpg"),
    Movie(id: 4, title: "The Matrix", posterUrl: "https://image.tmdb.org/t/p/w500/f89U3Y9S7egqy97vYv6S9YngDyf.jpg"),
    Movie(id: 5, title: "Pulp Fiction", posterUrl: "https://image.tmdb.org/t/p/w500/d5iIlSXY9CnpqyQ7RHR6iXyfPNS.jpg"),
  ];

  Set<int> _savedMovieIds = {};

  @override
  void initState() {
    super.initState();
    _loadSavedMovies();
  }

  Future<void> _loadSavedMovies() async {
    final rows = await DbHelper.instance.queryAllRows();
    setState(() {
      _savedMovieIds = rows.map((row) => row[DbHelper.columnId] as int).toSet();
    });
  }

  Future<void> _toggleFavorite(Movie movie) async {
    if (_savedMovieIds.contains(movie.id)) {
      await DbHelper.instance.delete(movie.id);
    } else {
      await DbHelper.instance.insert(movie.toMap());
    }
    _loadSavedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movies")),
      body: ListView.builder(
        itemCount: _movies.length,
        itemBuilder: (context, index) {
          final movie = _movies[index];
          final isSaved = _savedMovieIds.contains(movie.id);
          return ListTile(
            leading: Image.network(movie.posterUrl, width: 50, errorBuilder: (c, e, s) => const Icon(Icons.movie)),
            title: Text(movie.title),
            trailing: IconButton(
              icon: Icon(isSaved ? Icons.favorite : Icons.favorite_border, color: isSaved ? Colors.red : null),
              onPressed: () => _toggleFavorite(movie),
            ),
          );
        },
      ),
    );
  }
}
