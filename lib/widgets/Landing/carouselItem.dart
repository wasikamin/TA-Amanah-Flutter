import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  const CarouselItem(
      {super.key,
      required this.path,
      this.backgroundPath = "",
      required this.title,
      required this.subtitle});
  final String path;
  final String backgroundPath;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            child: Stack(children: [
              Positioned(
                  child: backgroundPath == ""
                      ? SizedBox.shrink()
                      : Image.asset(backgroundPath)),
              Image.asset(
                path,
                height: 300,
              ),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: titleTextStyle.copyWith(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  subtitle,
                  style: subTitleTextStyle.copyWith(fontSize: 14),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
