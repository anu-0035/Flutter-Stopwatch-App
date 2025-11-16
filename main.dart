import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Stopwatch App",
      home: StopwatchScreen(),
    );
  }
}

class StopwatchScreen extends StatefulWidget {
  @override
  _StopwatchScreenState createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  Timer? timer;
  int seconds = 0;
  bool isRunning = false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      setState(() => seconds++);
    });
  }

  void toggleStartPause() {
    if (isRunning) {
      timer?.cancel();
    } else {
      startTimer();
    }
    setState(() => isRunning = !isRunning);
  }

  void resetTimer() {
    timer?.cancel();
    setState(() {
      seconds = 0;
      isRunning = false;
    });
  }

  String formatTime(int s) {
    final minutes = (s ~/ 60).toString().padLeft(2, "0");
    final secs = (s % 60).toString().padLeft(2, "0");
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade900, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // Timer Display Circle
              Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white70, width: 4),
                ),
                alignment: Alignment.center,
                child: Text(
                  formatTime(seconds),
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Buttons Row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                  // Reset button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: resetTimer,
                    child: Text(
                      "Reset",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),

                  SizedBox(width: 30),

                  // Start / Pause button
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent.shade700,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: toggleStartPause,
                    child: Row(
                      children: [
                        Icon(
                          isRunning ? Icons.pause : Icons.play_arrow,
                          size: 26,
                        ),
                        SizedBox(width: 8),
                        Text(
                          isRunning ? "Pause" : "Start",
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
