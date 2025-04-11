import 'package:flutter/material.dart';
import 'package:ilearn/tutorials.dart';

class TutorialDetailScreen extends StatefulWidget {
  final Tutorial tutorial;

  const TutorialDetailScreen({super.key, required this.tutorial});

  @override
  State<TutorialDetailScreen> createState() => _TutorialDetailScreenState();
}

class _TutorialDetailScreenState extends State<TutorialDetailScreen> {
  late List<String> comments; // To store comments for the tutorial shown.
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments =
        widget.tutorial.comments; // Persist comments in the tutorial objects.
  }

  // Functions to add new comments into the comment list.
  void _addComment() {
    final text = _commentController.text.trim();
    if (text.isNotEmpty) {
      setState(() {
        comments.add(text);
        _commentController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = widget.tutorial;

    return Scaffold(
      appBar: AppBar(title: Text(t.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Video placeholder
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(child: CircularProgressIndicator()),
              ),
            ),
            const SizedBox(height: 16),
            Text(t.name,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('By ${t.author} • ${t.videoLength}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(t.description),
            const Divider(height: 32),
            const Text('Comments',
                style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ...comments.map((c) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text('- $c'),
                )),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _commentController,
                    decoration: const InputDecoration(
                      hintText: 'Write a comment...',
                      isDense: true,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _addComment,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
