import 'package:auzmore_assesment/models/training_model.dart';
import 'package:flutter/material.dart';

class TrainingDetailScreen extends StatelessWidget {
  final Training training;

  const TrainingDetailScreen({super.key, required this.training});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(training.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Location: ${training.location}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text("Trainer: ${training.trainerName}",
                style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            Text(training.description, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
