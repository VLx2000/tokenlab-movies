import 'package:flutter/material.dart';

class OverviewWidget extends StatelessWidget {
  final dynamic overview;
  final double distanceItens;
  const OverviewWidget(
      {super.key, required this.overview, required this.distanceItens});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: distanceItens),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 8),
            child: Text(
              "Descrição",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          Text(
            overview,
            textAlign: TextAlign.justify,
          )
        ],
      ),
    );
  }
}
