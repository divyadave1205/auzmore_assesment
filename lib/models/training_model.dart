class Training {
  final String title;
  final String description;
  final String trainerName;
  final String trainerImage;
  final String image; // Training Image
  final String dateRange; // e.g., "11 - 17 Oct 2024"
  final String timeRange; // e.g., "8 PM to 10 PM"
  final String location; // City or Area
  final String address; // Detailed address
  final String status; // e.g., "Fast Filling", "Early Bird"
  final double price; // e.g., 345.0

  Training({
    required this.title,
    required this.description,
    required this.trainerName,
    required this.trainerImage,
    required this.image,
    required this.dateRange,
    required this.timeRange,
    required this.location,
    required this.address,
    required this.status,
    required this.price,
  });
}
