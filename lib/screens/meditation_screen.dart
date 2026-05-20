import 'package:flutter/material.dart';
import 'dart:async';

class MeditationScreen extends StatefulWidget {
  final String title;
  final String duration;
  final String category;

  const MeditationScreen({
    super.key,
    required this.title,
    required this.duration,
    required this.category,
  });

  @override
  State<MeditationScreen> createState() => _MeditationScreenState();
}

class _MeditationScreenState extends State<MeditationScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = false;
  int _seconds = 0;
  int _totalSeconds = 300;
  Timer? _timer;
  late AnimationController _animController;

  @override
  void initState() {
    super.initState();
    final parts = widget.duration.split(' ');
    _totalSeconds = int.parse(parts[0]) * 60;
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _animController.dispose();
    super.dispose();
  }

  void _togglePlay() {
    setState(() => _isPlaying = !_isPlaying);
    if (_isPlaying) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          if (_seconds < _totalSeconds) {
            _seconds++;
          } else {
            _isPlaying = false;
            timer.cancel();
          }
        });
      });
    } else {
      _timer?.cancel();
    }
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _seconds = 0;
      _isPlaying = false;
    });
  }

  String get _timeDisplay {
    final remaining = _totalSeconds - _seconds;
    final min = remaining ~/ 60;
    final sec = remaining % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  double get _progress => _seconds / _totalSeconds;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF7C5CBF), Color(0xFF4A3080)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const Spacer(),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        color: Color(0xFFEDE7F6),
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.duration,
                style: const TextStyle(
                  color: Color(0xFFEDE7F6),
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 60),
              AnimatedBuilder(
                animation: _animController,
                builder: (context, child) {
                  return Container(
                    width: 200 + (_animController.value * 20),
                    height: 200 + (_animController.value * 20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.1),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        width: 160,
                        height: 160,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white24,
                        ),
                        child: Center(
                          child: Text(
                            _timeDisplay,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: Colors.white24,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                    minHeight: 6,
                  ),
                ),
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: _reset,
                    icon: const Icon(Icons.replay, color: Colors.white, size: 32),
                  ),
                  const SizedBox(width: 24),
                  GestureDetector(
                    onTap: _togglePlay,
                    child: Container(
                      width: 72,
                      height: 72,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Icon(
                        _isPlaying ? Icons.pause : Icons.play_arrow,
                        color: const Color(0xFF7C5CBF),
                        size: 40,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.volume_up, color: Colors.white, size: 32),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Text(
                _isPlaying ? 'Breathe in... Breathe out...' : 'Tap play to begin',
                style: const TextStyle(
                  color: Color(0xFFEDE7F6),
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}