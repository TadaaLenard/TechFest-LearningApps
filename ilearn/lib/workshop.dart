import 'package:flutter/material.dart';
import 'package:ilearn/data_loader.dart';

// Define Workshop class to store the workshops' object data
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

  // Create workshop instances to store workshop data
  factory Workshop.fromJson(Map<String, dynamic> json) {
    return Workshop(
      name: json['name'],
      dateTime: json['dateTime'],
      venue: json['venue'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'dateTime': dateTime,
      'venue': venue,
      'description': description,
    };
  }
}

class WorkshopListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Since the UI of the screen needs to wait for the data to be loaded from the JSON,
    // the screen widget should rebuild itself when
    // it receive a value(workshop data in this case),
    // Hence Future Builder widget class is implemented
    return FutureBuilder<List<Workshop>>(
      future: loadDataFromJson<Workshop>(
        'assets/data/workshops.json',
        (json) => Workshop.fromJson(json),
      ),
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

        final workshops = snapshot.data!;

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
      },
    );
  }
}

// Card widget to display each workshop information
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
