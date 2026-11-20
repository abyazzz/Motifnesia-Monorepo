import 'package:flutter/material.dart';

void replaceStack(BuildContext context, String path) =>
    Navigator.of(context).pushNamedAndRemoveUntil(path, (_) => false);
void openPage(BuildContext context, String path) =>
    Navigator.of(context).pushNamed(path);
