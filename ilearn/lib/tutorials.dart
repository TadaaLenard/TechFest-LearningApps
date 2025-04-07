import 'package:flutter/material.dart';

class Tutorial {
  final String name;
  final String videoLength;
  final String author;
  final String description;

  Tutorial({
    required this.name,
    required this.videoLength,
    required this.author,
    required this.description,
  });
}

class TutorialListScreen extends StatelessWidget {
  final List<Tutorial> tutorials = [
    Tutorial(
      name: 'Introduction to Classical Mechanics',
      videoLength: '1 hour 45 minutes',
      author: 'Dr. Albert Newton',
      description:
          'Learn the fundamentals of classical mechanics, including Newton\'s laws and motion.',
    ),
    Tutorial(
      name: 'Organic Chemistry: Hydrocarbons',
      videoLength: '2 hours 30 minutes',
      author: 'Prof. Sarah Johnson',
      description:
          'An in-depth tutorial on the properties and reactions of hydrocarbons in organic chemistry.',
    ),
    Tutorial(
      name: 'Basic Spanish: Beginner Level',
      videoLength: '1 hour 20 minutes',
      author: 'Carlos Garcia',
      description:
          'A beginner-level Spanish tutorial covering basic vocabulary, greetings, and sentence structure.',
    ),
    Tutorial(
      name: 'Introduction to Genetics',
      videoLength: '2 hours 0 minutes',
      author: 'Dr. Emily Watson',
      description:
          'Understand the basics of genetics, including inheritance, DNA structure, and gene expression.',
    ),
    Tutorial(
      name: 'Basic French Conversation',
      videoLength: '1 hour 10 minutes',
      author: 'Marie Dubois',
      description:
          'Improve your French through simple conversation practices, ideal for beginners.',
    ),
    Tutorial(
      name: 'Physics of Electromagnetism',
      videoLength: '2 hours 45 minutes',
      author: 'Dr. Maxwell Faraday',
      description:
          'Dive deep into the principles of electromagnetism, covering electric fields, magnetic fields, and waves.',
    ),
    Tutorial(
      name: 'Introductory Mandarin for Beginners',
      videoLength: '1 hour 30 minutes',
      author: 'Ling Zhang',
      description:
          'Learn the basics of Mandarin Chinese, including common phrases and basic grammar.',
    ),
    Tutorial(
      name: 'Environmental Science: Ecosystems and Biodiversity',
      videoLength: '2 hours 15 minutes',
      author: 'Dr. Laura Green',
      description:
          'Explore the importance of ecosystems and biodiversity in this detailed environmental science tutorial.',
    ),
    Tutorial(
      name: 'Advanced Physics: Quantum Mechanics',
      videoLength: '3 hours 0 minutes',
      author: 'Dr. Richard Feynman',
      description:
          'A deep dive into quantum mechanics, including wave functions, uncertainty principle, and quantum entanglement.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorials'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: tutorials.length,
        itemBuilder: (context, index) {
          return TutorialCard(tutorial: tutorials[index]);
        },
      ),
    );
  }
}

class TutorialCard extends StatelessWidget {
  final Tutorial tutorial;

  const TutorialCard({super.key, required this.tutorial});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tutorial.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Video Length: ${tutorial.videoLength}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text('Author: ${tutorial.author}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(tutorial.description),
          ],
        ),
      ),
    );
  }
}
