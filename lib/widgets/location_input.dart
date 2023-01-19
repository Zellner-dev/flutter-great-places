import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {

  String? _previewImageUrl;

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
              onPressed: () {

              }, 
            ),
            TextButton.icon(
              icon: const Icon(Icons.map_rounded),
              label: const Text(
                "Selecione no Mapa",
                textScaleFactor: 0.85,
              ),
              onPressed: () {

              }, 
            )
          ],
        )
      ],
    );
  }
}