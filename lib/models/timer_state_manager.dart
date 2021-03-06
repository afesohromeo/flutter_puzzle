import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_puzzle/models/model.dart';
import 'package:provider/provider.dart';

class TimerStateManager extends ChangeNotifier {
  bool? _timerStarted = false;
  bool? _shufflePuzzle = true;
  bool? _gettingReady = false;
  int? secondsElapsed = 0;
  bool? _succesful = false;

  final Stopwatch _stopwatch = Stopwatch();
  late final Ticker? _ticker;

  StreamSubscription<int>? _tickerSubscription;

  bool get timerStarted => _timerStarted!;
  bool get gettingReady => _gettingReady!;
  bool get shufflePuzzle => _shufflePuzzle!;
  Stopwatch get stopwatch => _stopwatch;
  bool get succesful => _succesful!;

  set timerStarted(bool timerStarted) {
    _timerStarted = timerStarted;
    notifyListeners();
  }

  set shufflePuzzle(bool shufflePuzzle) {
    _shufflePuzzle = shufflePuzzle;
    notifyListeners();
  }

  set gettingReady(bool gettingReady) {
    _gettingReady = gettingReady;
    notifyListeners();
  }

  void _onTimerStarted() {
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker!.tick().listen((secondsElapsed) => secondsElapsed);
    _timerStarted = true;
  }

  void handleStartStop() {
    log('handling start stop');

    if (_stopwatch.isRunning) {
      log('stopinng');
      timerStarted = !_stopwatch.isRunning;
      _stopwatch.stop();
      _stopwatch.reset();

      notifyListeners();
    } else {
      log('starting');

      _gettingReady = _stopwatch.isRunning;
      _stopwatch.reset();

      _stopwatch.start();
      _succesful = false;
      timerStarted = _stopwatch.isRunning;
      Timer.periodic(const Duration(seconds: 1), (timer) {
        log('timer ticking ${timer.tick}');
        if (_stopwatch.isRunning) {
          notifyListeners();
        } else {
          timer.cancel();
          notifyListeners();
        }
      });

      notifyListeners();
    }
  }

  void stopTimer() {
    _timerStarted = false;

    _stopwatch.stop();
    _stopwatch.reset();
  }

  void reset() {
    _stopwatch.reset();
    notifyListeners();
  }

  void rebuild() {
    notifyListeners();
  }

  void puzzleCompleted() {
    _timerStarted = false;
    _succesful = true;

    _stopwatch.stop();
  }
}
