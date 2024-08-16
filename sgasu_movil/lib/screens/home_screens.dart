import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:sgasu_movil/models/gif.dart';
import 'package:sgasu_movil/screens/rooms.dart';

import 'package:http/http.dart' as http;
import 'package:sgasu_movil/theme/app_theme.dart';

class Expandir{
  Expandir({
    required this.headerText,
    required this.expandenText,
    this.isExpanded = false,
  });
  String headerText;
  String expandenText;
  bool isExpanded;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


late Future<List<Gif>> _listadoGifs;

Future<List<Gif>> _getGif() async{


  /*

       para leer datos del sistema web
  final response =await http.get(Uri.parse("http://10.0.2.2:8000/API/edificios"));

   */
  
  final response =await http.get(Uri.parse("https://mock_403afb3074cf402eac0c6cb611071e51.mock.insomnia.rest/"));

  List<Gif> gifs=[];


if(response.statusCode ==200){
  String body= utf8.decode(response.bodyBytes);

  final jsonData= jsonDecode(body);
//print(jsonData[1]);
  for (var item in jsonData["edificios"]) {
    gifs.add(
      Gif(item["nombre"],item["description"])
    ) ;
  }

// para leer datos del sistema web
  // for (var item in jsonData) {
  //   gifs.add(
  //     Gif(item["bg_name"],item["bg_description"])
  //   ) ;
  // }
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
        child: Column(
          children: [
            Text("Lista de din"),
            Expanded(
              child: FutureBuilder(
                future: _listadoGifs,
                builder: (context, snapshot) {
                  if(snapshot.hasData){
                  return ListView(
                    children:
                     _listGifs(snapshot.data!),
                  );
                  } else if (snapshot.hasError){
                    print(snapshot.error);
                  return const Text('Ocurrio error al mostrar tarjetas ');
                  }
                  return const Center(child: CircularProgressIndicator(),);
                },
              ),
            ),
            ElevatedButton(
      
        child: Text("hola que hace"),
        onPressed: (){
          showModalBottomSheet(
            context: context,
             builder: (BuildContext Context){
              return  SizedBox(
                height: 600,
                child: Center(
                  child: Column(children: [
                    SizedBox(height: 20,),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buscar reservaciones"),
                        
                        SizedBox(width: 30,),
                        SizedBox(width: 150,
                          child: TextField(
                            decoration:InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: "Matrícula"),
                              ),
                        ),
                      ],
                    ),  

                    SizedBox(height: 20,),

                        Expanded(
                          child: ListView(
                            children: [

                              Container(
                                  margin: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(12)),
                                child: Column(children: [
                                  Text("Titulo: nombre  de quien pidio"),
                                  Text("hora"),
                                  Text("cosas aprobadas"),
                                  Row(
                                    children: [ 
                                    ElevatedButton(onPressed: (){}, child: Text("editar")),
                                    ElevatedButton(onPressed: (){}, child: Text("eliminar")),


                                    ],)
                                ],)
                                
                                )

                            ],
                          ),
                        ),
                        ElevatedButton(onPressed: (){}, child: Text("Buscar")),
                     

                  ],)
                  ),
              );

             }
             );
        },
        ),



          ],
        ),
      ),
    );
  } 

//index de rutas no hecho
int? a=0;

List<int> numerolista =[];







// funcion que crea botones para ir al salon  
  List<Widget> _listGifs(List<Gif> data){


    List<Widget> gifs =[];
     List<int> indices = [];
    for (int i=0;i< data.length;i++){

Gif gif =data[i];

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
                  int currentindex =indices[i];
                  final ruta=MaterialPageRoute(
                    builder:(context){
                      return Rooms(numeroURl: currentindex,);
                    }
                  
                         
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
    indices.add(i);
        }
  return gifs;
}

}

