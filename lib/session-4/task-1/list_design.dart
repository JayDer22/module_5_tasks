import 'package:flutter/material.dart';

import 'movies_list.dart' as data;

class ListDesign extends StatefulWidget {
  const ListDesign({super.key});

  @override
  State<ListDesign> createState() => _ListDesignState();
}

class _ListDesignState extends State<ListDesign> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie Watchlist")),
      body: ListView.builder(
        itemCount: data.movies.length,
        itemBuilder: (context, index) {
          final movie = data.movies[index];
          return ListTile(
            title: Text(movie.title),
            subtitle: Text(movie.genre),
            trailing: Icon(
              movie.isWatched ? Icons.check_circle : Icons.watch_later,
              color: movie.isWatched ? Colors.green : Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
