import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:sgasu_movil/models/gif.dart';
import 'package:sgasu_movil/screens/rooms.dart';

import 'package:http/http.dart' as http;
import 'package:sgasu_movil/theme/app_theme.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


late Future<List<Gif>> _listadoGifs;

Future<List<Gif>> _getGif() async{
//aqui es donde se pega el url de insomnia si es que te lo llega a cambiar cuando lo crees
  final response =await http.get(Uri.parse("https://mock_8afac354b19843ceaafbba4ff730e71d.mock.insomnia.rest/"));


  List<Gif> gifs=[];


if(response.statusCode ==200){
  String body= utf8.decode(response.bodyBytes);

  final jsonData= jsonDecode(body);

  for (var item in jsonData["edificios"]) {
    gifs.add(
      Gif(item["nombre"],item["description"])
    ) ;
  }
return gifs;

  }else {
    throw Exception("fallo la conexion");
  }
}

@override
  void initState() {
    super.initState();
    _listadoGifs=_getGif();
  }

  String? nombre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
     child: AppBar(
      title: const Column(
        children: [
          SizedBox(height: 30,),
        Center(child: Text("SGASU",
        style: TextStyle(
          fontSize: 40,
          color: AppTheme.whiteColor),))

        ]
        ),
      ),
      ),

      body:Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color: AppTheme.whiteColor,
         ),
         //Tarjeta Generada por respuesta api 
        child: FutureBuilder(
          future: _listadoGifs,
          builder: (context, snapshot) {
            if(snapshot.hasData){
            return ListView(
              
              children: _listGifs(snapshot.data!),
            );
            } else if (snapshot.hasError){
              print(snapshot.error);
            return const Text('Ocurrio error al mostrar tarjetas ');
            }
            return const Center(child: CircularProgressIndicator(),);
          },
        ),
      ),
    );
  } 

//index de rutas no hecho
int? a=0;


// funcion que crea botones para ir al salon  
  List<Widget> _listGifs(List<Gif> data){
    List<Widget> gifs =[];
  for (var gif in data) {
    gifs.add(
            Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
),
              margin: const EdgeInsets.all(10),
              child: MaterialButton(
              height:100,
              elevation: 8,
              highlightElevation: 25,
              disabledElevation: 10,
              shape:const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
                ),
                highlightColor: const Color.fromARGB(31, 255, 229, 206),
                 color:AppTheme.backcolorGreen ,
                onPressed: (){
                  final ruta=MaterialPageRoute(builder: (context){
                        return  const Rooms(
                        ); }
                      );
                      Navigator.push(context,ruta);
            }
              ,child: Text(gif.name,style: const TextStyle(
                fontSize: 40,
                color: Color.fromARGB(255, 150, 129, 162)
                )
              )
            ),
          )
    );
        }
  return gifs;
}

}

