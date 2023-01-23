import 'package:apk_music/providers/song_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lyric/lyrics_reader.dart';

class SongLyric extends StatelessWidget {
  const SongLyric({
    Key? key,
    required this.songProvider,
    required this.lyricUI,
  }) : super(key: key);

  final SongProvider songProvider;
  final UINetease lyricUI;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 6,
      child: LyricsReader(
        model: LyricsModelBuilder.create()
            .bindLyricToMain(songProvider.lyric!)
            .getModel(),
        position: songProvider.playProgress!.toInt(),
        lyricUi: lyricUI,
        playing: songProvider.isPlaying,
        emptyBuilder: () => Center(
          child: Text(
            'No lyric',
            style: lyricUI.getOtherMainTextStyle(),
          ),
        ),
      ),
    );
  }
}
