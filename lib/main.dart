import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: const Color(0xFFD6E4FF), // Fundal similar cu imaginea
      ),
      home: const BMICalculator(),
    );
  }
}

class BMICalculator extends StatefulWidget {
  const BMICalculator({Key? key}) : super(key: key);

  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  String gender = "Male"; // Genul implicit
  double weight = 70; // Greutatea implicită
  int age = 23; // Vârsta implicită
  double height = 170; // Înălțimea implicită
  double bmi = 20.4; // IMC calculat
  String bmiStatus = "Underweight";

  // Metoda de calcul IMC
  void calculateBMI() {
    setState(() {
      double heightInMeters = height / 100;
      bmi = weight / (heightInMeters * heightInMeters);

      // Statusul IMC
      if (bmi < 18.5) {
        bmiStatus = "Underweight";
      } else if (bmi >= 18.5 && bmi < 24.9) {
        bmiStatus = "Normal";
      } else if (bmi >= 25 && bmi < 29.9) {
        bmiStatus = "Overweight";
      } else {
        bmiStatus = "Obesity";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome 😊',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'BMI Calculator',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 24),
            // Selectare gen
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GenderSelector(
                  icon: Icons.male,
                  title: "Male",
                  isSelected: gender == "Male",
                  onTap: () => setState(() {
                    gender = "Male";
                  }),
                ),
                const SizedBox(width: 16),
                GenderSelector(
                  icon: Icons.female,
                  title: "Female",
                  isSelected: gender == "Female",
                  onTap: () => setState(() {
                    gender = "Female";
                  }),
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Introducere greutate și vârstă
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NumberInputField(
                  label: "Weight",
                  value: weight,
                  unit: 'kg',
                  onChanged: (newValue) {
                    setState(() {
                      weight = newValue;
                    });
                  },
                ),
                NumberInputField(
                  label: "Age",
                  value: age.toDouble(),
                  unit: '',
                  onChanged: (newValue) {
                    setState(() {
                      age = newValue.toInt();
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Introducere înălțime
            Container(
              width: 200,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Height (cm)',
                  labelStyle: const TextStyle(color: Colors.black54),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                ),
                onChanged: (value) {
                  height = double.tryParse(value) ?? height;
                },
              ),
            ),
            const SizedBox(height: 24),
            // Rezultatul IMC
            Text(
              bmi.toStringAsFixed(1),
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            Text(
              bmiStatus,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 24),
            // Butonul de calculare IMC
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF007BFF), // Culoarea albastru
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: calculateBMI,
              child: const Text(
                "Let's Go",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GenderSelector extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderSelector({
    Key? key,
    required this.icon,
    required this.title,
    required this.isSelected,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? const Color(0xFF007BFF) : Colors.white,
          border: Border.all(
            color: isSelected ? const Color(0xFF007BFF) : Colors.black26,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: isSelected ? Colors.white : Colors.black),
            const SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberInputField extends StatelessWidget {
  final String label;
  final double value;
  final String unit;
  final Function(double) onChanged;

  const NumberInputField({
    Key? key,
    required this.label,
    required this.value,
    required this.unit,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 18),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                onChanged(value - 1);
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              value.toStringAsFixed(0),
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Text(
              unit,
              style: const TextStyle(fontSize: 18),
            ),
            IconButton(
              onPressed: () {
                onChanged(value + 1);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ],
    );
  }
}
