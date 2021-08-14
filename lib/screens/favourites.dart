import 'package:flutter/material.dart';
import 'package:tatsamtest/models/country.dart';
import 'package:tatsamtest/widgets/coutryWidgets.dart';

class Favourites extends StatefulWidget {
final ValueNotifier<List<Country>> favouritesList;
 Favourites({ Key? key, required this.favouritesList}) : super(key: key);

  @override
  _FavouritesState createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  ValueListenableBuilder(
        valueListenable: widget.favouritesList,
        builder: (context,_,__){
          return widget.favouritesList.value.isNotEmpty? ListView.builder(
                  itemCount: widget.favouritesList.value.length,
                  itemBuilder: (context,index){
                    Country country =widget.favouritesList.value[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryTile(country: country, showIcon: false,),
                    );
                  },
                ):Center(
                  child: Text('No favourites'),
                );
        },
      )
    );
  }
}