import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class WelcomeSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enableInfiniteScroll: false,
        height: 150.0,
        viewportFraction: 0.8,
        initialPage: 0,
        autoPlay: false,
        scrollDirection: Axis.horizontal,
        autoPlayAnimationDuration: Duration(milliseconds: 400),
        autoPlayCurve: Curves.easeInOutQuad,
        enlargeCenterPage: true,
      ),
      items: [1, 2, 3].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(color: Colors.lightGreenAccent),
                child: Text(
                  'text $i',
                  style: TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    );
  }
}
