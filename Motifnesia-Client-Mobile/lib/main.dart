import 'package:flutter/widgets.dart';
import 'package:motifnesia_mobile/app/motifnesia_app.dart';
import 'package:motifnesia_mobile/core/api/motifnesia_api.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MotifnesiaApp(api: MotifnesiaApi()));
}
