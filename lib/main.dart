import 'package:animate_icons/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bmi_calculator/screens/home_page.dart';
import 'package:bmi_calculator/utils/dark_theme.dart';
import 'package:bmi_calculator/utils/light_theme.dart';
import 'package:bmi_calculator/utils/theme_manager.dart';

void main() {
  runApp(MyApp());
}

ThemeManager themeManager = ThemeManager();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AnimateIconController _animateIconController;

  @override
  void dispose() {
    themeManager.addListener(themeListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    themeManager.addListener(themeListener);
    _animateIconController = AnimateIconController();
  }

  void themeListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );

    AppBar applicationAppBar = AppBar(
      actions: [
        AnimateIcons(
          startIcon: Icons.dark_mode,
          endIcon: Icons.sunny,
          duration: Duration(
            seconds: 1,
          ),
          controller: _animateIconController,
          startIconColor: Colors.black,
          endIconColor: theme.primaryColor,
          onStartIconPress: () {
            return themeManager.toggleTheme(false);
          },
          onEndIconPress: () {
            return themeManager.toggleTheme(true);
          },
        ),
      ],
      backgroundColor: theme.appBarTheme.backgroundColor,
      title: Text(
        'Bmi Calculator',
        style: theme.appBarTheme.titleTextStyle,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeManager.themeMode,
      home: HomePage(
        applicationAppBar: applicationAppBar,
      ),
    );
  }
}
