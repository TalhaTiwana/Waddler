import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:google_maps_webservice/geocoding.dart';
import 'package:google_place/google_place.dart';
import 'package:waddler/Common/common_functions.dart';
import 'package:waddler/Services/cloud_server.dart';
import 'package:waddler/Style/colors.dart';
import 'Pages/ResultSheet.dart';
import 'Pages/near_by_location.dart';
import 'Pages/search_by_rating.dart';

class FDC extends StatefulWidget {
  const FDC({Key key}) : super(key: key);

  @override
  _FDCState createState() => _FDCState();
}

class _FDCState extends State<FDC> {
  String cloudKey = "AIzaSyAiYXBLE3LuMDpBqsr0staw-qhAxSfuMUY";
  Position position;
  LatLng _latLng;
  var image;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/bgDCS.png"), fit: BoxFit.fill),
            gradient: LinearGradient(
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(2.0, 2.0),
                colors: [
                  primaryClr.withOpacity(0.8),
                  primaryClr.withOpacity(0.5)
                ])),
        child: Container(
          color: Colors.black.withOpacity(0.3),
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(
                    top: size.height * 0.06, bottom: size.height * 0.05),
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                width: size.width,
                child: Text(
                  "Are you looking for \nDaycare Center?",
                  style: GoogleFonts.cabin(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: size.width * 0.09,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        hintText: "Search DayCare center here..",
                        apiKey:
                            "AIzaSyAiYXBLE3LuMDpBqsr0staw-qhAxSfuMUY", // Put YOUR OWN KEY here.
                        onPlacePicked: (result) {
                          Navigator.of(context).pop();
                          print("\n\n");
                          image = result.photos[0];
                          print(
                              "Adress ${result.formattedAddress} \n Phone number:${result.internationalPhoneNumber} ${result.formattedPhoneNumber}\n"
                              "Place name: ${result.name} ${result.rating}\n"
                              "URL: ${result.url}\n"
                              "Reviews: ${result.reviews[0].text}\n"
                              "official website: ${result.website}\n"
                              "Scope: ${result.scope}\n");
                          settingModalBottomSheetAddress(
                            name: result.name,
                            size: size,
                            context: context,
                            address: result.formattedAddress,
                            phoneNumber: result.internationalPhoneNumber ??
                                result.formattedPhoneNumber,
                            reviews: result.reviews,
                            rating: result.rating,
                            url: result.url,
                            website: result.website,
                          );
                        },
                        useCurrentLocation: true,
                      ),
                    ),
                  );
                },
                splashColor: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(
                      bottom: size.height * 0.01, top: size.height * 0.07),
                  alignment: Alignment.center,
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(-2, 2)),
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(2, -2))
                      ]),
                  child: Text(
                    "Search by Location",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
              InkWell(
                onTap: ()async {

                  Geolocator.getCurrentPosition(
                          desiredAccuracy: LocationAccuracy.high)
                      .then((value) {
                    position = value;
                  }).whenComplete(() async{
                    screenPush(context, NearByLocation(lat: position.latitude,lon:position.longitude));
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  alignment: Alignment.center,
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(-2, 2)),
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(2, -2))
                      ]),
                  child: Text(
                    "Search near your location",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),

              InkWell(
                onTap: ()async {

                  Geolocator.getCurrentPosition(
                      desiredAccuracy: LocationAccuracy.high)
                      .then((value) {
                    position = value;
                  }).whenComplete(() async{
                    CloudServer().fetchFromMapByNear(lat: position.latitude,lan: position.longitude).then((value){
                      value.sort((a, b) => b.rating.compareTo(a.rating));
                      screenPush(context, SearchByRating(data: value,));

                    });
                  });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                  alignment: Alignment.center,
                  width: size.width * 0.8,
                  height: size.height * 0.1,
                  decoration: BoxDecoration(
                      color: Colors.blue[800],
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(-2, 2)),
                        BoxShadow(
                            color: Colors.grey[400],
                            blurRadius: 2,
                            spreadRadius: 2,
                            offset: Offset(2, -2))
                      ]),
                  child: Text(
                    "Sort By Rating",
                    style: GoogleFonts.zillaSlab(
                        color: Colors.white,
                        fontSize: size.width * 0.06,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }

  settingModalBottomSheetAddress(
      {BuildContext context,
      String website,
      Size size,
      var reviews,
      var rating,
      var name,
      var address,
      var phoneNumber,
      var url}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext buildContext) {
          return CustomBottomSheet(
            address: address,
            name: name,
            phoneNumber: phoneNumber,
            reviews: reviews,
            rating: rating,
            urlAddress: url,
            website: website,
          );
        });
  }


}
