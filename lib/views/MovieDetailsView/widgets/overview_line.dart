import 'package:flutter/material.dart';

class OverviewLine extends StatelessWidget {
  final dynamic overview;
  const OverviewLine({super.key, required this.overview});

  @override
  Widget build(BuildContext context) {
    return Column(
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
    );
  }
}
