import 'package:flutter/material.dart';
import 'package:tatsamtest/models/country.dart';
import 'package:tatsamtest/utils/countryUtils.dart';

class CountryTile extends StatefulWidget {
  final Country country;
  final bool showIcon;
  final ValueNotifier<List<Country>>? favList;
  const CountryTile({ Key? key, required this.country, required this.showIcon, this.favList }) : super(key: key);

  @override
  _CountryTileState createState() => _CountryTileState();
}

class _CountryTileState extends State<CountryTile> {
   bool checkfav(var favs,Country country){
    bool favoured=false;
    for(int j=0;j<favs.length;j++){
      
      if(country.code==favs?[j].code){
        favoured=true;
        break;
    }
    }
    return favoured;
  }
  void removefav(Country country,ValueNotifier<List<Country>> ?favs){
    for(int i=0;i<favs!.value.length;i++){
      if(country.code==favs.value[i].code){
        favs.value.removeAt(i);
        break;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Card(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.country.code),
                Padding(
                  padding: const EdgeInsets.only(top:8.0,bottom: 8),
                  child: Text(widget.country.country),
                ),
                Text(widget.country.region)
              ],
            ),
          ),
         widget.showIcon? 
         IconButton(
            icon: Icon(checkfav(widget.favList?.value, widget.country)?Icons.star:Icons.star_border_outlined),
            color: Colors.yellow,
            onPressed: (){
              if(checkfav(widget.favList?.value, widget.country)){
                removefav(widget.country, widget.favList);
              }else{
                widget.favList?.value.add(widget.country);
              }
              setState(() {
                
              });
            },
          ):Container()
        ],
      ),
    );
  }
}