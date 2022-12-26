import 'package:apk_music/const.dart';
import 'package:flutter/material.dart';

import '../models/artists.dart';

class FavArtisItem extends StatelessWidget {
  final ArtistModel artist;
  const FavArtisItem({
    Key? key,
    required this.artist,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.2,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage('assets/artist/${artist.image}'),
                    fit: BoxFit.cover)),
          ),
          const SizedBox(height: 10),
          Text(
            artist.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: white),
          )
        ],
      ),
    );
  }
}
