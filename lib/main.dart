  import 'package:flutter/material.dart';
  import 'app/app.dart';
  import 'package:firebase_core/firebase_core.dart';
  import 'package:firebase_auth/firebase_auth.dart';


  Future<void> main() async {
    // Ensures Flutter engine/framework bindings are ready before any async init.jmhk,h
    WidgetsFlutterBinding.ensureInitialized(); // Needed if you preload services/assets or call platform code.
    // If you later add async init (e.g., Firebase, SharedPreferences), await them here.
    // await Firebase.initializeApp(); // add this line
    runApp(const CattleMarketplaceApp());
  }
  