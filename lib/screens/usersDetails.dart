import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget userDetails(
    String base, String date, int time, String tearm, String provider) {
  return Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(

          children: [
            Text(
              "Base :",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Text("${base}")
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Date :",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Text("${date}"),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Time :",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Text("${time}"),
          ],
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Tearms :",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Text("${tearm}"),
          ],
        ),
      ),Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Text(
              "Provider :",
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple),
            ),
            Text("${provider}"),
          ],
        ),
      ),




    ],
  );
}
