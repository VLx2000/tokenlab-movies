import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final dynamic rating;
  const RatingWidget({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    double ratingNumber =
        rating == null ? 0 : double.parse(rating.toStringAsPrecision(3));

    int integerPart = ratingNumber ~/ 2;
    //debugPrint(integerPart.toString());
    List<double> fills = [0, 0, 0, 0, 0];
    for (int i = 0; i < integerPart; i++) {
      fills[i] = 1;
    }
    double diff = ratingNumber / 2 - integerPart;
    if (diff > 0) {
      fills[integerPart] = 0.5;
    }

    // logica para preencher estrelas de avaliação
    List<Widget> fillStars() {
      List<Widget> childs = [];
      for (double fill in fills) {
        if (fill == 0) {
          childs.add(const Icon(Icons.star_border, color: Colors.yellowAccent));
        } else if (fill == 1) {
          childs.add(const Icon(Icons.star, color: Colors.yellowAccent));
        } else {
          childs.add(const Icon(Icons.star_half, color: Colors.yellowAccent));
        }
      }
      return childs;
    }

    return Column(
      children: [
        Text(
          "$ratingNumber",
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(children: fillStars()),
      ],
    );
  }
}
