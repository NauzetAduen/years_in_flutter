import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:page_transition/page_transition.dart';
import 'package:years_in_flutter/data/datasources/pixel_datasource.dart';
import 'package:years_in_flutter/data/repository/pixel_repository.dart';
import 'package:years_in_flutter/widgets/calendar.dart';

import 'cubit/pixelsinyears_cubit.dart';
import 'injector.dart' as injector;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await injector.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => injector.sl<PixelsinyearsCubit>()..getPixelList(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
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
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<PixelsinyearsCubit, PixelsinyearsState>(
          builder: (context, state) {
            if (state is PixelsinyearsLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is PixelsinyearsLoaded) {
              return Center(child: Calendar(state.pixelList));
            } else if (state is PixelUpdatedOrCreated) {
              return Center(child: Calendar(state.pixelList));
            }
            return Text((state as PixelsinyearsError).message);
          },
        ),
      ),
    );
  }
}
