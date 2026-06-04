import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({
    super.key,
    required this.applicationAppBar,
  });
  final AppBar applicationAppBar;

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  late SharedPreferences _prefs;

  void getPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  List<Widget> getListTiles(ThemeData themeData) {
    List<String>? data = _prefs.getStringList('data');
    return [
      Card(
        child: ListTile(
          title: Text(
            data![0],
            style: TextStyle(
              color: themeData.primaryTextTheme.displayLarge?.color,
            ),
          ),
          trailing: Text(
            'BMI: ${data[1]}\nStatus: ${data[2]}',
            style:
                TextStyle(color: themeData.primaryTextTheme.bodyLarge?.color),
          ),
        ),
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Size screenSize = MediaQuery.of(context).size;
    ThemeData themeData = Theme.of(context);

    return Scaffold(
      appBar: widget.applicationAppBar,
      backgroundColor: themeData.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            ListView(
              children: getListTiles(themeData),
            )
          ],
        ),
      ),
    );
  }
}
