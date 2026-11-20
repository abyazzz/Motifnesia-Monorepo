import 'package:flutter/material.dart';
import 'package:motifnesia_mobile/core/api/api_contract.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';

class Photo extends StatelessWidget {
  const Photo(
    this.api,
    this.source, {
    this.width,
    this.height,
    this.radius = 14,
    this.fit = BoxFit.cover,
  });
  final MotifnesiaApi api;
  final Object? source;
  final double? width;
  final double? height;
  final double radius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    Widget fallback() => Image.asset(
      'assets/images/product_placeholder.jpg',
      width: width,
      height: height,
      fit: fit,
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: text(source).isEmpty
          ? fallback()
          : Image.network(
              api.asset(source).toString(),
              width: width,
              height: height,
              fit: fit,
              webHtmlElementStrategy: WebHtmlElementStrategy.fallback,
              errorBuilder: (_, _, _) => fallback(),
            ),
    );
  }
}

Object? productImage(Json row) =>
    row['gambar_url'] ?? row['image_url'] ?? row['gambar'];
