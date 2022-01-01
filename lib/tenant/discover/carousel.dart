import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gharbeti_ui/shared/color.dart';
import 'package:gharbeti_ui/shared/screen_config.dart';

class CarouselWithIndicator extends StatefulWidget {
  final List<String>? imgList;

  const CarouselWithIndicator({Key? key, this.imgList}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final width = SizeConfig.safeBlockHorizontal;
    final height = SizeConfig.safeBlockVertical;
    double statusBarHeight = MediaQuery.of(context).padding.top;
    return Column(children: [
      CarouselSlider(
        items: widget.imgList!.map((item) {
          return SizedBox(
            width: double.infinity,
            height: height! * 30,
            child: buildImageNetwork(item, width!, height),
          );
        }).toList(),
        options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: true,
            viewportFraction: 1.0,
            autoPlayCurve: Curves.easeInOutSine,
            enlargeCenterPage: true,
            aspectRatio: 2.0,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            }),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: widget.imgList!.map(
          (image) {
            //these two lines
            int index = widget.imgList!.indexOf(image); //are changed
            return Container(
              width: 8.0,
              height: 8.0,
              margin:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? ColorData.activeColor
                      : const Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ).toList(),
      ),
    ]);
  }

  Widget buildImageNetwork(String image, double width, double height) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        height: height * 20,
        width: width * 80,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10)),
            image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: NetworkImage(
                  image,
                ))),
      ),
    );
    // Container(
    //     width: width * 80,
    //     height: height * 20,
    //     child: Image.network(
    //       image,
    //       fit: BoxFit.fill,
    //     ),
    //   ),
    // );
  }
}
