import 'package:flutter/material.dart';
import 'meditation_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All', 'Meditation', 'Breathing', 'Sleep', 'Anxiety', 'Focus'
  ];

  final List<Map<String, dynamic>> _sessions = [
    {'title': 'Morning Calm', 'category': 'Meditation', 'duration': '5 min', 'icon': Icons.self_improvement},
    {'title': 'Deep Breathing', 'category': 'Breathing', 'duration': '7 min', 'icon': Icons.air},
    {'title': 'Sleep Stories', 'category': 'Sleep', 'duration': '20 min', 'icon': Icons.nightlight},
    {'title': 'Anxiety Relief', 'category': 'Anxiety', 'duration': '10 min', 'icon': Icons.spa},
    {'title': 'Focus Flow', 'category': 'Focus', 'duration': '15 min', 'icon': Icons.center_focus_strong},
    {'title': 'Body Scan', 'category': 'Meditation', 'duration': '12 min', 'icon': Icons.accessibility_new},
    {'title': 'Box Breathing', 'category': 'Breathing', 'duration': '5 min', 'icon': Icons.crop_square},
    {'title': 'Deep Sleep', 'category': 'Sleep', 'duration': '30 min', 'icon': Icons.bedtime},
    {'title': 'Stress Relief', 'category': 'Anxiety', 'duration': '8 min', 'icon': Icons.favorite},
    {'title': 'Study Focus', 'category': 'Focus', 'duration': '25 min', 'icon': Icons.menu_book},
    {'title': 'Loving Kindness', 'category': 'Meditation', 'duration': '10 min', 'icon': Icons.volunteer_activism},
    {'title': 'Power Nap', 'category': 'Sleep', 'duration': '15 min', 'icon': Icons.power_settings_new},
  ];

  List<Map<String, dynamic>> get _filteredSessions {
    return _sessions.where((session) {
      final matchesCategory = _selectedCategory == 'All' ||
          session['category'] == _selectedCategory;
      final matchesSearch = session['title']!
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C5CBF),
        elevation: 0,
        title: const Text(
          'Explore',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            color: const Color(0xFF7C5CBF),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: TextField(
              controller: _searchController,
              onChanged: (value) => setState(() {}),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Search sessions...',
                hintStyle: const TextStyle(color: Color(0xFFEDE7F6)),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFEDE7F6)),
                filled: true,
                fillColor: const Color(0xFF4A3080),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Category Filter
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _categories.length,
              itemBuilder: (context, index) {
                final isSelected = _selectedCategory == _categories[index];
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = _categories[index]),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF7C5CBF)
                          : const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _categories[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Sessions Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.0,
              ),
              itemCount: _filteredSessions.length,
              itemBuilder: (context, index) {
                final session = _filteredSessions[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MeditationScreen(
                          title: session['title'] as String,
                          duration: session['duration'] as String,
                          category: session['category'] as String,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFEDE7F6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7C5CBF),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Icon(
                            session['icon'] as IconData,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          session['title'] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Color(0xFF1A1A2E),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          session['duration'] as String,
                          style: const TextStyle(
                            color: Color(0xFF7C5CBF),
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}