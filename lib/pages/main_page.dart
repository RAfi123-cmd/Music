import 'dart:ui';

import 'package:apk_music/const.dart';
import 'package:apk_music/pages/home_page.dart';
import 'package:apk_music/pages/music_detail.dart';
import 'package:apk_music/providers/page_provider.dart';
import 'package:apk_music/providers/song_provider.dart';
import 'package:apk_music/widgets/bgblur.dart';
import 'package:apk_music/widgets/costum_bottom_nav.dart';
import 'package:apk_music/widgets/current_song.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    SongProvider songProvider = Provider.of<SongProvider>(context);
    Widget body() {
      switch (pageProvider.currentPage) {
        case 0:
          return const HomePage();
        case 1:
          return const Center(
              child: Text(
            'Search',
            style: TextStyle(color: green, fontSize: 32),
          ));
        case 2:
          return const Center(
              child: Text(
            'Libary',
            style: TextStyle(color: green, fontSize: 32),
          ));
        case 3:
          return const Center(
              child: Text(
            'Profile',
            style: TextStyle(color: green, fontSize: 32),
          ));

        default:
          return const Center(
              child: Text(
            'Home',
            style: TextStyle(color: green, fontSize: 32),
          ));
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: black,
        body: body(),
        bottomNavigationBar: SizedBox(
          height: songProvider.currentSong != null ? 120 : 60,
          child: Stack(
            children: [
              Image.asset(
                songProvider.currentSong != null
                    ? 'assets/cover/${songProvider.currentSong!.image!}'
                    : 'assets/cover/Adele - Easy On Me (Official Lyric Video).jpg',
                fit: BoxFit.cover,
                width: double.infinity,
              ),
              BgBlur(
                blur: 10,
                opacity: 0.8,
                color: black,
                child: Column(
                  children: [
                    //CurrentSong
                    songProvider.currentSong != null
                        ? GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const MusicDetail(),
                                  ));
                            },
                            child: const CurrentSong())
                        : Container(),
                    //costum Bottom Nav
                    const CostumBottomNAv(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
