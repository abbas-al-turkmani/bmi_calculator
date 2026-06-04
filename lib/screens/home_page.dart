import 'package:flutter/material.dart';
import 'package:bmi_calculator/custom-widgets/my_number_picker.dart';
import 'package:bmi_calculator/custom-widgets/noteched_responsive_app_bar.dart';
import 'package:bmi_calculator/custom-widgets/ruler.dart';
import 'package:bmi_calculator/modules/bmi_result.dart';
import 'package:bmi_calculator/utils/local_variables.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom-widgets/counter_widget.dart';
import '../custom-widgets/icon_with_text.dart';
import '../custom-widgets/my_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    required this.applicationAppBar,
  });

  final AppBar applicationAppBar;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isMale = true;
  bool isResultShown = false;

  int heightValue = 170;
  int weightValue = 70;
  int ageValue = 22;

  SharedPreferences? _prefs;

  @override
  void initState() {
    super.initState();
    _initPreferences();
  }

  void ageDown() {
    setState(() {
      if (ageValue > 0) {
        ageValue--;
      }
    });
  }

  void ageUp() {
    setState(() {
      if (ageValue < 120) {
        ageValue++;
      }
    });
  }

  Future<void> _initPreferences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> addToPreferences(double bmiValue, String bmiStatus) async {
    final prefs = _prefs ?? await SharedPreferences.getInstance();
    _prefs = prefs;
    await prefs.setStringList(
      'data',
      [DateTime.now().toString(), bmiValue.toString(), bmiStatus],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final ThemeData theme = Theme.of(context);

    _initPreferences();

    final double containerHeight = screenSize.height * 0.2;
    final double mainTextSize = screenSize.width * 0.04;
    final double genderIconSize = screenSize.width * 0.20;
    final double borderWidth = screenSize.width * 0.005;
    final double selectedBorderWidth = screenSize.width * 0.01;
    final double buttomAppBarHeight = screenSize.height * 0.1;

    BMIResult result = BMIResult(
      isMale,
      heightValue,
      weightValue,
      ageValue,
    );

    Color fColor = theme.focusColor;
    Color dColor = theme.disabledColor;

    return Scaffold(
      appBar: widget.applicationAppBar,
      backgroundColor: theme.scaffoldBackgroundColor,
      body: NotechedResponsiveAppBar(
        shape: NotechedResponsiveAppBarShape.rounded,
        hasCenterButton: true,
        color: theme.bottomAppBarTheme.color,
        buttonColor: theme.bottomAppBarTheme.color,
        maxHeight: screenSize.height * 0.5,
        allowShadow: false,
        body: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Text(
              "Your BMI is:",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            Text(
              "${result.calculateBMI().toStringAsFixed(1)} km/m2",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),
            Text(
              "(${result.getStatus()})",
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      addToPreferences(
                        result.bmi,
                        result.getStatus(),
                      );
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: Colors.white,
                    )),
                IconButton(
                    onPressed: () {
                      String text =
                          "My BMi is ${result.bmi}, Try to calculate yours by this app ";
                      SharePlus.instance.share(ShareParams(text: text));
                    },
                    icon: Icon(
                      Icons.share,
                      color: Colors.white,
                    )),
              ],
            )
          ],
        ),
        buttonChild: isResultShown
            ? Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30,
              )
            : Text(
                "BMI",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
        onButtonPressed: () {
          setState(() {
            result = BMIResult(isMale, heightValue, weightValue, ageValue);
          });
        },
        afterButtonPressed: () {
          setState(() {
            isResultShown = !isResultShown;
          });
        },
        pageBody: SafeArea(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 0, buttomAppBarHeight),
            child: Column(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: MyContainer(
                          height: containerHeight,
                          borderColor: isMale ? fColor : dColor,
                          borderWidth:
                              isMale ? selectedBorderWidth : borderWidth,
                          child: IconWithText(
                            text: 'Male',
                            icon: Icons.male,
                            iconColor: Color.fromARGB(255, 255, 149, 91),
                            iconSize: genderIconSize,
                            textSize: mainTextSize,
                          ),
                          onTap: () {
                            setState(() {
                              isMale = true;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: MyContainer(
                          height: containerHeight,
                          borderColor: !isMale ? fColor : dColor,
                          borderWidth:
                              !isMale ? selectedBorderWidth : borderWidth,
                          child: IconWithText(
                            text: 'Female',
                            icon: Icons.female,
                            iconColor: Color.fromARGB(255, 215, 57, 115),
                            iconSize: genderIconSize,
                            textSize: mainTextSize,
                          ),
                          onTap: () {
                            setState(() {
                              isMale = false;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: MyContainer(
                    height: containerHeight,
                    borderWidth: borderWidth,
                    borderColor: dColor,
                    child: Ruler(
                      title: 'Height',
                      beginValue: 50,
                      endValue: 250,
                      defultValue: 100,
                      onValueChanged: (int value) {},
                      rulerWidth: screenSize.width,
                      rulerHeight: containerHeight,
                      heightValue: 100,
                      marker: Container(
                        width: screenSize.width / 120,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kSecondaryTextColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: MyContainer(
                          height: containerHeight,
                          borderWidth: borderWidth,
                          borderColor: dColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(
                                  "Weight (in kg)",
                                  style: TextStyle(
                                    color:
                                        theme.primaryTextTheme.bodyLarge?.color,
                                  ),
                                ),
                                Expanded(
                                  child: MyNumberPicker(
                                    onValueChanged: (int value) {
                                      weightValue = value;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: MyContainer(
                          height: containerHeight,
                          borderWidth: borderWidth,
                          borderColor: dColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text("Age",
                                    style: TextStyle(
                                      color: theme
                                          .primaryTextTheme.bodyLarge?.color,
                                    )),
                                Expanded(
                                  child: CounterWidget(
                                    onValueChanged: (value) {
                                      ageValue = value;
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.local_activity),
              onPressed: () {},
              color: Colors.white,
            ),
            SizedBox(
              width: screenSize.width * 0.5,
            ),
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {},
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
