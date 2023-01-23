import 'package:apk_music/models/songs.dart';
import 'package:flutter/cupertino.dart';

class RecentProvider with ChangeNotifier {
  List<SongModel> _recent = [];
  List<SongModel> get recent => _recent;
  set recent(List<SongModel> songs) {
    _recent = songs;
    notifyListeners();
  }

  setRecent(SongModel song) {
    if (!isRecentPlayed(song)) {
      _recent.add(song);
    } else {
      _recent.removeWhere((element) => element.idSong == element.idSong);
      _recent.add(song);
    }
    notifyListeners();
  }

  isRecentPlayed(SongModel song) {
    if (_recent.indexWhere((element) => element.idSong == song.idSong) == -1) {
      return false;
    } else {
      return true;
    }
  }
}
