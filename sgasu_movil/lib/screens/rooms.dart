import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sgasu_movil/models/Gif.dart';

import 'package:http/http.dart' as http;
import 'package:sgasu_movil/screens/schedule.dart';
import 'package:sgasu_movil/theme/app_theme.dart';

class Rooms extends StatefulWidget {
  const Rooms({super.key});

  @override
  State<Rooms> createState() => _RoomsState();
}

class _RoomsState extends State<Rooms> {
  int? obje;

  late Future<List<Gif>> _listadoGifs;

  Future<List<Gif>> _getGif() async {
//aqui es donde se pega el url de insomnia si es que te lo llega a cambiar cuando lo crees
    final response = await http.get(Uri.parse(
        "https://mock_8afac354b19843ceaafbba4ff730e71d.mock.insomnia.rest/"));

    List<Gif> gifs = [];

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);

// print(jsonData["edificios"][0]["nombre"]);
// print(jsonData["edificios"][0]["salones"][0]["nombre_aula"]);

      for (var item in jsonData["edificios"][1]["salones"]) {
        gifs.add(
          Gif(item["nombre_aula"], item["tipo"]),
        );
      }
      return gifs;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  @override
  void initState() {
    super.initState();
    _listadoGifs = _getGif();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          title: const Column(children: [
            SizedBox(
              height: 30,
            ),
            Center(
                child: Text(
              "Salones ",
              style: TextStyle(
                  fontSize: 35,
                  color: AppTheme.whiteColor,
                  fontFamily: 'Raleway'),
            ))
          ]),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: AppTheme.whiteColor,
        ),

        //Tarjetas generadas por respuesta de api
        child: FutureBuilder(
          future: _listadoGifs,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView(
                padding: const EdgeInsets.all(20),
                //llamdo de la funcion _listGifs de abajo
                children: _listGifs(snapshot.data!),
              );
            } else if (snapshot.hasError) {
              print(snapshot.error);
              return const Text(
                  'Ocurrió un error al mostrar las tarjetas en salones ');
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _listGifs(List<Gif> data) {
    List<Widget> gifs = [];

    for (var gif in data) {
      gifs.add(Container(
          height: 125,
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(255, 247, 255, 190),
                Color.fromARGB(255, 138, 206, 145),
              ],
            ),
          ),
          child: MaterialButton(
            onPressed: () {
              final ruta = MaterialPageRoute(builder: (context) {
                return const Schedule();
              });
              Navigator.push(context, ruta);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  gif.name,
                  style: const TextStyle(
                      fontSize: 30,
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontFamily: 'Raleway'),
                ),
                Text(
                  gif.url,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color.fromARGB(255, 119, 150, 119),
                  ),
                ),
              ],
            ),
          )));
    }
    print(gifs);
    return gifs;
  }
}
