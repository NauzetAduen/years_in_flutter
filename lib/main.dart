import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import 'cubit/pixelsinyears_cubit.dart';
import 'injector.dart' as injector;

void main() {
  injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnimatedSplashScreen(
        nextScreen: HomePage(),
        splash: "assets/splash.png",
        splashTransition: SplashTransition.fadeTransition,
        pageTransitionType: PageTransitionType.fade,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider(
          create: (context) => injector.sl<PixelsinyearsCubit>(),
          child: BlocBuilder<PixelsinyearsCubit, PixelsinyearsState>(
              builder: (context, state) {
            if (state is PixelsinyearsInitial) {
            } else if (state is PixelsinyearsLoading) {
            } else if (state is PixelsinyearsLoadedEmpty) {
            } else if (state is PixelsinyearsLoaded) {
            } else {
              //state is PixelsinyearsError
            }
          }),
        ),
      ),
    );
  }
}

//TODO
//Commits on Mar 11, 2020
//resocoder video cubits : https://www.youtube.com/watch?v=y564ETOCog8
// cubits 12:55 -> 35:55
