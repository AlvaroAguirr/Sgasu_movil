import 'package:flutter/material.dart';

class Hours extends StatelessWidget {
  int horas = 0;

   Hours({super.key,
  required this.horas
  });

  @override
  Widget build(BuildContext context) {
    horas <7 ? horas+7: horas;
    return 
       Container(
          decoration: BoxDecoration(
    border: Border.all(color: const Color.fromARGB(255, 188, 200, 220))
  ),
      child: Center(
      child: Text(
         "${horas+7}",
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold),),
      ),
      
    );
  }
}