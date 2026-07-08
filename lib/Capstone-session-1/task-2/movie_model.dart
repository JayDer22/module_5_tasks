class Movie {
  final int id;
  final String title;
  final String posterUrl;

  Movie({required this.id, required this.title, required this.posterUrl});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'posterUrl': posterUrl,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      posterUrl: map['posterUrl'],
    );
  }
}
