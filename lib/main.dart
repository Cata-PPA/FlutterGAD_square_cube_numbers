import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const SquareCubeNumbers());
}

class SquareCubeNumbers extends StatelessWidget {
  const SquareCubeNumbers({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Square Cube Numbers',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Square Cube Numbers'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  num numberToBeChecked = 0;
  num number = 0;
  num numberToPower2 = 0;
  num numberToPower3 = 0;
  num numberToSquare = 0;
  num numberToCube = 0;
  TextEditingController controller = TextEditingController();
  final String textForSquare = 'Your number is a square';
  final String textForCube = 'Your number is a cube';
  final String textForSqCube = 'Your number is a square and a cube';
  String textReplacer = 'x';

  void checkSqrtCube() {
    setState(() {
      numberToSquare = pow(numberToBeChecked, 1 / 2).ceilToDouble();
      numberToPower2 = pow(numberToSquare, 2);
      numberToCube = pow(numberToBeChecked, 1 / 3).ceilToDouble();
      numberToPower3 = numberToCube * numberToCube * numberToCube;

      if (numberToPower2 == numberToBeChecked) {
        textReplacer = textForSquare;
      } else {
        textReplacer = '';
      }

      if (numberToPower3 == numberToBeChecked) {
        textReplacer = '$textReplacer\n$textForCube';
      } else {
        textReplacer = textReplacer;
      }
    });
    _dialogBuilder(context);
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Result:'),
          content: Text(
            textReplacer,
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            GestureDetector(
              child: const Text(''),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                'Insert number below to check if it is square, cube or both:',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                decoration: const InputDecoration(
                  hintText: 'Insert your number here',
                ),
                controller: controller,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  setState(() {
                    numberToBeChecked = double.tryParse(value)!;
                  });
                },
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: checkSqrtCube,
        child: const Icon(Icons.check_circle_outline),
      ),
    );
  }
}
