import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sgasu_movil/global/common/toast.dart';
import 'package:sgasu_movil/screens/home_screens.dart';

import 'package:http/http.dart' as http;

class Survey extends StatefulWidget {
final int horaIni;
final int horaFinal;
final String fechadia;




  const Survey({
    required this.horaIni,
    required this.horaFinal,
    required this.fechadia,
    super.key
    });

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {


  bool estrad = false;
  bool micro = false;
  bool pantalla = false;
  bool projector = false;

  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();

Map<String, String> extrasMap = {
  'Micrófonos': 'microphones',
  'Estrado': 'podium',
  'Presidio': 'presidio',
  'Proyector': 'proyector',
  'Pantalla': 'TV',
};

List<String> seleciones =[];



  void _checkBoxaAdd(bool? value, String itemName) {
    setState(() {
      if (value == true) {
        // Si el checkbox se selecciona, añade el item a la lista
        seleciones.add(itemName);
      } else {
        // Si el checkbox se deselecciona, elimina el item de la lista
        seleciones.remove(itemName);
      }
    });
  }

Future<void> _hacerPeticion() async{

String  asu =_nombreController.text;
int cambio =asu.length;

  final url = Uri.parse('http://192.168.100.9:8000/API/solicitud/create');
  final headers ={"Content-Type": "application/json"};
  final body=jsonEncode({
    "applicant_name": _nombreController.text,
    'rt_matricula': _matriculaController.text,
    "rt_dia": widget.fechadia,
    "rt_objetos": seleciones,
    "request_time": '${widget.horaIni}:00:00',
    "rt_horafin": '${widget.horaFinal}:00:00',
    "classroom_name": 2,
    "rt_horario": 1

    }
  );

  try{
    final response =await http.post(url,headers: headers, body:body);
   if(response.statusCode ==201){
    print("peticion fue enviada correctamente");
showToast(message: "Se ha realizado tu reservación ");
    
   } else {
    print("no se envio nada ");


    print('Response status: ${response.statusCode}');
print('Response body: ${response.body}');
   }
  } catch(e){
    print("Error $e");
  }
}

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
          Text("${widget.horaIni} ${widget.horaFinal} ${widget.fechadia}"),
  Padding(padding: const EdgeInsets.all(20.0),
          child:
              Container(width: 500,
              height:150,
              
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(20),
              ),

              child: ListView(children:  [
                Text("Datos Personales",style:TextStyle(fontSize: 21),),
                Divider(height: 10,color: Color.fromARGB(0, 222, 218, 204),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 100,
                height: 50,
                child: entradaTexto('Nombre', TextCapitalization.words,_nombreController, 25),
             
              ),
              SizedBox(width: 20,),
              SizedBox(
                width: 100,
                height: 50,
                child: entradaTexto('MatrÍcula', TextCapitalization.characters, _matriculaController, 11)
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
                  _checkBoxaAdd(value,'podium' );

                });
               }),
               const SizedBox(width: 20,),
              const Text("Micrófonos"),
              Checkbox(value: micro,
               onChanged: (value){
                setState(() {
                  micro = value!;
               _checkBoxaAdd(value,'microphones' );

                });
               }),


          ],),
          Row(children: [
            Text("Pantalla"),
             Checkbox(value: pantalla,
               onChanged: (value){
                setState(() {
                  pantalla = value!;
                _checkBoxaAdd(value,'TV' );
                 print('$seleciones');
                });
               }),
    const SizedBox(width: 20,),
              const Text("Projector"),
              Checkbox(value: projector,
               onChanged: (value){
                setState(() {
                  projector = value!;
               _checkBoxaAdd(value,'Projector' );

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
              
                if(_matriculaController.text.length <11 || _matriculaController ==''){
                  showToast(message: "La matrícula no es correcta");
                } else if (_matriculaController.text.length >= 1){
                _hacerPeticion();

                }

           
              }, child: Text("Guardar")),
        ],
      ) ,
    );
  } 


  TextField entradaTexto(String textot,
   TextCapitalization capitalization,
    TextEditingController controller, int Largo) {

    return TextField(
        maxLength: Largo,
      
      controller: controller,
        textCapitalization: capitalization,
      decoration:  InputDecoration(
        counterText: '',
        border: OutlineInputBorder(),
        labelText: textot,
        
      ),
   
    );
  }
}
