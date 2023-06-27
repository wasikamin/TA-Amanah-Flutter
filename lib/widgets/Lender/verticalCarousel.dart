import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Keuntungan imbal hasil:",
        ),
        Provider.of<UserProvider>(context).loading == true
            ? SizedBox(
                height: 10, width: 10, child: CircularProgressIndicator())
            : Text(
                formatCurrency(Provider.of<UserProvider>(context).totalYield),
                style: bodyTextStyle,
              ),
      ],
    );
  }
}

class DanaTersalur extends StatelessWidget {
  const DanaTersalur({super.key});

  String formatCurrency(int amount) {
    final formatCurrency =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp.', decimalDigits: 0);
    return formatCurrency.format(amount);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Dana tersalurkan"),
        Provider.of<UserProvider>(context).loading == true
            ? SizedBox(
                height: 10, width: 10, child: CircularProgressIndicator())
            : Text(
                formatCurrency(Provider.of<UserProvider>(context).totalFunding),
                style: bodyTextStyle,
              ),
      ],
    );
  }
}
