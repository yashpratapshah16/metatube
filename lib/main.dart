import 'package:flutter/material.dart';
import 'package:metatube/Screens/splash_screen.dart';
import 'package:window_manager/window_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await windowManager.ensureInitialized();

  WindowOptions windowOptions=WindowOptions(
    minimumSize: Size(400, 700),
    size: Size(600, 760),
    center: true,
    title: 'MetaTube',
  );

  windowManager.waitUntilReadyToShow(windowOptions,()async{
    await windowManager.show();
    await windowManager.focus();
  }); 
  runApp(const Main());
}

class Main extends StatelessWidget {
const Main({super.key});

  @override
  Widget build(BuildContext context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

