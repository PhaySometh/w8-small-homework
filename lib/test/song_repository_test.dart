import 'package:w8_small_homework/data/repositories/songs/song_repository_mock.dart';

void main() async {
  // Instantiate the song_repository_mock
  final songRepositoryMock = SongRepositoryMock();

  // Test both the success and the failure of the post request

  // Handle the Future using 2 ways (2 tests)
  // - Using then() with .catchError().
  // - Using async/await with try/catch.

  songRepositoryMock.fetchSongById('s1').then((song) {
    print('Success (then): ${song?.title}');
  }).catchError((error) {
    print('Error (then): $error');
  });

  songRepositoryMock.fetchSongById('25').then((song) {
    print('Success (then): ${song?.title}');
  }).catchError((error) {
    print('Error (then): $error');
  });

  try {
    final song = await songRepositoryMock.fetchSongById('s1');
    print('Success (await): ${song?.title}');
  } catch (e) {
    print('Error (await): $e');
  }

  try {
    final song = await songRepositoryMock.fetchSongById('25');
    print('Success (await): ${song?.title}');
  } catch (e) {
    print('Error (await): $e');
  }
}
