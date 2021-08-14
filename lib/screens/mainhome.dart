import 'package:flutter/material.dart';
import 'package:tatsamtest/models/country.dart';
import 'package:tatsamtest/screens/countriesList.dart';
import 'package:tatsamtest/screens/favourites.dart';

class MainHome extends StatefulWidget {
  const MainHome({ Key? key }) : super(key: key);

  @override
  _MainHomeState createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> with TickerProviderStateMixin {
  static ValueNotifier<List<Country>> favouritesList=ValueNotifier([]);
  List<Widget> screens=[CountriesList(favouritesList: favouritesList,),Favourites(favouritesList: favouritesList,)];
  List titles=['Countries','Favourites'];
  late TabController controller;
  @override
  void initState() {
    super.initState();
   controller= TabController(length: screens.length, vsync: this);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar:  AppBar(
      bottom: TabBar(
        controller: controller,
        tabs: List<Tab>.generate(titles.length, (index){
          return Tab(text: titles[index],);
        })
      )
    ),        
    body:  TabBarView(
      controller: controller,
      children: screens
    ),
  );
  }
}