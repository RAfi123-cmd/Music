import 'package:apk_music/const.dart';
import 'package:apk_music/providers/page_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CostumBottomNAv extends StatelessWidget {
  const CostumBottomNAv({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageProvider pageProvider = Provider.of<PageProvider>(context);
    return Container(
      height: 60,
      decoration:
          const BoxDecoration(border: Border(top: BorderSide(color: green))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
            icons.length,
            (index) => GestureDetector(
                  onTap: () {
                    pageProvider.currentPage = index;
                  },
                  child: SizedBox(
                    height: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          width: pageProvider.currentPage == index ? 24 : 0,
                          height: 3,
                          decoration: BoxDecoration(
                              color: pageProvider.currentPage == index
                                  ? green
                                  : white,
                              borderRadius: BorderRadius.circular(5)),
                        ),
                        Icon(
                          icons[index],
                          color:
                              pageProvider.currentPage == index ? green : white,
                        ),
                      ],
                    ),
                  ),
                )),
      ),
    );
  }
}
