import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:great_places/model/place.dart';
import 'package:great_places/utils/db_util.dart';
import 'package:image_picker/image_picker.dart';

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
        location: null
      )
    ).toList();
    notifyListeners();
  }

  void addPlace(String title, File image) async {
    final newPlace = Place(
      id: Random().nextDouble().toString(),
      title: title, 
      image: image,
      location: null
    );
    _items.add(newPlace);
    final db = await DbUtil.database();
    db.insert(
      "places", 
      {      
        "id" : newPlace.id,
        "title" : newPlace.title,
        "image" : newPlace.image.path
      }
    );
    notifyListeners();
  }
}