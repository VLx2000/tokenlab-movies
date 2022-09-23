import 'package:flutter/material.dart';

class TopInfoWidget extends StatelessWidget {
  final double distanceItens;
  final String releaseDate;
  final String title;
  final int runtime;
  final String posterUrl;

  const TopInfoWidget(
      {super.key,
      required this.title,
      required this.releaseDate,
      required this.distanceItens,
      required this.runtime,
      required this.posterUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: distanceItens),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              softWrap: true,
              title,
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                releaseDate,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
              Text(
                '$runtime min',
                textAlign: TextAlign.end,
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
