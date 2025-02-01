import 'package:flutter/material.dart';
import 'skelton.dart';

class NetworkImageWithLoader extends StatelessWidget {
  const NetworkImageWithLoader(
    this.src, {
    super.key,
    this.fit = BoxFit.cover,
  });

  final String src;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      src,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return const Skeleton();
      },
      errorBuilder: (context, error, stackTrace) => const Icon(
        Icons.error_outline,
        color: Colors.red,
      ),
    );
  }
}
