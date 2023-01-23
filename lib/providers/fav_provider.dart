import 'package:apk_music/models/songs.dart';
import 'package:flutter/cupertino.dart';

class FavProvider with ChangeNotifier {
  List<SongModel> _favorite = [];
  List<SongModel> get favorite => _favorite;
  set favorite(List<SongModel> songs) {
    _favorite = songs;
    notifyListeners();
  }

  setFav(SongModel song) {
    if (!isFavorite(song)) {
      _favorite.add(song);
    } else {
      _favorite.removeWhere((element) => element.idSong == element.idSong);
    }
    notifyListeners();
  }

  isFavorite(SongModel song) {
    if (_favorite.indexWhere((element) => element.idSong == song.idSong) ==
        -1) {
      return false;
    } else {
      return true;
    }
  }
}
