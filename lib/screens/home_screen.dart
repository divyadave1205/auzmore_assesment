import 'package:auzmore_assesment/models/training_model.dart';
import 'package:auzmore_assesment/screens/training_details_screen.dart';
import 'package:auzmore_assesment/services/mock_data.dart';
import 'package:auzmore_assesment/widgets/filter_model.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  String? selectedLocation, selectedTrainer, selectedName;
  CarouselSliderController carouselController = CarouselSliderController();
  List<Training> filteredList = trainingList;

  void openFilterModal() async {
    await showModalBottomSheet(
      context: context,
      builder: (_) => FilterModal(
        onFilterApply: (location, trainer, name) {
          setState(() {
            selectedLocation = location;
            selectedTrainer = trainer;
            selectedName = name;
            filteredList = trainingList.where((training) {
              return (location == null || training.location == location) &&
                  (trainer == null || training.trainerName == trainer) &&
                  (name == null || training.title == name);
            }).toList();
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.red,
          title: const Text(
            "Trainings",
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(
                Icons.menu,
                color: Colors.white,
                size: 25,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  color: Colors.red,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 5,
                  color: Colors.white,
                ),
                Expanded(
                  child: Container(
                    color: Colors.grey.shade300,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        "Highlights",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        carouselController.nextPage();
                      },
                      child: Container(
                        height: 60,
                        width: 20,
                        margin: const EdgeInsets.all(20),
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_left,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: CarouselSlider(
                        carouselController: carouselController,
                        options: CarouselOptions(
                          height: 120,
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                        ),
                        items: List.generate(
                          trainingList.length,
                          (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Stack(
                              children: [
                                SizedBox(
                                  height: 300,
                                  width: MediaQuery.sizeOf(context).width - 80,
                                  child: Image.network(
                                    trainingList[index].image,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  color: Colors.black.withOpacity(0.3),
                                  height: 300,
                                  width: MediaQuery.sizeOf(context).width - 80,
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        trainingList[index].title,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        '${trainingList[index].location}, ${trainingList[index].dateRange}',
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        trainingList[index].price.toString(),
                                        style: const TextStyle(
                                          fontSize: 10,
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        carouselController.previousPage();
                      },
                      child: Container(
                        height: 60,
                        width: 20,
                        margin: const EdgeInsets.all(20),
                        color: Colors.black.withOpacity(0.5),
                        child: const Center(
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        onPressed: openFilterModal,
                        child: const Row(
                          children: [
                            Icon(Icons.sort),
                            SizedBox(width: 20),
                            Text(
                              "Filter",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final training = filteredList[index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    TrainingDetailScreen(training: training),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            color: Colors.white,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 100,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        training.dateRange,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        training.timeRange,
                                        style: const TextStyle(
                                          fontSize: 10,
                                        ),
                                      ),
                                      Text(
                                        training.location,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        training.address,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 100,
                                  child: VerticalDivider(),
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        training.status,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      Text(
                                        training.title,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  training.trainerImage,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                'Keynote Speaker',
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                training.trainerName,
                                                style: const TextStyle(
                                                  fontSize: 10,
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }
}
