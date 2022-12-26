import 'package:apk_music/const.dart';
import 'package:flutter/material.dart';

class CurrentSong extends StatelessWidget {
  const CurrentSong({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: const DecorationImage(
                    image: AssetImage(
                        'assets/cover/Adele - Easy On Me (Official Lyric Video).jpg'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Easy on me',
                  style: TextStyle(
                      color: white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text(
                  'Adele',
                  style: TextStyle(color: white, fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.favorite_border_rounded,
                color: white,
              )),
          Container(
            height: 25,
            width: 25,
            child: Stack(
              alignment: Alignment.center,
              children: const [
                CircularProgressIndicator.adaptive(
                  valueColor: AlwaysStoppedAnimation(green),
                  value: 0.5,
                  strokeWidth: 2,
                ),
                Icon(Icons.play_arrow_rounded, color: white, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
