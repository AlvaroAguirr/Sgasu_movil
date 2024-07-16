import 'package:flutter/material.dart';
import 'package:sgasu_movil/screens/survey.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Color.fromARGB(221, 11, 52, 67),
  backgroundColor: Color.fromARGB(255, 121, 220, 245),
  
  

  minimumSize: Size(120, 100),
  padding: EdgeInsets.symmetric(horizontal: 16),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
  String? nombre;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(3.0),
          child: Container(color: Colors.orange,
          height: 4,),
        ),
        title: const Text( "Edificios UTT",
          style: TextStyle(color: Colors.white,
          fontSize: 28),),
        backgroundColor: Color.fromARGB(255, 90, 212, 114),
        
      ),
      body: ListView(
        children:     [
  Padding(padding: const EdgeInsets.all(20.0),
          child:
              Container(width: 500,
              height:700,
              
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
        color: const Color.fromARGB(255, 255, 251, 251),
                borderRadius: BorderRadius.circular(4),
              ),

              child: ListView(children:  [
                const Text("Seleccione un edificio", style: TextStyle(fontSize: 21),),
                SizedBox(height: 20,),
                Divider(height:2,color: Color.fromARGB(255, 141, 236, 239),),
                SizedBox(height: 20,),
                const Divider(height: 10,color: Color.fromARGB(0, 222, 218, 204),),
            Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: (){
                    final ruta=MaterialPageRoute(builder: (context){
                      return const Survey();
                    }
                    );
                    Navigator.push(context,ruta);
                  },
                   child: Text("Edificio P",style: TextStyle(fontSize: 28),))
              ),
              const SizedBox(width: 20,),
               SizedBox(
               width: 150,
                height: 150,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: null,
                   child: Text("Edificio C",style: TextStyle(fontSize: 28),))
              ),
            ],
            ),
            SizedBox(height: 20,),
            Row(mainAxisAlignment: MainAxisAlignment.center,
              
            children: [
              SizedBox(
                
                width: 150,
                height: 150,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: null,
                   child: Text("Edificio H",style: TextStyle(fontSize: 28),))
              ),
                 const SizedBox(width: 20,),
              SizedBox(
                
                width: 150,
                height: 150,
                child: ElevatedButton(
                  style: raisedButtonStyle,
                  onPressed: null,
                   child: Text("Edificio D",style: TextStyle(fontSize: 28),))
              ),

            ],)
              ],),
          ),
        ),
        

         
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

