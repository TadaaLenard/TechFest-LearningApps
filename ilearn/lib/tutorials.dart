import 'package:flutter/material.dart';
import 'package:ilearn/data_loader.dart';
import 'package:ilearn/tutorialvid.dart';

// Define Tutorial class to store the tutorials' object data
class Tutorial {
  final String name;
  final String videoLength;
  final String author;
  final String description;
  final List<String> comments;

  Tutorial({
    required this.name,
    required this.videoLength,
    required this.author,
    required this.description,
    List<String>? comments,
  }) : comments = comments ?? [];

  // Define fromJson to parse the JSON object into a Tutorial object
  factory Tutorial.fromJson(Map<String, dynamic> json) {
    return Tutorial(
      name: json['name'],
      videoLength: json['videoLength'],
      author: json['author'],
      description: json['description'],
      // Optional: you can add comments if needed
      comments: [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'videoLength': videoLength,
      'author': author,
      'description': description,
    };
  }
}

class TutorialListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Since the UI of the screen needs to wait for the data to be loaded from the JSON,
    // the screen widget should rebuild itself when
    // it receive a value(tutorials data in this case),
    // Hence Future Builder widget class is implemented
    return FutureBuilder<List<Tutorial>>(
      future: loadDataFromJson<Tutorial>(
          'assets/data/tutorials.json', (json) => Tutorial.fromJson(json)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        }

        final tutorials = snapshot.data!;

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
      },
    );
  }
}

// Card widget to display each tutorial information
class TutorialCard extends StatelessWidget {
  final Tutorial tutorial;

  const TutorialCard({super.key, required this.tutorial});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TutorialDetailScreen(tutorial: tutorial),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(tutorial.name,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
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
      ),
    );
  }
}
