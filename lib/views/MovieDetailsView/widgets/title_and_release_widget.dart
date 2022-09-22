import 'package:flutter/material.dart';

class TitleReleaseWidget extends StatelessWidget {
  final double distanceItens;
  final String releaseDate;
  final String title;
  const TitleReleaseWidget(
      {super.key,
      required this.title,
      required this.releaseDate,
      required this.distanceItens});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: distanceItens),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              softWrap: true,
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              releaseDate,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
