import 'package:flutter/material.dart';

class Workshop {
  final String name;
  final String dateTime;
  final String venue;
  final String description;

  Workshop({
    required this.name,
    required this.dateTime,
    required this.venue,
    required this.description,
  });
}

class WorkshopListScreen extends StatelessWidget {
  final List<Workshop> workshops = [
    Workshop(
      name: 'Quantum Physics Fundamentals',
      dateTime: 'April 15, 2025 • 10:00 AM - 12:00 PM',
      venue: 'Physics Lab 5',
      description:
          'A deep dive into the core principles of quantum physics, including wave-particle duality and quantum entanglement.',
    ),
    Workshop(
      name: 'Organic Chemistry Workshop',
      dateTime: 'April 16, 2025 • 2:00 PM - 4:00 PM',
      venue: 'Chemistry Lab 2',
      description:
          'Hands-on experiments to understand organic compounds, reaction mechanisms, and functional groups.',
    ),
    Workshop(
      name: 'Advanced Spanish Conversation',
      dateTime: 'April 17, 2025 • 11:00 AM - 1:00 PM',
      venue: 'School of Language Auditorium',
      description:
          'Boost your Spanish skills through immersive conversations and interactive activities.',
    ),
    Workshop(
      name: 'Introduction to Machine Learning',
      dateTime: 'April 18, 2025 • 3:00 PM - 5:00 PM',
      venue: 'School of Computer Sciences Lab 3',
      description:
          'Get an overview of machine learning algorithms and their applications, with hands-on coding exercises.',
    ),
    Workshop(
      name: 'Creative Writing for Beginners',
      dateTime: 'April 19, 2025 • 1:00 PM - 3:00 PM',
      venue: 'Webex',
      description:
          'Learn the basics of creative writing, including storytelling techniques, character development, and plot structuring.',
    ),
    Workshop(
      name: 'Introduction to Astronomy',
      dateTime: 'April 20, 2025 • 6:00 PM - 8:00 PM',
      venue: 'USM Observatory',
      description:
          'Explore the night sky, the stars, and our solar system with expert guidance and telescope observation.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Workshops'),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12.0),
        itemCount: workshops.length,
        itemBuilder: (context, index) {
          return WorkshopCard(workshop: workshops[index]);
        },
      ),
    );
  }
}

class WorkshopCard extends StatelessWidget {
  final Workshop workshop;

  const WorkshopCard({super.key, required this.workshop});

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
            Text(workshop.name,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(workshop.dateTime, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4),
            Text('Venue: ${workshop.venue}',
                style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 12),
            Text(workshop.description),
          ],
        ),
      ),
    );
  }
}
