import 'package:apk_music/const.dart';
import 'package:apk_music/providers/fav_provider.dart';
import 'package:apk_music/providers/package_provider.dart';
import 'package:apk_music/providers/song_provider.dart';
import 'package:apk_music/widgets/bgblur.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_lyric/lyrics_reader.dart';
import 'package:provider/provider.dart';

class MusicDetail extends StatefulWidget {
  const MusicDetail({super.key});

  @override
  State<MusicDetail> createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  @override
  Widget build(BuildContext context) {
    SongProvider songProvider = Provider.of<SongProvider>(context);
    PackageProvider packageProvider = Provider.of<PackageProvider>(context);
    FavProvider favProvider = Provider.of<FavProvider>(context);

    var lyricUI = UINetease(
        highlight: false,
        defaultSize: 18,
        defaultExtSize: 14,
        bias: 0.5,
        lyricAlign: LyricAlign.CENTER,
        lyricBaseLine: LyricBaseLine.CENTER,
        lineGap: 25,
        inlineGap: 25,
        otherMainSize: 14);
    return Stack(
      children: [
        Image.asset(
          'assets/cover/${songProvider.currentSong!.image!}',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [black.withOpacity(0.6), black.withOpacity(0.2), black],
            stops: const [0.2, 0.6, 1.0],
          )),
        ),
        Scaffold(
          backgroundColor: transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: transparent,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.keyboard_arrow_left_rounded,
                    color: white)),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
              IconButton(
                  onPressed: () {}, icon: const Icon(Icons.more_vert_rounded))
            ],
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
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
              ),
              BgBlur(
                opacity: 0.6,
                color: black,
                blur: 10,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    songProvider.currentSong!.title!,
                                    style: const TextStyle(
                                        color: white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    songProvider.currentSong!.singer!,
                                    style: const TextStyle(
                                        color: white, fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  favProvider.setFav(songProvider.currentSong!);
                                },
                                icon: favProvider
                                        .isFavorite(songProvider.currentSong!)
                                    ? const Icon(
                                        Icons.favorite,
                                        color: green,
                                      )
                                    : const Icon(
                                        Icons.favorite_border_rounded,
                                        color: white,
                                      ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Slider.adaptive(
                        max: songProvider.maxValue!,
                        min: 0,
                        value:
                            songProvider.playProgress! > songProvider.maxValue!
                                ? songProvider.maxValue!
                                : songProvider.playProgress!,
                        onChanged: (value) {
                          songProvider.playProgress = value;
                          songProvider.audioPlayer
                              .seek(Duration(milliseconds: value.toInt()));
                          songProvider.audioPlayer.resume();
                        },
                        onChangeEnd: (value) {},
                        activeColor: green,
                        inactiveColor: white,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              formatTime(Duration(
                                  milliseconds:
                                      songProvider.playProgress!.toInt())),
                              style:
                                  const TextStyle(color: white, fontSize: 12),
                            ),
                            Text(
                              formatTime(Duration(
                                  milliseconds:
                                      songProvider.maxValue!.toInt())),
                              style:
                                  const TextStyle(color: white, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.shuffle_rounded,
                                  color: white)),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_previous_rounded,
                                color: white,
                                size: 36,
                              )),
                          GestureDetector(
                            onTap: () {
                              if (songProvider.isPlaying) {
                                songProvider.audioPlayer.pause();
                              } else {
                                songProvider.audioPlayer.resume();
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle, color: green),
                              child: Icon(
                                songProvider.isPlaying
                                    ? Icons.pause
                                    : Icons.play_arrow_rounded,
                                size: 52,
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.skip_next_rounded,
                                color: white,
                                size: 36,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.repeat_rounded,
                                  color: white)),
                        ],
                      ),
                      const SizedBox(height: 10),
                      packageProvider.currentPackage != null
                          ? Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/package/${packageProvider.currentPackage!.image!}'),
                                            fit: BoxFit.cover)),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'From playlist',
                                          style: TextStyle(
                                              color: white, fontSize: 11),
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          packageProvider.currentPackage!.name!,
                                          style: const TextStyle(
                                              color: white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.keyboard_arrow_right_rounded,
                                        color: white,
                                      ))
                                ],
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
