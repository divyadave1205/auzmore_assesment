import 'package:auzmore_assesment/services/mock_data.dart';
import 'package:flutter/material.dart';

class FilterModal extends StatefulWidget {
  final Function(String?, String?, String?) onFilterApply;

  const FilterModal({super.key, required this.onFilterApply});

  @override
  FilterModalState createState() => FilterModalState();
}

class FilterModalState extends State<FilterModal> {
  String? location, trainer, name;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Filters",
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton<String>(
              hint: const Text("Select Location"),
              value: location,
              items: trainingList
                  .map((e) => DropdownMenuItem(
                      value: e.location, child: Text(e.location)))
                  .toList(),
              onChanged: (val) => setState(() => location = val),
            ),
            DropdownButton<String>(
              hint: const Text("Select Trainer Name"),
              value: trainer,
              items: trainingList
                  .map(
                    (e) => DropdownMenuItem(
                      value: e.trainerName,
                      child: Text(e.trainerName),
                    ),
                  )
                  .toList(),
              onChanged: (val) => setState(() => trainer = val),
            ),
            DropdownButton<String>(
              hint: const Text("Select Training Name"),
              value: name,
              items: trainingList
                  .map((e) =>
                      DropdownMenuItem(value: e.title, child: Text(e.title)))
                  .toList(),
              onChanged: (val) => setState(() => trainer = val),
            ),
            const SizedBox(height: 40),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  widget.onFilterApply(location, trainer, name);
                  Navigator.pop(context);
                },
                child: const Text(
                  "Apply Filter",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
