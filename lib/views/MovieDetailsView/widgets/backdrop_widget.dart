import 'package:flutter/material.dart';

class BackdropWidget extends StatelessWidget {
  final String url;
  final String title;
  const BackdropWidget({
    super.key,
    required this.title,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/backdrop.png',
        placeholderFit: BoxFit.scaleDown,
        image: url,
        fit: BoxFit.fill,
        imageErrorBuilder: (context, error, stackTrace) =>
            const Text('Sem imagem do filme'),
      ),
    );
  }
}
