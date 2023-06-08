import 'package:amanah/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class VerticalCarousel extends StatefulWidget {
  @override
  _VerticalCarouselState createState() => _VerticalCarouselState();
}

class _VerticalCarouselState extends State<VerticalCarousel> {
  List<Widget> carouselItems = [
    ImbalHasil(),
    DanaTersalur(),
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        scrollDirection: Axis.vertical,
        enlargeCenterPage: true,
        enableInfiniteScroll: false,
        initialPage: 0,
        viewportFraction: 1,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 5),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
      ),
      items: carouselItems.map((item) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                margin: EdgeInsets.symmetric(horizontal: 5.0), child: item);
          },
        );
      }).toList(),
    );
  }
}

class ImbalHasil extends StatelessWidget {
  const ImbalHasil({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Keuntungan imbal hasil:",
        ),
        Text(
          "Rp. 100.000.000",
          style: bodyTextStyle.copyWith(fontSize: 20),
        )
      ],
    );
  }
}

class DanaTersalur extends StatelessWidget {
  const DanaTersalur({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dana tersalurkan"),
        Text(
          "Rp. 0",
          style: bodyTextStyle.copyWith(fontSize: 20),
        )
      ],
    );
  }
}
