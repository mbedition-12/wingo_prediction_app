import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(WingoApp());
}

class WingoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wingo Prediction',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Color(0xFF0F111A),
        primaryColor: Color(0xFF00FF00),
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Color(0xFF00FF00), fontFamily: 'Courier'),
          bodyText2: TextStyle(color: Color(0xFF00FF00), fontFamily: 'Courier'),
        ),
      ),
      home: WingoHome(),
    );
  }
}

class WingoHome extends StatefulWidget {
  @override
  _WingoHomeState createState() => _WingoHomeState();
}

class _WingoHomeState extends State<WingoHome> {
  final Random _random = Random();
  String _result = 'Press Predict';

  void _generateResult() {
    final colors = ['Red', 'Green', 'Blue', 'Yellow', 'Orange', 'Purple'];
    final prediction = colors[_random.nextInt(colors.length)];
    setState(() {
      _result = prediction;
    });
  }

  Timer? _autoTimer;

  void _startAutoPrediction() {
    _autoTimer = Timer.periodic(Duration(seconds: 5), (_) {
      _generateResult();
    });
  }

  void _stopAutoPrediction() {
    _autoTimer?.cancel();
  }

  bool _isAutoRunning = false;

  @override
  void dispose() {
    _stopAutoPrediction();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wingo Prediction', style: TextStyle(fontFamily: 'Courier')),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Prediction Result:',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Color(0xFF00FF00), width: 3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                _result,
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF00FF00),
                  fontFamily: 'Courier',
                ),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: _generateResult,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFF00FF00), width: 2),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              child: Text(
                'Predict Now',
                style: TextStyle(
                  color: Color(0xFF00FF00),
                  fontSize: 22,
                  fontFamily: 'Courier',
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_isAutoRunning) {
                    _stopAutoPrediction();
                  } else {
                    _startAutoPrediction();
                  }
                  _isAutoRunning = !_isAutoRunning;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                side: BorderSide(color: Color(0xFF00FF00), width: 2),
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
              ),
              child: Text(
                _isAutoRunning ? 'Stop Auto Prediction' : 'Start Auto Prediction',
                style: TextStyle(
                  color: Color(0xFF00FF00),
                  fontSize: 18,
                  fontFamily: 'Courier',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
