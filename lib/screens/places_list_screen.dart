import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Meus Lugares"),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed(AppRoutes.PLACE_FORM), 
            icon: const Icon(Icons.add_rounded)
          )
        ],
      ),
      body: Center(
        child: FutureBuilder(
          future: Provider.of<GratePlaces>(context, listen: false).loadPlaces(),
          builder: (context, snapshot) {
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<GratePlaces>(
              child: const Text("Nenhum local registrado."),
              builder: (context, gratePlaces, child) {
                return gratePlaces.itemsCount == 0 
                  ? child! 
                  : ListView.builder(
                    itemCount: gratePlaces.itemsCount,
                    itemBuilder: ((context, index) {
                      final item = gratePlaces.getItem(index);
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            item.image
                          ),
                        ),
                        title: Text(item.title),
                        onTap: () {
                          
                        },
                      );
                    }),
                  );
              });
          }
        ),
      ),
    );
  }
}