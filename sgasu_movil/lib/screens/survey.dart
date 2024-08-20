import 'package:flutter/material.dart';
import 'package:sgasu_movil/screens/home_screens.dart';
import 'package:sgasu_movil/theme/app_theme.dart';

class Survey extends StatefulWidget {
  const Survey({super.key});

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  bool estrad = false;
  bool micro = false;
  bool pantalla = false;

  String? nombre;
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
              "Formulario ",
              style: TextStyle(
                  fontSize: 35,
                  color: AppTheme.whiteColor,
                  fontFamily: 'Roboto'),
            ))
          ]),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              width: 500,
              height: 150,
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(
                children: const [
                  Text(
                    "Datos personales:",
                    style: TextStyle(fontSize: 21, fontFamily: 'Roboto'),
                  ),
                  Divider(
                    height: 10,
                    color: Color.fromARGB(0, 222, 218, 204),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Nombre',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Matrícula',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 200,
            height: 150,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(19.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 251, 251),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              children: [
                const Text("Requisitos de la petición:",
                    style: TextStyle(fontSize: 21)),
                Row(
                  children: [
                    const Text("Estrado"),
                    Checkbox(
                        value: estrad,
                        onChanged: (value) {
                          setState(() {
                            estrad = value!;
                          });
                        }),
                    const SizedBox(
                      width: 80,
                    ),
                    const Text("Micrófonos"),
                    Checkbox(
                        value: micro,
                        onChanged: (value) {
                          setState(() {
                            micro = value!;
                          });
                        }),
                  ],
                ),
                Row(
                  children: [
                    Text("Pantalla"),
                    Checkbox(
                        value: pantalla,
                        onChanged: (value) {
                          setState(() {
                            pantalla = value!;
                          });
                        }),
                  ],
                )
              ],
            ),
          ),
          Container(
            width: 200,
            height: 200,
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(19.0),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 251, 251),
              borderRadius: BorderRadius.circular(20),
            ),
            child: ListView(
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Descripción del evento:",
                      style: TextStyle(fontSize: 21)),
                ),
                Divider(
                  height: 20,
                  color: Color.fromARGB(0, 33, 149, 243),
                ),
                TextField(
                  decoration: InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Escriba aquí'),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            margin: const EdgeInsets.all(20.0),
            child: MaterialButton(
              height: 50,
              color: AppTheme.backcolorGreen,
              onPressed: () {
                final ruta = MaterialPageRoute(builder: (context) {
                  return const HomeScreen();
                });
                Navigator.push(context, ruta);
              },
              child: const Text(
                "Guardar",
                style: TextStyle(
                    color: AppTheme.whiteColor,
                    fontFamily: 'Raleway',
                    fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField entradaTexto() {
    return TextField(
      style: const TextStyle(color: Color.fromARGB(255, 255, 118, 118)),
      decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          labelText: 'Escribe tu nombre: ',
          labelStyle: TextStyle(color: Color.fromARGB(255, 165, 255, 175))),
      onChanged: (text) {
        nombre = text;
      },
    );
  }
}
