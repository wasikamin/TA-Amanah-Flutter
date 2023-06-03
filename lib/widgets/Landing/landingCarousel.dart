import 'package:amanah/constants/app_theme.dart';
import 'package:amanah/widgets/Landing/carouselItem.dart';
import 'package:flutter/material.dart';

class LandingCarousel extends StatefulWidget {
  LandingCarousel({
    super.key,
  });

  @override
  State<LandingCarousel> createState() => _LandingCarouselState();
}

class _LandingCarouselState extends State<LandingCarousel> {
  final PageController _pageViewController = PageController(initialPage: 0);
  int _activePage = 0;
  final List<CarouselItem> CarouselItems = [
    CarouselItem(
      path: "assets/images/Illustration/Exchange.png",
      backgroundPath: "assets/images/Illustration/laptop_background.png",
      title: "Akses pinjaman yang mudah",
      subtitle: "Temukan peminjam yang sesuai dengan kriteriamu dengan mudah",
    ),
    CarouselItem(
      path: "assets/images/Illustration/Invest.png",
      backgroundPath: "assets/images/Illustration/board_background.png",
      title: "Investasi mudah dan menguntungkan",
      subtitle:
          "Dapatkan imbal hasil yang lebih baik dibandingkan dengan instrumen investasi yang lebih konvensional.",
    ),
    CarouselItem(
      path: "assets/images/Illustration/Card.png",
      title: "Kemudahan penarikan dana",
      subtitle:
          "Penarikan tunai melalui rekening pribadi. Hal ini memberikan akses langsung terhadap dana yang dibutuhkan dengan cepat dan mudah. ",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          controller: _pageViewController,
          onPageChanged: (int index) {
            setState(() {
              _activePage = index;
            });
          },
          itemCount: 3,
          itemBuilder: (context, i) {
            return Container(
              child: CarouselItems[i],
            );
          },
        ),
        Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List<Widget>.generate(
                  CarouselItems.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        _pageViewController.animateToPage(index,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeIn);
                      },
                      child: CircleAvatar(
                        radius: 3,
                        backgroundColor:
                            _activePage == index ? primaryColor : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            ))
      ],
    );
  }
}
