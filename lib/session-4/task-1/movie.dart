class Movie {
  int? id;
  String title;
  String genre;
  bool isWatched;

  Movie({
    this.id,
    required this.title,
    required this.genre,
    required this.isWatched,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'genre': genre,
      'isWatched': isWatched ? 1 : 0,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      genre: map['genre'],
      isWatched: map['isWatched'] == 1,
    );
  }
}
