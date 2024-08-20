import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgasu_movil/global/common/toast.dart';
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


  

      // para leer datos del sistema web
  final response =await http.get(Uri.parse("http://192.168.100.9:8000/API/edificios"));

  // final response =await http.get(Uri.parse("https://mock_403afb3074cf402eac0c6cb611071e51.mock.insomnia.rest/"));

  List<Gif> gifs=[];


if(response.statusCode ==200){
  String body= utf8.decode(response.bodyBytes);

  final jsonData= jsonDecode(body);
//print(jsonData[1]);


// para leer datos del sistema web
  for (var item in jsonData) {
    gifs.add(
      Gif(item["bg_name"],item["bg_description"], id: item['id'] as int?)
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
        child: 
        Column(
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
             builder: (BuildContext context){
              return  StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
              return SizedBox(
                height: 600,
                child: Center(
                  child: Column(children: [
                    SizedBox(height: 20,),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buscar reservaciones"),
                        
                        SizedBox(width: 30,),
                        SizedBox(width: 150,
                          child: TextField(
                            controller: _controller,
                            maxLength: 11,
                                textCapitalization: TextCapitalization.characters,

                            decoration:InputDecoration(
                              counterText: '',
                              border: OutlineInputBorder(),
                              labelText: "Matrícula"),
                              ),
                        ),
                      ],
                    ),  
                    SizedBox(height: 20,),
                        Expanded(
                          child:_dataloaded
                          ?FutureBuilder(
                            future: _listadoEventos,
                             builder: (context, snapshot){
                              if (snapshot.hasData){
                                return ListView(
                                  children: 
                                    _listEventos(snapshot.data!),
                                );
                              } else if (snapshot.hasError){
                                print(snapshot.error);
                                return const Text("Ocurrio un error al consultar ");
                              }
                                return const Center(child: CircularProgressIndicator(),);
                             }
                        )
                        :const Text("Aqui se mostraran las consultas")
                        ),
                        ElevatedButton(
                          onPressed: (){
                            final query = _controller.text.trim();
                            if (query.length==11){
                          setState(() {
                            _dataloaded=true;
                            _listadoEventos=_getevento(query);
                          });
                          } else {
                        
                        Fluttertoast.cancel();
                              showToast(message: "LLenar el campo Matrícula");
                              }
                      }
                          , 
                          child: Text("Buscar ")),
                  ],)
                  ),
              );

             }
             );
                });
        },
        ),
          ],
        ),
      ),
    );
  } 

 Future<List<Gif>>? _listadoEventos;
 bool _dataloaded=false ;
 TextEditingController _controller = TextEditingController();


Future<List<Gif>> _getevento(String query) async{
  print("texto del matricula ${query.length}");
      // para leer datos del sistema web
  final response =await http.get(Uri.parse("http://192.168.100.9:8000/API/solicitud"));
  List<Gif> gifs=[];
if(response.statusCode ==200){
  String body= utf8.decode(response.bodyBytes);
  final jsonData= jsonDecode(body);

  for (var item in jsonData) {
if(item["rt_matricula"]==query){
    gifs.add(
      Gif(item["applicant_name"],item["request_time"],edi: item['rt_horafin'] as String?),
    ) ;
      print(item['rt_horafin']);
    }
  }

return gifs;

  }else {
    throw Exception("fallo la conexion");
  }
}

void _loadData(){
   final query = _controller.text;
  setState(() {
    _dataloaded=true;
    _listadoEventos=_getevento(query);
  });
}

 List<Widget> _listEventos(List<Gif> data){
    List<Widget> gifs =[];

  
for (Gif gif in data) {
  String cambioHora=gif.url;
    List<String> partsdeHora = cambioHora.split(":");
     String hours = "${partsdeHora[0]}:${partsdeHora[1]}";
     
  String cambioHorafin=gif.edi!;
    List<String> partsdeHorafin = cambioHorafin.split(":");
     String hoursfin = "${partsdeHorafin[0]}:${partsdeHorafin[1]}";

     
    gifs.add(
            Container(
              
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all()

),
              margin: const EdgeInsets.all(10)           
              ,child: Column(
                children: [
                  Text(gif.name,style: const TextStyle(
                    color: Color.fromARGB(255, 88, 88, 88)
                    )
                  ),
                  Text("de ${hours} a ${hoursfin} horas",style: const TextStyle(
                    color: Color.fromARGB(255, 88, 88, 88)
                    )
                  ),
                  Row(children: [
                    ElevatedButton(onPressed: (){}, child: Text("Editar")),
                    ElevatedButton(onPressed: (){}, child: Text("Eliminar")),
                  ],)
                ],
              )
            ),
          
    );
}
  
        
  return gifs;
}





// funcion que crea botones para ir al salon  
  List<Widget> _listGifs(List<Gif> data){
    List<Widget> gifs =[];

for (Gif gif in data) {
  
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
                  int? currentindex =gif.id;
                  if(currentindex != null ){

                  final ruta=MaterialPageRoute(
                    builder:(context){
                      return Rooms(numeroURl: currentindex,);
                    }
                      );
                      Navigator.push(context,ruta);
                  }
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

