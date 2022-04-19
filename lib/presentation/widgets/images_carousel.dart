import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:vk_sdk/vk_sdk.dart';

class ImagesCarousel extends StatefulWidget {
  const ImagesCarousel({Key? key, required this.photos}) : super(key: key);

  final List<VKPhoto> photos;

  @override
  State<ImagesCarousel> createState() => _ImagesCarouselState();
}

class _ImagesCarouselState extends State<ImagesCarousel> {
  int _index = 0;

  List<Widget> _getPhotoItems(double height) {
    return widget.photos.map((photo) {
      final index = photo.sizes != null ? photo.sizes!.length - 1 : 0;
      final String url = photo.sizes![index].url;
      return Image.network(
        url,
        fit: BoxFit.cover,
        height: height,
        loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) {
            return child;
          }

          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }).toList();
  }

  _buildSelectionBar({required int count, required double height}) {
    if (count == 1) {
      return const SizedBox.shrink();
    }

    List<Expanded> items = [];
    for (var i = 0; i < count; i++) {
      items.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: SizedBox(
              // width: (width - 4.0),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(3.0),
                    ),
                    color: _index == i ? Colors.white.withOpacity(0.8) : Colors.grey.withOpacity(0.3),
                  ),
                  child: Container(),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: height,
      width: double.infinity,
      child: Row(
        children: items,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: height,
            viewportFraction: 1.0,
            enlargeCenterPage: false,
            autoPlay: false,
            enableInfiniteScroll: false,
            onPageChanged: (int index, CarouselPageChangedReason reason) {
              setState(() {
                _index = index;
              });
            },
          ),
          items: _getPhotoItems(height),
        ),
        _buildSelectionBar(
          count: widget.photos.length,
          height: 12.0,
        ),
      ],
    );
  }
}
