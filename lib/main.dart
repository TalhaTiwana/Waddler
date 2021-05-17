import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:waddler/Providers/auth_providers.dart';
import 'package:waddler/Screens/SplashScreen/splash_screen.dart';
import 'package:waddler/SignUpParent.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(providers: [
ChangeNotifierProvider(create:(_)=>AUthProvider())
    ],
    child: Waddler(),
    )


  );
}

class Waddler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
