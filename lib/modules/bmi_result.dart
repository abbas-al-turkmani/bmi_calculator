import 'dart:math';

class BMIResult {
  final bool isMale;
  final int heightValue;
  final int weightValue;
  final int ageValue;

  late double bmi;

  BMIResult(this.isMale, this.heightValue, this.weightValue, this.ageValue);

  double calculateBMI() {
    bmi = weightValue / pow(heightValue / 100, 2);
    if (isMale) {
      bmi *= 1.1;
    }
    return bmi;
  }

  String getStatus() {
    if (bmi < 18.5) {
      return 'UnderWeight';
    }
    if (bmi < 26) {
      return "Normal";
    }
    return "Overweight";
  }
}
