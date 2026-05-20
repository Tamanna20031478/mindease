import 'package:flutter/material.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  final List<Map<String, dynamic>> _weeklyMoods = const [
    {'day': 'Mon', 'emoji': '😊', 'value': 4},
    {'day': 'Tue', 'emoji': '😐', 'value': 3},
    {'day': 'Wed', 'emoji': '😄', 'value': 5},
    {'day': 'Thu', 'emoji': '😔', 'value': 2},
    {'day': 'Fri', 'emoji': '😊', 'value': 4},
    {'day': 'Sat', 'emoji': '😄', 'value': 5},
    {'day': 'Sun', 'emoji': '😐', 'value': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C5CBF),
        elevation: 0,
        title: const Text(
          'Progress',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Row
            Row(
              children: [
                _statCard('7', 'Day Streak', '🔥'),
                const SizedBox(width: 12),
                _statCard('24', 'Sessions', '🧘'),
                const SizedBox(width: 12),
                _statCard('4.2', 'Avg Mood', '😊'),
              ],
            ),

            const SizedBox(height: 24),

            // Weekly Mood Chart
            const Text(
              'Weekly Mood',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  // Bar Chart
                  SizedBox(
                    height: 120,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: _weeklyMoods.map((mood) {
                        final height = (mood['value'] as int) * 16.0;
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              mood['emoji'] as String,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(height: 4),
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 600),
                              width: 28,
                              height: height,
                              decoration: BoxDecoration(
                                color: const Color(0xFF7C5CBF),
                                borderRadius: BorderRadius.circular(6),
                              ),
                            ),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Day Labels
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: _weeklyMoods.map((mood) {
                      return Text(
                        mood['day'] as String,
                        style: const TextStyle(
                          color: Color(0xFF1A1A2E),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Monthly Overview
            const Text(
              'Monthly Overview',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _monthStat('Check-ins completed', '28/30', 0.93),
                  const SizedBox(height: 12),
                  _monthStat('Meditation minutes', '145 min', 0.72),
                  const SizedBox(height: 12),
                  _monthStat('Journal entries', '12/30', 0.40),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Achievements
            const Text(
              'Achievements',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _badge('🔥', '7 Day\nStreak', true),
                const SizedBox(width: 12),
                _badge('🧘', 'First\nSession', true),
                const SizedBox(width: 12),
                _badge('📓', '10 Journal\nEntries', false),
                const SizedBox(width: 12),
                _badge('⭐', '30 Day\nStreak', false),
              ],
            ),

            const SizedBox(height: 24),

            // Mood Distribution
            const Text(
              'Mood Distribution',
              style: TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFEDE7F6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _moodBar('😄 Amazing', 0.25, '25%'),
                  const SizedBox(height: 8),
                  _moodBar('😊 Good', 0.45, '45%'),
                  const SizedBox(height: 8),
                  _moodBar('😐 Okay', 0.20, '20%'),
                  const SizedBox(height: 8),
                  _moodBar('😔 Low', 0.07, '7%'),
                  const SizedBox(height: 8),
                  _moodBar('😢 Awful', 0.03, '3%'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statCard(String value, String label, String emoji) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFEDE7F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF7C5CBF),
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 11,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _monthStat(String label, String value, double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                color: Color(0xFF1A1A2E),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF7C5CBF),
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white,
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7C5CBF)),
            minHeight: 8,
          ),
        ),
      ],
    );
  }

  Widget _badge(String emoji, String label, bool unlocked) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: unlocked ? const Color(0xFF7C5CBF) : const Color(0xFFEDE7F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(
              emoji,
              style: TextStyle(
                fontSize: 28,
                color: unlocked ? Colors.white : Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: unlocked ? Colors.white : Colors.grey,
                fontSize: 10,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _moodBar(String label, double value, String percent) {
    return Row(
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: const TextStyle(
              color: Color(0xFF1A1A2E),
              fontSize: 13,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: value,
              backgroundColor: Colors.white,
              valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7C5CBF)),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          percent,
          style: const TextStyle(
            color: Color(0xFF7C5CBF),
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}