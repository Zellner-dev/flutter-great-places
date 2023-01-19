import 'package:flutter/material.dart';
import 'package:great_places/providers/grate_places.dart';
import 'package:great_places/screens/place_form_screen.dart';
import 'package:great_places/screens/places_list_screen.dart';
import 'package:great_places/utils/app_routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    int color = int.parse("0XFFFF0000");
    return ChangeNotifierProvider(
      create: ((context) => GratePlaces()),
      child: MaterialApp(
        title: 'Great Places',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          // primarySwatch: Colors.indigo,
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Color(color),
            secondary: Colors.amber
          )
        ),
        home: const PlacesListScreen(),
        routes: {
          AppRoutes.PLACE_FORM: (context) => const PlaceFormScreen()
        },
      ),
    );
  }
}
