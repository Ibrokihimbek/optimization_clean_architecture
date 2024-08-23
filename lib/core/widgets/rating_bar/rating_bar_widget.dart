import "package:flutter/material.dart";
import "package:currency_clean_architecture/core/theme/themes.dart";

typedef RatingChangeCallback = void Function(double rating)?;

const int starPoints = 5;

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    required this.rating,
    this.iconsSize = 20,
    this.activeRatingColor = const Color(0xFFFFC500),
    this.inactiveRatingColor = const Color(0xFFE0E8F1),
    this.onRatingChanged,
    this.isAnimate = false,
  });

  final num rating;
  final double iconsSize;
  final Color activeRatingColor;
  final Color inactiveRatingColor;
  final RatingChangeCallback onRatingChanged;
  final bool isAnimate;

  @override
  Widget build(BuildContext context) {
    if (isAnimate) {
      return TweenAnimationBuilder<double>(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        tween: Tween<double>(
          begin: 0,
          end: rating.toDouble(),
        ),
        builder: (_, double value, __) => Row(
          mainAxisSize: MainAxisSize.min,
          children: List<Widget>.generate(
            5,
            (int index) => buildStar(index, value),
          ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List<Widget>.generate(
        5,
        (int index) => buildStar(index, rating.toDouble()),
      ),
    );
  }

  Widget buildStar(int index, double rating) {
    Widget icon;
    final double present = rating - index;
    icon = ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (Rect bounds) => LinearGradient(
        colors: <Color>[activeRatingColor, inactiveRatingColor],
        stops: <double>[present, present],
      ).createShader(bounds),
      child: Icon(Icons.star, size: iconsSize),
    );

    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged!(index + 1.0),
      customBorder: const RoundedRectangleBorder(),
      borderRadius: BorderRadius.zero,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: icon,
    );
  }
}
