import 'dart:convert';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
const GOOGLE_API_KEY = "AIzaSyDU1xLFhkWi7AjZAPGKL3gMVpnB7iy6E-Q";

class LocationUtil {
  static String generateLocationPreviewImage({
    required double latitude,
    required double longitude
  }){
    return "https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:A%$latitude,$longitude&key=$GOOGLE_API_KEY";
  } 

  static Future<String> getAdressFrom(LatLng position) async {
    final url = "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$GOOGLE_API_KEY";
    print(url);
    final response = await http.get(Uri.parse(url));
    return jsonDecode(response.body)["results"][0]["formatted_address"];
  }
}
      // &markers=color:blue%7Clabel:S%7C40.702147,-74.015794&markers=color:green%7Clabel:G%7C40.711614,-74.012318