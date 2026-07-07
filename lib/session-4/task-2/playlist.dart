class Playlist {
  final int? id;
  final String name;
  final int songCount;

  Playlist({
    this.id,
    required this.name,
    required this.songCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'songCount': songCount,
    };
  }

  factory Playlist.fromMap(Map<String, dynamic> map) {
    return Playlist(
      id: map['id'],
      name: map['name'],
      songCount: map['songCount'],
    );
  }
}
