import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tatsamtest/models/country.dart';
import 'package:tatsamtest/utils/countryUtils.dart';
import 'package:tatsamtest/widgets/coutryWidgets.dart';
import 'package:fluttertoast/fluttertoast.dart';


class CountriesList extends StatefulWidget {
  final ValueNotifier<List<Country>> favouritesList;
  const CountriesList({ Key? key, required this.favouritesList }) : super(key: key);

  @override
  _CountriesListState createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList>with AutomaticKeepAliveClientMixin  {
  final listkey=GlobalKey<AnimatedListState>();
  ValueNotifier<List<Country>> countriesList=ValueNotifier([]);
  ScrollController controller=ScrollController();
  ValueNotifier<int> currentItemsToShow=ValueNotifier(10);
  void _scrollListener() async {
    if (controller.position.extentAfter <= 0) {
      if(countriesList.value.isNotEmpty){
        if(currentItemsToShow.value+10<= countriesList.value.length){
          for(int i=currentItemsToShow.value;i<currentItemsToShow.value+10;i++){
            listkey.currentState?.insertItem(i);
          }
          if(currentItemsToShow.value<countriesList.value.length){
            Fluttertoast.showToast(
        msg: "New countries loaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
          }
          currentItemsToShow.value=currentItemsToShow.value+10;
        }else{
            int remainingItemsToAdd=countriesList.value.length-currentItemsToShow.value;
             for(int i=currentItemsToShow.value;i<currentItemsToShow.value+remainingItemsToAdd;i++){
            listkey.currentState?.insertItem(i);
          }
          if(currentItemsToShow.value < countriesList.value.length){
            Fluttertoast.showToast(
        msg: "New countries loaded",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0
    );
          }
          currentItemsToShow.value=currentItemsToShow.value+remainingItemsToAdd;
        }
      }else{
        print('no data in list');
      }
    }
  }
  @override
  void initState() {
    super.initState();
    controller..addListener(_scrollListener);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
      stream: Connectivity().onConnectivityChanged,
      builder: (context,connectState){
        if(connectState.data==ConnectivityResult.none){
          return Center(child:Text('No internet connection'));
        }else {
          return FutureBuilder<List<Country>>(
            future: CountryUtils.getcountries(countriesList),
            builder: (context,countryData){
              if(countryData.hasError){
                return Center(child: Text('No internet connection'),);
              }else if(!countryData.hasData){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }else {
                //var countries=countryData.data;
                return AnimatedList(
                  key: listkey,
                  controller: controller,
                  initialItemCount: currentItemsToShow.value,
                  itemBuilder: (context,index,animation){
                    Country country =countryData.data![index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountryTile(country: country, showIcon: true,favList: widget.favouritesList),
                    );
                  },
                );
              }
            },
          );
        }
      }
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}