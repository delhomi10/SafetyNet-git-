import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
class GoogleMapWidget extends StatefulWidget {

  @override
  _GoogleMapWidgetState createState() => _GoogleMapWidgetState();
}

class _GoogleMapWidgetState extends State<GoogleMapWidget> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height*0.48,
      child: MyMaps(),
    );
  }
}
class MyMaps extends StatefulWidget{
  @override
  State createState() {
    // TODO: implement createState
    return MyMapsState();
  }

}
class MyMapsState extends State{
  final GlobalKey scaffoldKey = GlobalKey();

  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  List listMarkerIds=[];
  Completer<GoogleMapController> _controller = Completer();



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
        Scaffold.of(scaffoldKey.currentContext).
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
      markers[markerId] = marker;
    });
  }
  // static final CameraPosition _kGooglePlex = CameraPosition(
  //   target: LatLng(37.42796133580664, -122.085749655962),
  //   zoom: 11,
  // );
  _handleTap(LatLng point) {
    setState(() {
      Set.of(markers.values).add(Marker(
        markerId: MarkerId(point.toString()),
        position: point,
        infoWindow: InfoWindow(
          title: 'I am a marker',
        ),
        icon:
        BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueMagenta),
      ));
    });
  }
@override
  void initState() {
    super.initState();
    fetchMarkers();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: scaffoldKey,
        body: Container(
          child: GoogleMap(
            onTap: _handleTap,
            initialCameraPosition:CameraPosition(
              target: LatLng(37.427, -122.08),
              zoom: 14,
            ),
            mapType: MapType.normal,
            markers: Set.of(markers.values),
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
        )
    );
  }

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

}