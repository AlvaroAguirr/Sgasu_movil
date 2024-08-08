import 'package:flutter/material.dart';
import 'package:sgasu_movil/screens/home_screens.dart';

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
      appBar: AppBar(
        actions: <Widget>[
          IconButton(onPressed: (){
               
          },
           icon: Icon(Icons.search))
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(color: Colors.orange,
          height: 4,),
        ),
        title: const Text( "encuesta",style: TextStyle(color: Colors.white),),
        backgroundColor: Color.fromARGB(255, 90, 212, 114),
        
      ),
      body: ListView(
        children:     [
  Padding(padding: const EdgeInsets.all(20.0),
          child:
              Container(width: 500,
              height:150,
              
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListView(children: const [
                Text("Datos Personales",style:TextStyle(fontSize: 21),),
                Divider(height: 10,color: Color.fromARGB(0, 222, 218, 204),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(width: 20,),
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
              ],),
          ),
          
        ),
        Container(width: 200,
         height: 150,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(19.0),
              
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(20),),
          
          
          child:
         ListView(children: [
          const Text("Requisitos de Petición",style:TextStyle(fontSize: 21)),
          Row(children: [
              const Text("Estrado"),
              Checkbox(value: estrad,
               onChanged: (value){
                setState(() {
                  estrad = value!;
                });
               }),
               const SizedBox(width: 80,),
              const Text("Micrófonos"),
              Checkbox(value: micro,
               onChanged: (value){
                setState(() {
                  micro = value!;
                });
               }),


          ],),
          Row(children: [
            Text("Pantalla"),
             Checkbox(value: pantalla,
               onChanged: (value){
                setState(() {
                  pantalla = value!;
                });
               }),
          ],)

         ],),),

         Container(width: 200,
         height: 200,
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(19.0),
              
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListView(children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Descripción del evento",style:TextStyle(fontSize: 21)),
                ),

                Divider(height: 20,color: Color.fromARGB(0, 33, 149, 243),),
                
                TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Escriba aquí'
                  ),

                )
                
                ],),),
              ElevatedButton(onPressed: (){
                 final ruta=MaterialPageRoute(builder: (context){
                        return  const HomeScreen(
                        ); }
                      );
                      Navigator.push(context,ruta);
              }, child: Text("Guardar")),
        ],
      ) ,
    );
  } 

  TextField entradaTexto() {
    return TextField(
      style: TextStyle(color: Color.fromARGB(255, 255, 118, 118)),
    
      decoration: const InputDecoration(
        border: UnderlineInputBorder(),
        labelText: 'Escribe tu nombre: ',
        labelStyle: TextStyle(color: Color.fromARGB(255, 165, 255, 175))

      ),
      onChanged: (text) {
        nombre = text;
      },
    );
  }
}

