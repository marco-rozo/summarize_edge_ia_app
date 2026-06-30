// Este arquivo é mantido como fallback.
// Use main_dev.dart ou main_prod.dart para os respectivos flavors.
import 'package:flutter/material.dart';
import 'package:summary_app/app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}
