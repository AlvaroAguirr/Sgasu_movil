import 'package:flutter/material.dart';


class Expandir{
  Expandir({
    required this.headerText,
    required this.expandedText,
    this.isExpanded = false,
  });
  String headerText;
  String expandedText;
  bool isExpanded;
}


class Buttomsheet extends StatefulWidget {
  const Buttomsheet({super.key});

  @override
  State<Buttomsheet> createState() => _ButtomsheetState();
}

class _ButtomsheetState extends State<Buttomsheet> {

final List<Expandir> _data= List<Expandir>.generate(
  4,
  (int index){
    return Expandir(
      headerText: 'item $index',
      expandedText: 'numero $index'
    );
  }
);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
               SingleChildScrollView(
                          child: ExpansionPanelList(
                      expansionCallback: (int index, bool isExpanded){
                        setState(() {
_data[index].isExpanded = !(_data[index].isExpanded);

                        });
                      },
                      children: _data.map<ExpansionPanel>((Expandir item) {
                        return ExpansionPanel(
                          headerBuilder: (BuildContext context, bool isExpanded){
                            return ListTile(
                              title: Text(item.headerText),
                            );
                          },
                          body:
                          
                            ListTile(title:Text(item.expandedText),
                          subtitle: Text("eliminar"),
                          trailing: Icon(Icons.delete),
                          onTap: (){
                            setState(() {
                              _data
                                .removeWhere((Expandir currentItem) => item ==currentItem);
                              
                            });
                          },
                          ),
                          isExpanded: item.isExpanded,
                        );
                      } ).toList(),
                          )
                        ),

            ElevatedButton(
            
              child: Text("hola que hace"),
              onPressed: (){
                showModalBottomSheet(
                  context: context,
                   builder: (BuildContext Context){
                    return SizedBox(
                      height: 400,
                      child: Center(
                        child: ElevatedButton(
                          child: Text("cerrar"),
                          onPressed: (){},
                        ),
                      ),
                    );
                   });
              },
              ),
          ],
        ),
      ),
    );
  }
}