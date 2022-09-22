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
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Title(
              color: Colors.black,
              child: const Text(
                "Descrição",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
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
