import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:great_places/screens/map_screen.dart';
import 'package:great_places/utils/location_util.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key, required this.onSelectPosition});

  final Function(LatLng pickedPosition) onSelectPosition;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String? _previewImageUrl;

  void _showPreview(double lat, double long) {

    final staticMapImageUrl = LocationUtil.generateLocationPreviewImage(
      latitude: lat, 
      longitude: long
    );

    setState(() {
      _previewImageUrl = staticMapImageUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try{
      final locData = await Location().getLocation();

      widget.onSelectPosition(LatLng(
        locData.latitude!,
        locData.longitude!
      ));
      _showPreview(locData.latitude!, locData.longitude!);
    } catch (_) {
      return;
    }

  }

  Future<void> _selectOnMap() async {
    final selectedPosition = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen()
      )
    );

    if(selectedPosition == null) return;

    widget.onSelectPosition(selectedPosition);
    _showPreview(selectedPosition.latitude, selectedPosition.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 170,
          width: double.infinity,
          alignment: AlignmentDirectional.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Colors.grey
            )
          ),
          child: _previewImageUrl == null
          ? const Text("Nenhuma localização informada.")
          : Image.network(
            _previewImageUrl!,
            fit: BoxFit.cover,
            width: double.infinity,
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              icon: const Icon(Icons.location_on_rounded),
              label: const Text(
                "Localização Atual",
                textScaleFactor: 0.85,
              ),
              onPressed: _getCurrentUserLocation 
            ),
            TextButton.icon(
              icon: const Icon(Icons.map_rounded),
              label: const Text(
                "Selecione no Mapa",
                textScaleFactor: 0.85,
              ),
              onPressed: _selectOnMap, 
            )
          ],
        )
      ],
    );
  }
}