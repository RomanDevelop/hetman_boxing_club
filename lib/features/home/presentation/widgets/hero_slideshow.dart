import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hetman_boxing_club/core/widgets/club_photo.dart';

class HeroSlideshow extends StatefulWidget {
  const HeroSlideshow({
    this.alignment = Alignment.center,
    super.key,
  });

  final Alignment alignment;

  static const photos = [
    'assets/images/hero.jpg',
    'assets/images/hero_youth.jpg',
    'assets/images/hero_team.jpg',
  ];

  @override
  State<HeroSlideshow> createState() => _HeroSlideshowState();
}

class _HeroSlideshowState extends State<HeroSlideshow> {
  Timer? _timer;
  var _index = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted) return;
      setState(() => _index = (_index + 1) % HeroSlideshow.photos.length);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 700),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        layoutBuilder: (currentChild, previousChildren) {
          return Stack(
            fit: StackFit.expand,
            children: [
              ...previousChildren,
              if (currentChild != null) currentChild,
            ],
          );
        },
        child: ClubPhoto(
          key: ValueKey(_index),
          asset: HeroSlideshow.photos[_index],
          alignment: widget.alignment,
        ),
      ),
    );
  }
}
