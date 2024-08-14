import 'package:event_management/const/app_theme.dart';
import 'package:event_management/const/utils.dart';
import 'package:event_management/controller/provider/pick_image_provider.dart';
import 'package:event_management/controller/provider/sign_in_provider.dart';
import 'package:event_management/controller/provider/sign_up_provider.dart';
import 'package:event_management/controller/provider/splash_provider.dart';
import 'package:event_management/firebase_options.dart';
import 'package:event_management/views/auth/sign_in/sign_in.dart';
import 'package:event_management/controller/provider/home_provider.dart';
import 'package:event_management/views/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        
        ChangeNotifierProvider(create: (_) => SplashProvider()),
        ChangeNotifierProvider(create: (_) => SignInProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider()),
        ChangeNotifierProvider(create: (_)=> PickImageProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        home: const SplashScreen(),
      ),
    );
  }
}
