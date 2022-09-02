// ignore_for_file: prefer_const_constructors, avoid_function_literals_in_foreach_calls, prefer_final_fields, sized_box_for_whitespace, unnecessary_string_interpolations

import 'dart:async';
// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:location/location.dart';
import 'package:quev/screens/welcome.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../screens/google_signin.dart';
import './ev_collections.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.black,
        fontFamily: 'Product',
      ),
      home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final itemController = ItemScrollController();
  bool loading = true;
  String activeId = '';
  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();
  bool isMapCreated = false;
  LocationData? currentLocation;
  bool alert = false;
  String destination = "";
  bool error = false;

  void setAlert() {
    setState(() {
      alert = true;
    });
    Future.delayed(Duration(seconds: 5), () {
      setState(() {
        alert = false;
      });
    });
  }

  void setDestination(String value) {
    setState(() {
      destination = value;
    });
  }

  static String googleApiKey = "AIzaSyDjj1s1972Cg_pDtmWC5QGse4UMIcgWQUQ";

  List<LatLng> polylineCoordinates = [];
  List<ChargingLocation> locations = [];
  Set<Marker> _markers = {};

  // Get Poly Points
  void getPolyPoints(desLat, desLng, id, name) async {
    polylineCoordinates = [];
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult results = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
        PointLatLng(desLat, desLng));

    if (results.points.isNotEmpty) {
      results.points.forEach((point) {
        return polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      final int index = locations.indexWhere((element) => element.id == id);
      setState(() {
        activeId = id;
        itemController.scrollTo(
            index: index, duration: Duration(milliseconds: 500));
      });
    }
    setDestination(name);
  }

  // Get Locations
  void getLocations() async {
    try {
      Location location = Location();
      var res = await location.getLocation();
      currentLocation = res;

      location.onLocationChanged.listen((newLoc) {
        currentLocation = newLoc;
        setState(() {});
      });

      late String url =
          "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${currentLocation!.latitude!}%2C${currentLocation!.longitude!}&radius=30000&keyword=electric%2Cvehicle%2Ccharging&key=AIzaSyDjj1s1972Cg_pDtmWC5QGse4UMIcgWQUQ";
      var response = await http.get(Uri.parse(url));
      var data = await jsonDecode(response.body);
      data['results'].forEach((element) {
        ChargingLocation data = ChargingLocation(
            lat:
                double.parse(element['geometry']['location']['lat'].toString()),
            lng:
                double.parse(element['geometry']['location']['lng'].toString()),
            name: element['name'],
            id: element['place_id'],
            open: true,
            vicinity: element["vicinity"]);
        locations.add(data);
      });

      locations.forEach((element) {
        _markers.add(Marker(
            markerId: MarkerId(element.id),
            position: LatLng(element.lat, element.lng),
            onTap: () {
              getPolyPoints(element.lat, element.lng, element.id, element.name);
            },
            infoWindow: InfoWindow(
                title: element.name,
                snippet: element.vicinity
                    .replaceRange(20, element.vicinity.length, '...')),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueBlue)));
      });
      setState(() {});
    } catch (err) {
      error = true;
    }
  }

  @override
  void initState() {
    super.initState();
    DefaultAssetBundle.of(context)
        .loadString('assets/images/dark.json')
        .then((value) {
      mapTheme = value;
    });
    // getCurrentLocation();
    getLocations();
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loading == true) {
      return (Scaffold(
        body: Container(
          color: Color.fromARGB(255, 7, 24, 52),
          child: Center(
            child: SpinKitPulse(
              color: Colors.white,
            ),
          ),
        ),
      ));
    } else if (error) {
      return (Scaffold(
        body: Container(
          color: Color.fromARGB(255, 10, 44, 71),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text("Oops!",
                    style: TextStyle(color: Colors.white, fontSize: 60)),
                Text(
                  "Please Reopen the App",
                  style: TextStyle(color: Colors.white),
                )
              ])),
        ),
      ));
    } else {
      return (Scaffold(
          extendBody: true,
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1),
                child: FloatingActionButton(
                  backgroundColor: Colors.grey[100],
                  onPressed: () async {
                    await FirebaseServices().signOut();
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Welcome()));
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue[800], shape: BoxShape.circle),
                    child: Center(
                        child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset(
                        'assets/images/shut_down.png',
                        color: Colors.grey[100],
                        scale: 2.5,
                      ),
                    )),
                  ),
                ),
              ),
              Visibility(
                visible: (polylineCoordinates.isEmpty ? false : true),
                child: FloatingActionButton(
                  backgroundColor: Colors.red,
                  onPressed: () => setAlert(),
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                    child: Center(
                      child: Icon(
                        Icons.sos,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: currentLocation == null
              ? Container(
                  color: Color.fromARGB(255, 10, 44, 71),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      SpinKitPulse(
                        color: Colors.white,
                      ),
                      Text(
                        "Fetching Location",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )
              : Stack(
                  children: [
                    GoogleMap(
                      mapType: MapType.normal,
                      mapToolbarEnabled: false,
                      zoomControlsEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(currentLocation!.latitude!,
                              currentLocation!.longitude!),
                          zoom: 14),
                      onMapCreated: (GoogleMapController controller) {
                        controller.setMapStyle(mapTheme);
                      },
                      polylines: {
                        Polyline(
                            polylineId: PolylineId("route"),
                            points: polylineCoordinates,
                            color: Colors.cyanAccent,
                            width: 6)
                      },
                      markers: {
                        ..._markers,
                        Marker(
                            markerId: MarkerId("currentLocation"),
                            position: LatLng(currentLocation!.latitude!,
                                currentLocation!.longitude!))
                      },
                    ),
                    Visibility(
                      visible: alert,
                      child: AlertDialog(
                        title: Text(
                          "Alert !!!",
                          style: TextStyle(color: Colors.white),
                        ),
                        content: Container(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              child: Text(
                                "SOS has been sent to \n$destination",
                                maxLines: 3,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.battery_0_bar,
                              color: Colors.white,
                            )
                          ],
                        )),
                        backgroundColor: Colors.redAccent,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 0, 0),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.15,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                child: ScrollablePositionedList.builder(
                              itemCount:
                                  locations.isNotEmpty ? locations.length : 0,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return StationBox(
                                    setRoute: getPolyPoints,
                                    lat: locations[index].lat,
                                    setDestination: setDestination,
                                    currentIndex: index,
                                    lng: locations[index].lng,
                                    id: locations[index].id,
                                    name: locations[index].name,
                                    vicinity: locations[index].vicinity,
                                    open: locations[index].open,
                                    activeId: activeId);
                              },
                              itemScrollController: itemController,
                              scrollDirection: Axis.horizontal,
                            ))
                          ],
                        ),
                      ),
                    )
                  ],
                )));
    }
  }
}

class StationBox extends StatefulWidget {
  String name;
  final setRoute;
  String vicinity;
  int currentIndex;
  String id;
  bool open;
  double lat;
  double lng;
  String activeId;
  final setDestination;
  StationBox(
      {Key? key,
      // required this.setScroll,
      required this.currentIndex,
      required this.setRoute,
      required this.lat,
      required this.lng,
      required this.id,
      required this.activeId,
      required this.setDestination,
      required this.name,
      required this.vicinity,
      required this.open})
      : super(key: key);

  @override
  State<StationBox> createState() => _StationBoxState();
}

class _StationBoxState extends State<StationBox> {
  late bool inUse;
  @override
  Widget build(BuildContext context) {
    if (widget.activeId == widget.id) {
      inUse = true;
      // widget.setScroll(widget.currentIndex);
    } else {
      inUse = false;
    }
    return InkWell(
      onTap: () {
        if (!inUse) {
          inUse = true;

          setState(() {
            widget.setRoute(widget.lat, widget.lng, widget.id);
            widget.setDestination(widget.name);
          });
        } else {
          inUse = false;
          setState(() {});
        }
      },
      child: Container(
        margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
        height: 200,
        width: 300,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                // ignore: prefer_const_literals_to_create_immutables
                colors: inUse
                    ? [Colors.white, Colors.white]
                    : [
                        Color.fromARGB(255, 5, 42, 72),
                        Color.fromARGB(255, 8, 38, 89)
                      ]),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 180,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      "${widget.name}",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: inUse ? Colors.blue : Colors.white),
                      overflow: TextOverflow.fade,
                      softWrap: false,
                      maxLines: 1,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "${widget.vicinity}",
                      style: TextStyle(
                          fontSize: 12,
                          color: inUse ? Colors.blue : Colors.white),
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: 8,
              ),
              Image.asset('assets/images/charging-station.png')
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Boxes(String name, String vicinity, bool open) => Container(
//       margin: EdgeInsets.fromLTRB(0, 0, 8.0, 0),
//       height: 100,
//       width: 300,
//       decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               // ignore: prefer_const_literals_to_create_immutables
//               colors: [
//                 Color.fromARGB(255, 5, 42, 72),
//                 Color.fromARGB(255, 8, 38, 89)
//               ]),
//           borderRadius: BorderRadius.circular(10)),
//       child: Padding(
//         padding: EdgeInsets.all(20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Container(
//               width: 180,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: [
//                   Text(
//                     "$name",
//                     style: TextStyle(
//                         fontSize: 17,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white),
//                     overflow: TextOverflow.fade,
//                     softWrap: false,
//                     maxLines: 1,
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     "$vicinity",
//                     style: TextStyle(
//                         fontSize: 14,
//                         color: Color.fromARGB(255, 214, 214, 214)),
//                     maxLines: 2,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(
//               width: 10,
//             ),
//             Image.asset('assets/charging-station.png')
//           ],
//         ),
//       ),
//     );
