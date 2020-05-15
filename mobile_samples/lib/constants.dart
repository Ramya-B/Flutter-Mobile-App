
import 'package:flutter/material.dart';

class Constants{
  // "http://tlrogers.westus2.cloudapp.azure.com:9400"
  static const  envUrl = "http://qc.tradeleaves.internal:9400";  
  static const  mongoImageUrl ="/tl/public/assest/get"; 
  static Color toolbarColor = Colors.green[700];
  static List lobs = [
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0641",
      "lobName": "MarketPlace - Global"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0642",
      "lobName": "BLISS - Domestic"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0643",
      "lobName": "BLISS - Global"
    },
    {
      "lobId": "34343e34-7601-40de-878d-01b3bd1f0644",
      "lobName": "MarketPlace - Domestic"
    }
  ];
}