import 'package:flutter/foundation.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/async_value.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;
  AsyncValue<List<Song>> _songs = const AsyncLoading();

  LibraryViewModel({required this.songRepository, required this.playerState}) {
    playerState.addListener(notifyListeners);
    _init();
  }

  AsyncValue<List<Song>> get songs => _songs;

  @override
  void dispose() {
    playerState.removeListener(notifyListeners);
    super.dispose();
  }

  void _init() async {
    _songs = const AsyncLoading();
    notifyListeners();
    try {
      final result = await songRepository.fetchSongs();
      _songs = AsyncData(result);
    } catch (e) {
      _songs = AsyncError(e);
    }
    notifyListeners();
  }

  void retry() => _init();

  bool isSongPlaying(Song song) => playerState.currentSong == song;

  void start(Song song) => playerState.start(song);
  void stop(Song song) => playerState.stop();
}
