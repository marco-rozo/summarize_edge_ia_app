// Este arquivo é mantido como fallback.
// Use main_dev.dart ou main_prod.dart para os respectivos flavors.
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:summary_app/app.dart';
import 'package:summary_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
