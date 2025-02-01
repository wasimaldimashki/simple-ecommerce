import 'package:flutter/material.dart';
import 'package:holool_ecommerce/theme/color.dart';

class RatingBar extends StatelessWidget {
  final double rating;
  final double count;
  final double size;
  final Color? color;

  const RatingBar({
    Key? key,
    required this.rating,
    required this.count,
    this.size = 18,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> starList = [];
    int realNumber = rating.floor();
    int partNumber = ((rating - realNumber) * 10).ceil();

    for (int i = 0; i < 5; i++) {
      if (i < realNumber) {
        starList.add(Icon(
          Icons.star,
          color: color ?? AppColors.primaryColor,
          size: size,
        ));
      } else if (i == realNumber && partNumber > 0) {
        starList.add(Icon(
          Icons.star_half,
          color: color ?? AppColors.primaryColor,
          size: size,
        ));
      } else {
        starList.add(Icon(
          Icons.star_border,
          color: color ?? AppColors.primaryColor,
          size: size,
        ));
      }
    }

    return Row(
      children: [
        Row(children: starList),
        const SizedBox(width: 5),
        Text(
          '($count)',
          style: TextStyle(
            fontSize: size * 0.8,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
