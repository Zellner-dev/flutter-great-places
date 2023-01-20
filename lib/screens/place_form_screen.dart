import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/widgets/image_input.dart';
import 'package:great_places/widgets/location_input.dart';
import 'package:provider/provider.dart';

class PlaceFormScreen extends StatefulWidget {
  const PlaceFormScreen({super.key});

  @override
  State<PlaceFormScreen> createState() => _PlaceFormScreenState();
}

class _PlaceFormScreenState extends State<PlaceFormScreen> {

  final _titleController = TextEditingController();
  File? _pickedImage;
  LatLng? _pickedPosition;

  void _onSelectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _onSelectPosition(LatLng position) {
    _pickedPosition = position;
  }

  bool _isValidForm() {
    return _titleController.text != "" &&
        _pickedImage != null &&
        _pickedPosition != null;
  }

  void _submitForm() {
    if(!_isValidForm()) return;
    
    Provider.of<GratePlaces>(context, listen: false).addPlace(_titleController.text, _pickedImage!, _pickedPosition!);

    Navigator.of(context).pop();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Novo Lugar"),
      ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        controller: _titleController,
                        decoration: const InputDecoration(
                          labelText: "Título"
                        ),
                        onChanged: (_) {
                          setState(() {});
                        },
                      ),
                      const SizedBox(height: 10),
                      ImageInput(onSelectImage: _onSelectImage),
                      const SizedBox(height: 10),
                      LocationInput(onSelectPosition: _onSelectPosition)
                    ],
                  ),
                ),
              ),
            ),
            Container(
              width: 10,
              height: 50,
              color: Theme.of(context).colorScheme.primary,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  disabledBackgroundColor: Colors.grey,
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text("Adicionar"),
                onPressed: _isValidForm() ? _submitForm : null, 
              ),
            ),
          ],
        )
    );
  }
}
