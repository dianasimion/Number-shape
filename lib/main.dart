import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:core';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Number Shape',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: MyHomePage(title: 'Number Shape'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();

  static bool isSquare(int num) {
    if (num >= 0) {
      int val = sqrt(num).toInt();
      return ((val * val) == num);
    }

    return false;
  }

  static bool isTriangular(int num) {
    int n = pow(num, 1.0 / 3.0).round();
    if (num == n * n * n) {
      return true;
    }

    return false;
  }

  Future<void> _showMyDialog(Text message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(_controller.value.text),
          content: SingleChildScrollView(child: message),
        );
      },
    );
  }

  Future<void> _check() async {
    try {
      if (isSquare(int.parse(_controller.value.text)) &&
          isTriangular(int.parse(_controller.value.text))) {
        await _showMyDialog(Text(
            'Number ${_controller.value.text} is both SQUARE and TRIANGULAR'));
      } else if (isSquare(int.parse(_controller.value.text))) {
        await _showMyDialog(Text('Number ${_controller.value.text} is SQUARE'));
      } else if (isTriangular(int.parse(_controller.value.text))) {
        await _showMyDialog(
            Text('Number ${_controller.value.text} is TRIANGULAR'));
      } else {
        await _showMyDialog(Text(
            'Number ${_controller.value.text} is neither SQUARE or TRIANGULAR'));
      }
    } catch (E) {
      await _showMyDialog(
          Text('Invalid input. Please insert an integer value.'));
    }

    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Please enter a number to see if it\'s square or triangular',
              style: Theme.of(context).textTheme.headline6,
            ),
            TextField(
              keyboardType: TextInputType.number,
              controller: _controller,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _check();
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
