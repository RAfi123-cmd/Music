import 'package:apk_music/const.dart';
import 'package:apk_music/models/songs.dart';
import 'package:apk_music/providers/fav_provider.dart';
import 'package:apk_music/providers/recent_played_provider.dart';
import 'package:apk_music/providers/song_provider.dart';
import 'package:flutter/material.dart';

class MusicItem extends StatelessWidget {
  const MusicItem({
    Key? key,
    required this.songProvider,
    required this.data,
    required this.recentProvider,
    required this.favProvider,
  }) : super(key: key);

  final SongProvider songProvider;
  final SongModel data;
  final RecentProvider recentProvider;
  final FavProvider favProvider;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              songProvider.isPlaying
                  ? songProvider.audioPlayer.pause()
                  : songProvider.currentSong = data;
              recentProvider.setRecent(data);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                          image: AssetImage('assets/cover/${data.image}'),
                          fit: BoxFit.cover)),
                ),
                Icon(
                  songProvider.isPlaying && songProvider.currentSong == data
                      ? Icons.pause
                      : Icons.play_arrow_rounded,
                  color: white,
                  size: 40,
                )
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  data.title!,
                  style: const TextStyle(
                      color: white, fontWeight: FontWeight.w400),
                ),
                const SizedBox(height: 5),
                Text(
                  data.singer!,
                  style: const TextStyle(color: white, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                favProvider.setFav(data);
              },
              icon: favProvider.isFavorite(data)
                  ? const Icon(
                      Icons.favorite,
                      color: green,
                    )
                  : const Icon(
                      Icons.favorite_border_rounded,
                      color: white,
                    )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.more_vert_rounded,
                color: white,
              )),
        ],
      ),
    );
  }
}
