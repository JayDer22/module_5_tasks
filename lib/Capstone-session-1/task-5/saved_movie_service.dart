import '../task-1/dbhelper.dart';
import '../task-2/movie_model.dart';

class SavedMovieService {
  final DbHelper _dbHelper = DbHelper.instance;

  Future<void> addMovie(Movie movie) async {
    await _dbHelper.insert(movie.toMap());
  }

  Future<void> removeMovie(int id) async {
    await _dbHelper.delete(id);
  }

  Future<List<Movie>> getAllSavedMovies() async {
    final rows = await _dbHelper.queryAllRows();
    return rows.map((row) => Movie.fromMap(row)).toList();
  }
  
  Future<bool> isMovieSaved(int id) async {
    final rows = await _dbHelper.queryAllRows();
    return rows.any((row) => row['id'] == id);
  }
}
