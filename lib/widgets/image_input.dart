import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.onSelectImage});

  final Function(File) onSelectImage; 
  
  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {

  File? _storedImage;

  void _takePicture() async {
    final ImagePicker picker = ImagePicker();
    XFile? imageFile = await picker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if(imageFile == null) return;

    setState(() {
      _storedImage = File(imageFile.path);
    });


    final appDir = await syspaths.getApplicationDocumentsDirectory();
    String fileName = path.basename(_storedImage!.path);
    final savedImage = await _storedImage?.copy("${appDir.path}/$fileName");
    widget.onSelectImage(savedImage!);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 180,
          height: 100,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey)
          ),
          child: _storedImage != null 
          ? Image.file(
              _storedImage!,
              fit: BoxFit.cover,
            )
          : const Text("Nenhuma imagem!"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextButton.icon(
            icon: const Icon(Icons.camera_rounded),
            label: const Text(
              "Tirar foto",
              textScaleFactor: 0.85,
            ),
            onPressed: _takePicture, 
          ),
        )
      ],
    );
  }
}