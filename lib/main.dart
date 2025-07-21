import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMIScreen(),
    );
  }
}

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key});

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final heightCtrl = TextEditingController();
  final weightCtrl = TextEditingController();
  double? bmi;
  String category = '';

  void calculateBMI() {
    final height = double.tryParse(heightCtrl.text);
    final weight = double.tryParse(weightCtrl.text);

    if (height != null && weight != null && height > 0) {
      final heightM = height / 100;
      final result = weight / (heightM * heightM);

      setState(() {
        bmi = result;
        if (result < 18.5) {
          category = 'Underweight';
        } else if (result < 24.9) {
          category = 'Normal weight';
        } else if (result < 29.9) {
          category = 'Overweight';
        } else {
          category = 'Obese';
        }
      });
    }
  }

  void reset() {
    heightCtrl.clear();
    weightCtrl.clear();
    setState(() {
      bmi = null;
      category = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator'), backgroundColor: Colors.teal),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter height (cm) and weight (kg):'),
            const SizedBox(height: 12),
            TextField(
              controller: heightCtrl,
              decoration: const InputDecoration(labelText: 'Height (cm)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightCtrl,
              decoration: const InputDecoration(labelText: 'Weight (kg)', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: calculateBMI, child: const Text('Calculate')),
            ElevatedButton(
              onPressed: reset,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              child: const Text('Reset'),
            ),

            const SizedBox(height: 20),
            if (bmi != null) ...[
              Text('Your BMI: ${bmi!.toStringAsFixed(1)}', style: const TextStyle(fontSize: 20)),
              Text('Category: $category', style: const TextStyle(fontSize: 18)),
            ],
          ],
        ),
      ),
    );
  }
}

