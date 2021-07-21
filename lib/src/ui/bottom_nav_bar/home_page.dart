import 'dart:async';

import 'package:abdelhomi/src/widgets/google_map_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Position position;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey(); // Create a key

  Future<Position> getLocation() async {
     position = await
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    if(position.latitude!=null&& position.altitude!=null){
      return position;
    }
    else{
      return null;
    }

  }
  final GlobalKey scaffoldKey = GlobalKey();

  List<Marker> markers = [];

  List listMarkerIds=[];
  Completer<GoogleMapController> _controller = Completer();

  Widget getBottomSheet(String s)
  {
    return Stack(
      children: [
        Container(

          margin: EdgeInsets.only(top: 32),
          color: Colors.white,
          child: Column(
            children: [
              Container(
                color: Colors.blueAccent,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Make a call for fast access: ",style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),),
                      SizedBox(height: 5,),
                      Row(children: [

                        Text("Latitude: ${s.split(" ")[0]}",style: TextStyle(
                            color: Colors.white,
                            fontSize: 12
                        )),
                        SizedBox(width: 20,),
                        Text("Latitude: ${s.split(" ")[1]}",style: TextStyle(
                            color: Colors.white,
                            fontSize: 14
                        ))
                      ],),
                      SizedBox(height: 5,),
                      Text("Memorial Park",style: TextStyle(
                          color: Colors.white,
                          fontSize: 14
                      )),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [SizedBox(width: 20,),
                  Icon(Icons.message,color: Colors.orange,),
                  SizedBox(width: 20,),Text("Text Message")],
              ),
              SizedBox(height: 20,),
              Row(
                children: [SizedBox(width: 20,),
                  Icon(Icons.call_outlined,color: Colors.green,),
                  SizedBox(width: 20,),
                  Text("Call Direct WhatsApp")],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topRight,

            child: FloatingActionButton(
                backgroundColor: Colors.red,
                child: Icon(Icons.call),
                onPressed: (){
                  launch(('tel://+12345678920d'));

                }),
          ),
        )
      ],

    );
  }

  fetchMarkers(){
    FirebaseFirestore.instance.collection('allLocations')
        .get().then((docs) {
      if(docs.docs.isNotEmpty){
        for(int i= 0; i < docs.docs.length; i++) {
          initMarker(docs.docs[i].data(), docs.docs[i].id);
        }
      }
    });
  }
  void initMarker( data, markId) {
    var markerIdVal = markId;
    final MarkerId markerId = MarkerId(markerIdVal);

    // creating a new MARKER
    final Marker marker = Marker(
      markerId: markerId,
      position: LatLng(double.parse(data['lat']), double.parse(data['lot'])),
      infoWindow: InfoWindow(title: "location", snippet: "${data['lat']}\n ${data['lot']}",
        anchor: Offset(0,1),
        onTap: (){
          _scaffoldKey.currentState.
          showBottomSheet((context) => Container(
            child:
            getBottomSheet("17.4435, 78.3772"),
            height: 220,
            color: Colors.transparent,
          ));

        },

      ),
    );

    setState(() {
      // adding a new marker to map
      markers.add(marker);
    });
  }
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 11,
  // );
  _handleTap(LatLng point) {
    print("points:  ${point.longitude}");
    print("points:  ${point.latitude}");
    showDialog(context: context, builder: (cont){
      return  AlertDialog(
        title: Text("Add Emergency Location"),
        content: TextField(
          decoration: InputDecoration(
            labelText: "what happened...",
          ),
        ),
        actions: [
          MaterialButton(onPressed: (){
            setState(() {
              FirebaseFirestore.instance.collection("allLocations").doc().set({
                "markerId":"${point.toString()}",
                "lat":"${point.latitude}",
                "lot":"${point.longitude}",
                "emergency":true,

              }).whenComplete(() {
                Scaffold.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(content: Text("Emergency location has set")));
                print("asasasasasasasasass");

              });
              Navigator.pop(cont);
              markers.add(Marker(
                  markerId: MarkerId(point.toString()),
                  position: point,
                  // infoWindow: InfoWindow(
                  //   title: 'I am a marker',
                  // ),
                  onTap: (){
                    showDialog(context: context, builder: (cont){
                      return AlertDialog(
                        title: Text("Name of Emergency"),
                        content: Text("Here fire happend in 3 start Hotel at circle road chigago"),
                        actions: [
                          OutlineButton(onPressed: (){},
                            child: Text("Send Alarm"),
                          )
                        ],
                      );
                    });
                  },
                  icon:
                  BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
                  draggable: true,
                  onDragEnd: (newPosition){
                    print(newPosition);
                  }
              ));
            });
          },
            color: Colors.blue,
            child: Text("Add Location",
              style: TextStyle(
                  color: Colors.white
              ),
            ),
          )
        ],
      );
    });

  }
  List<Marker> myMarker=[];

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: AppDrawer(),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45),
          child: AppBar(
            title: Text("Abdel"),
            centerTitle: true,
            leading: Container(
              margin: EdgeInsets.all(6),
              child: CircleAvatar(
                  radius: 12,
                  child: Icon(Icons.person)),),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right:8.0),
                child: GestureDetector(
                    onTap: (){
                      print("ddd");
                      _scaffoldKey.currentState.openEndDrawer();
                    },
                    child: Icon(Icons.menu)),
              ),
            ],
          )),
      body: Container(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
            Container(
              width: size.width,
              height: size.height*0.6,
              child: GoogleMap(
              onTap: _handleTap,
              initialCameraPosition:CameraPosition(
                target: LatLng(37.427, -122.08),
                zoom: 15,
              ),
              mapType: MapType.hybrid,
              markers: Set.from(markers),
              onMapCreated: (GoogleMapController controller){
                _controller.complete(controller);
                // fetchMarkers();
                FirebaseFirestore.instance.collection('allLocations')
                    .get().then((docs) {
                  if(docs.docs.isNotEmpty){
                    for(int i= 0; i < docs.docs.length; i++) {
                      initMarker(docs.docs[i].data(), docs.docs[i].id);
                    }
                  }
                });
                //    MarkerId markerId1 = MarkerId("1");
                //    MarkerId markerId2 = MarkerId("2");
                //    MarkerId markerId3 = MarkerId("3");
                //
                //    listMarkerIds.add(markerId1);
                //    listMarkerIds.add(markerId2);
                //    listMarkerIds.add(markerId3);
                //
                //
                //    Marker marker1=Marker(markerId: markerId1,
                //        position: LatLng(17.4435, 78.3772),
                //
                //        icon: BitmapDescriptor.defaultMarkerWithHue(
                //            BitmapDescriptor.hueCyan,),
                //        infoWindow: InfoWindow(
                //            title: "Hytech City",onTap: (){
                //
                // Scaffold.of(scaffoldKey.currentContext).
                //          showBottomSheet((context) => Container(
                //            child:
                //            getBottomSheet("17.4435, 78.3772"),
                //            height: 250,
                //            color: Colors.transparent,
                //          ));
                //
                //        },snippet: "Snipet Hitech City"
                //        ));
                //
                //    Marker marker2=Marker(markerId: markerId2,
                //      position: LatLng(17.4837, 78.3158),
                //      icon:
                //      BitmapDescriptor.defaultMarkerWithHue
                //        (BitmapDescriptor.hueGreen),);
                //    Marker marker3=
                //    Marker(markerId:
                //    markerId3,position:
                //    LatLng(17.5169, 78.3428),
                //        infoWindow: InfoWindow(
                //            title: "Miyapur",onTap: (){},
                //            snippet: "Miyapur"
                //        ));
                //
                //    setState(() {
                //      markers[markerId1]=marker1;
                //      markers[markerId2]=marker2;
                //      markers[markerId3]=marker3;
                //    });
              },
          ),
            ),
              SizedBox(height: size.height*0.02,),
              Container(
                width: size.width*0.9,
                height: size.height*0.05,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,spreadRadius: 5,offset: Offset(0, 0.1))],
                gradient: LinearGradient(colors: [
                  Colors.lightBlueAccent,
                  Colors.lightBlueAccent,
                  Colors.lightBlue,
                  Colors.blue,
                ])
              ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(width: size.width*0.1,),
                    Icon(Icons.notifications,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),

                    Text("Send Emergency Notification",
                    style: TextStyle(
                      color: Colors.white,fontWeight: FontWeight.bold,
                      fontSize: 14
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height*0.02,),
              GestureDetector(
                onTap: (){
                  getLocation().then((value) {
                    if(value==null){
                      Fluttertoast.showToast(msg: "turn on you location, try again",
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.red,
                          textColor: Colors.white);
                    }
                    else{
                      FirebaseFirestore.instance.collection("allLocations").doc().set({
                        "markerId":"${value.altitude}${value.longitude}",
                        "lat":"${value.latitude}",
                        "lot":"${value.longitude}",

                      }).whenComplete(() {
                        Scaffold.of(_scaffoldKey.currentContext).showSnackBar(SnackBar(content: Text("your location has been successfully sent")));
                        print("asasasasasasasasass");

                      });
                    }
                  });
                },
                child: Container(
                  width: size.width*0.9,
                  height: size.height*0.05,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,spreadRadius: 5,offset: Offset(0, 0.1))],
                      gradient: LinearGradient(colors: [
                        Colors.lightBlueAccent,
                        Colors.lightBlueAccent,
                        Colors.lightBlue,
                        Colors.blue,
                      ])
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      SizedBox(width: size.width*0.1,),
                      Icon(Icons.location_on,color: Colors.white,),
                      SizedBox(width: size.width*0.05,),

                      Text("Send Your Location",
                        style: TextStyle(
                            color: Colors.white,fontWeight: FontWeight.bold,
                            fontSize: 16
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: size.height*0.02,),
              Container(
                width: size.width*0.9,
                height: size.height*0.05,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    // boxShadow: [BoxShadow(color: Colors.grey,blurRadius: 5,spreadRadius: 5,offset: Offset(0, 0.1))],
                    gradient: LinearGradient(colors: [
                      Colors.lightBlueAccent,
                      Colors.lightBlueAccent,
                      Colors.lightBlue,
                      Colors.blue,
                    ])
                ),
                alignment: Alignment.center,
                child: Row(
                  children: [
                    SizedBox(width: size.width*0.1,),
                    Icon(Icons.location_on_outlined,color: Colors.white,),
                    SizedBox(width: size.width*0.05,),

                    Text("Send Marker Locator",
                      style: TextStyle(
                          color: Colors.white,fontWeight: FontWeight.bold,
                          fontSize: 16
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class AppDrawer extends StatelessWidget {

  Widget _createDrawerItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
  Widget _createHeader() {
    return DrawerHeader(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,

        child:CircleAvatar(
          radius: 30,
          child: Icon(Icons.person),
        ));
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Icon(Icons.person),
                ),
                Row(
                  children: [Icon(Icons.add_to_queue),
                    SizedBox(width: 5,),
                    Icon(Icons.language)],
                )
              ],
            ),
          ),
          _createDrawerItem(icon: Icons.message,text: 'Messages',),
          _createDrawerItem(icon: Icons.location_city, text: 'stats',),
          _createDrawerItem(icon: Icons.contact_mail, text: 'Your Contents',),
          _createDrawerItem(icon: Icons.bookmarks_outlined, text: 'BookMarks',),

        ],
      ),
    );
  }

}