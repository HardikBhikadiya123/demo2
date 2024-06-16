import 'package:flutter/material.dart';

class CommanWidget{
  
  Widget divided({required Color color,required double thikmess}){
    return Divider(
      height: 0,
      thickness: thikmess,
      color: color,
    );
  }
}