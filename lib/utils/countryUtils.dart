import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tatsamtest/models/country.dart';

class CountryUtils{
  static String url='https://api.first.org/data/v1/countries';
  
  static Future<List<Country>> getcountries(ValueNotifier<List<Country>> countriesList)async{
    var response=await http.get(Uri.parse(url));
    Map data=await json.decode(response.body);
    List<Country> countires=[];
    //print('this is data:${data['data']}');
    data['data'].forEach((key, value) { 
      data['data'][key]['code']=key;
      countires.add(Country.fromJson(data['data'][key]));
    });
  countriesList.value=countires;
    return countires;
  }
  
}