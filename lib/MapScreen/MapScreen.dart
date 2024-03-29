import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class MapMultiMarker extends StatefulWidget {
  const MapMultiMarker({Key? key}) : super(key: key);

  @override
  State<MapMultiMarker> createState() => _MapMultiMarkerState();
}

class _MapMultiMarkerState extends State<MapMultiMarker> {
  final List<Map<String, dynamic>> cityList = const [
    {
      "address": "India",
      "id": "Maharastra",
      "image":
          "https://i.pinimg.com/originals/b7/3a/13/b73a132e165978fa07c6abd2879b47a6.png",
      "lat": 17.871819,
      "lng": 76.066515,
      "name": "Maharastra India",
      "region": "South Asia",
      "externalLink": "https://www.google.com",
    },
    {
      "address": "Australia",
      "id": "Australia",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": -30.640776,
      "lng": 139.823873,
      "name": "Australia",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "China",
      "id": "china",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 27.350479,
      "lng": 109.871443,
      "name": "china",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "Russia",
      "id": "russia",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 67.153962,
      "lng": 123.260912,
      "name": "russia",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "Turkey",
      "id": "turkey",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 38.447804,
      "lng": 42.917553,
      "name": "turkey",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "South Africa",
      "id": "south africa",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": -28.815585,
      "lng": 22.486908,
      "name": "south africa",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "Gabon",
      "id": "gabon",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": -0.571271,
      "lng": 11.834921,
      "name": "gabon",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "United Kingdom",
      "id": "united kingdom",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 54.562638,
      "lng": -2.552916,
      "name": "united kingdom",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "United States",
      "id": "United States",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": 36.661342,
      "lng": -100.642298,
      "name": "United States",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "Brazil",
      "id": "Brazil",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": -10.237119,
      "lng": -42.107141,
      "name": "Brazil",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
    {
      "address": "State Of Parana",
      "id": "State Of Parana",
      "image":
          "https://upload.wikimedia.org/wikipedia/commons/9/96/Delhi_Red_fort.jpg",
      "lat": -25.881321,
      "lng": -51.610622,
      "name": "State Of Parana",
      "phone": "7014333352",
      "region": "South Asia",
      "externalLink": "https://www.example.com/delhi",
    },
  ];

  final Map<String, Marker> _markers = {};

  Future<void> _onMapCreated(GoogleMapController controller) async {
    _markers.clear();
    setState(() {
      for (int i = 0; i < cityList.length; i++) {
        final marker = Marker(
          markerId: MarkerId(cityList[i]['id']),
          position: LatLng(cityList[i]['lat'], cityList[i]['lng']),
          infoWindow: InfoWindow(
            title: cityList[i]['name'],
            snippet: cityList[i]['address'],
            onTap: () {
              print("${cityList[i]['lat']}, ${cityList[i]['lng']}");
              launchMap(cityList[i]['lat'], cityList[i]['lng']);
            },
          ),
          onTap: () {
            print("Clicked on marker: ${cityList[i]['name']}");
            // Open the external link when the marker is tapped.
            launchExternalLink(cityList[i]['externalLink']);
          },
        );
        _markers[cityList[i]['name']] = marker;
      }
    });
  }

  launchMap(lat, long) {
    MapsLauncher.launchCoordinates(lat, long);
  }

  launchExternalLink(String externalLink) async {
    if (await canLaunch(externalLink)) {
      await launch(externalLink);
    } else {
      throw 'Could not launch $externalLink';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: LatLng(cityList[0]['lat'], cityList[0]['lng']),
        zoom: 0,
      ),
      markers: _markers.values.toSet(),
    );
  }
}
