import 'package:flutter/material.dart';

class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  final TextEditingController _journalController = TextEditingController();
  bool _isWriting = false;

  final List<Map<String, String>> _entries = [
    {
      'date': 'Monday, 19 May 2026',
      'mood': '😊',
      'preview': 'Today was a productive day. I managed to finish my assignment and felt really accomplished...',
    },
    {
      'date': 'Sunday, 18 May 2026',
      'mood': '😐',
      'preview': 'Feeling a bit tired today. Need to rest more and take care of myself better...',
    },
    {
      'date': 'Saturday, 17 May 2026',
      'mood': '😄',
      'preview': 'Had a great weekend! Spent time with friends and felt very energised and happy...',
    },
  ];

  @override
  void dispose() {
    _journalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF7C5CBF),
        elevation: 0,
        title: const Text(
          'Journal',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isWriting ? Icons.list : Icons.edit,
              color: Colors.white,
            ),
            onPressed: () => setState(() => _isWriting = !_isWriting),
          ),
        ],
      ),
      body: _isWriting ? _buildWritingView() : _buildHistoryView(),
    );
  }

  Widget _buildWritingView() {
    return Column(
      children: [
        // Date Header
        Container(
          width: double.infinity,
          color: const Color(0xFFEDE7F6),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Today',
                style: TextStyle(
                  color: Color(0xFF7C5CBF),
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Text(
                'Tuesday, 20 May 2026',
                style: const TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),

        // Mood Selector
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'How are you feeling?',
                style: TextStyle(
                  color: Color(0xFF1A1A2E),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: ['😄', '😊', '😐', '😔', '😢'].map((emoji) {
                  return GestureDetector(
                    onTap: () {},
                    child: Text(
                      emoji,
                      style: const TextStyle(fontSize: 32),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        const Divider(height: 1),

        // Journal Text Input
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _journalController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              decoration: const InputDecoration(
                hintText: 'Write about your day, thoughts, or feelings...',
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey),
              ),
              style: const TextStyle(
                fontSize: 16,
                color: Color(0xFF1A1A2E),
                height: 1.6,
              ),
            ),
          ),
        ),

        // Save Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                if (_journalController.text.isNotEmpty) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      title: const Text(
                        '✅ Journal Saved!',
                        textAlign: TextAlign.center,
                      ),
                      content: const Text(
                        'Your journal entry has been saved successfully.',
                        textAlign: TextAlign.center,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            _journalController.clear();
                            setState(() => _isWriting = false);
                          },
                          child: const Text(
                            'Done',
                            style: TextStyle(
                              color: Color(0xFF7C5CBF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C5CBF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
              child: const Text(
                'Save Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHistoryView() {
    return Column(
      children: [
        // Header
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          color: const Color(0xFFEDE7F6),
          child: const Text(
            'Your journal entries',
            style: TextStyle(
              color: Color(0xFF7C5CBF),
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),

        // Entries List
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _entries.length,
            itemBuilder: (context, index) {
              final entry = _entries[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDE7F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          entry['mood']!,
                          style: const TextStyle(fontSize: 24),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          entry['date']!,
                          style: const TextStyle(
                            color: Color(0xFF7C5CBF),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      entry['preview']!,
                      style: const TextStyle(
                        color: Color(0xFF1A1A2E),
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // New Entry Button
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => setState(() => _isWriting = true),
              icon: const Icon(Icons.edit, color: Colors.white),
              label: const Text(
                'New Entry',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF7C5CBF),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(28),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}