import 'package:flutter/material.dart';
import 'package:metatube/Screens/home_screen.dart';
import 'package:metatube/utils/app_styles.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1),(){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.dark,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.edit,
              color:AppTheme.accent,
              size: 200,
            ),
            Text(
              "MetaTube",
              style: AppTheme.splashStyle,
            )
          ],
        ),
      ),
    );
  }
}