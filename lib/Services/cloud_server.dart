import 'dart:convert';

import 'package:waddler/Model/near_by_location.dart';
import 'package:http/http.dart' as http;

class CloudServer{



  Future<List<NearByLocationModel>> fetchFromMapByNear({double lan,double lat})async{
    var url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=day+care+center&location=$lan,$lat&fields=photos,formatted_address,name,opening_hours,icon,rating&radius=5000&key=AIzaSyB3PH6hatKMI2ANb09-g1IWSO2UTTZPAN4";

    var finalUrl = Uri.parse(url);

    var response =await http.get(finalUrl);
     var values = jsonDecode(response.body);


    final List result = values['results'];
    print(result.length);
    print(result);

    return result.map((e) => NearByLocationModel.fromJson(e)).toList();
  }



}