import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MyProject extends StatefulWidget {
  const MyProject({Key? key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  cards(String imagePath) {
    return Container(
      height: 450,
      width: MediaQuery.of(context).size.width * 0.9,
      child: Card(
        child: Container(
          margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                imagePath, // Provide the image path here
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: const Color(0xff252525),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          alignment: Alignment.center,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: 10,
            ),
            cards('assets/1.jpg'),
            cards('assets/2.jpg'),
            cards('assets/3.jpg'),
            cards('assets/4.jpg'),
            cards('assets/5.jpg'),
            cards('assets/6.jpg'),
            cards('assets/7.jpg'),
            cards('assets/8.jpg'),
            cards('assets/9.jpg'),
            cards('assets/10.jpg'),
            cards('assets/11.jpg'),
            cards('assets/12.jpg'),
            cards('assets/13.jpg'),
          ]),
        ),
      ),
    );
  }
}
