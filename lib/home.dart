import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/MapScreen/MapScreen.dart';
import 'package:portfolio/chat_screen.dart';
import 'package:sliding_sheet2/sliding_sheet2.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  final WaterSourcesAvailableOnEarthUri = Uri.parse('https://map.sdg661.app/#');
  final LessonsUri = Uri.parse('https://climatekids.nasa.gov/menu/water/');
  final QuizOnWaterUri =
      Uri.parse('https://swot.jpl.nasa.gov/resources/wheres-water-quiz/');

  details(String nums, String type) {
    return Row(
      children: [
        Text(
          nums,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Container(margin: const EdgeInsets.only(top: 10), child: Text(type)),
      ],
    );
  }

  cards(String imageAsset, String text, Function? onTap) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: Container(
        width: 170,
        height: 170,
        child: Card(
          margin: const EdgeInsets.all(0),
          color: const Color(0xff252525),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  imageAsset, // Replace this with the asset path of your image
                  height: 80, // Adjust the height as needed
                ),
                const SizedBox(height: 10),
                Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          PopupMenuButton(
            color: Colors.black,
            icon: const Icon(
              Icons.menu,
              color: Colors.white,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: TextButton(
                  child: const Text(
                    '\nInitiatives',
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'project');
                  },
                ),
              ),
              PopupMenuItem(
                child: TextButton(
                  child: const Text(
                    'About Us',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, 'about');
                  },
                ),
              ),
            ],
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SlidingSheet(
        elevation: 8,
        cornerRadius: 50,
        snapSpec: const SnapSpec(
          snap: true,
          snappings: [0.35, 0.7, 1.0],
          positioning: SnapPositioning.relativeToAvailableSpace,
        ),
        body: Container(
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(),
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Colors.black, Colors.transparent])
                        .createShader(
                            Rect.fromLTRB(0, 0, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    'assets/home.jpg',
                    height: 600,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.55),
                child: const Column(
                  children: [
                    Text(
                      'AQUALEARNER',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Every Drop Counts',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        builder: (context, state) {
          return Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
            height: 500,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    details('', ''),
                    details('', ''),
                    details('', ''),
                  ],
                ),
                const SizedBox(
                  height: 0,
                ),
                const Text(
                  'FEATURES',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cards('assets/water.png',
                            'Water Sources Available\n              On Earth',
                            () {
                          launchUrl(
                            WaterSourcesAvailableOnEarthUri,
                            mode: LaunchMode.externalApplication,
                          );
                        }),
                        cards('assets/threat.png',
                            'Active Threats To Fresh\n                Water',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MapMultiMarker()),
                          );
                        }),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        cards('assets/lesson.png', 'Lesson', () {
                          launchUrl(
                            LessonsUri,
                            mode: LaunchMode.externalApplication,
                          );
                        }),
                        cards('assets/quiz.png', 'Water Quiz', () {
                          launchUrl(
                            QuizOnWaterUri,
                            mode: LaunchMode.externalApplication,
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatGPTScreen()),
          );
        },
        child: const FaIcon(FontAwesomeIcons.robot),
        backgroundColor: const Color.fromARGB(255, 255, 153, 60),
      ),
    );
  }
}
