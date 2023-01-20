import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/model/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:great_places/utils/location_util.dart';

class GratePlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  } 

  int get itemsCount {
    return _items.length;
  }
  
  Place getItem(int index) {
    return _items[index];
  }

  Future<void> loadPlaces() async {
    final dataList = await DbUtil.getData("places");
      print(dataList);
    _items = dataList.map(
      (place) => Place(
        id: place["id"],
        title: place["title"],
        image: File(place["image"]),
        location: PlaceLocation(
          latitude: double.parse(place["lat"]),
          longitude: double.parse(place["long"]),
          adress: place["adress"]
        )
      )
    ).toList();
    notifyListeners();
  }

  void addPlace(String title, File image, LatLng position) async {
    final adress = await LocationUtil.getAdressFrom(position);
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title, 
      image: image,
      location: PlaceLocation(
        latitude: position.latitude,
        longitude: position.longitude,
        adress: adress,
      )
    );
    _items.add(newPlace);
    final db = await DbUtil.database();
    db.insert(
      "places", 
      {      
        "id" : newPlace.id,
        "title" : newPlace.title,
        "image" : newPlace.image.path,
        "lat" : newPlace.location!.latitude,
        "long" : newPlace.location!.longitude,
        "adress" : newPlace.location!.adress
      }
    );
    notifyListeners();
  }
}