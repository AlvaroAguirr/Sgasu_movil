import 'package:flutter/material.dart';
import 'package:sgasu_movil/models/event.dart';
import 'package:sgasu_movil/screens/hours.dart';
import 'package:sgasu_movil/screens/survey.dart';
import 'package:sgasu_movil/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';


class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}
 
class _ScheduleState extends State<Schedule> {
DateTime _focusedDay= DateTime.now();
DateTime? _selectedDay;

//Store the events created 

Map<DateTime, List<Event>> events ={};
TextEditingController _eventControler = TextEditingController();
late final ValueNotifier<List<Event>> _selectedEvent;

@override
  void initState(){
super.initState();
_selectedDay=_focusedDay;
_selectedEvent = ValueNotifier(_getEventsForDay(_selectedDay!));
  }


@override
 void dispose(){
    _eventControler.dispose();
  super.dispose();
 }


  void _onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(!isSameDay(_selectedDay, selectedDay)){

        setState(() {
    _focusedDay=focusedDay;
    _selectedDay =selectedDay;  
    _selectedEvent.value =_getEventsForDay(selectedDay);
        });
     }
  }


List<Event> _getEventsForDay(DateTime day){
  return events[day] ?? [];
}

  @override 
  Widget build(BuildContext context) {
 DateTime now = _selectedDay!;
  String dia = DateFormat('d').format(now); 


    
    return  Scaffold(
      resizeToAvoidBottomInset:false,
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
floatingActionButton: FloatingActionButton(
  onPressed: (){
    showDialog(context: context
    , builder: (context){
      return AlertDialog(
        scrollable: true,
        title: const Text("Hora del evento" ),
        content: 
        Padding(padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: _eventControler,
        ),
        ),
        actions: [
          ElevatedButton(onPressed: (){
             if (events[_selectedDay] != null) {
                  events[_selectedDay]!.add(Event(_eventControler.text));
                } else {
                  events[_selectedDay!] = [Event(_eventControler.text)];
                }
          _selectedEvent.value=_getEventsForDay(_selectedDay!);
          Navigator.of(context).pop();
          _eventControler.clear();
          }, 
          child:const Text("hecho")
          ),
        ]
      );
    });
  },
child: const Icon(Icons.add)
),
body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20),
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color: AppTheme.whiteColor,
         ),child: Column(
          children: [
              Text("Dia seleccionado "+ _selectedDay.toString().split(" ")[0]),
TableCalendar(
  rowHeight: 42,
  firstDay: DateTime.utc(2010,3,14),
  lastDay: DateTime.utc(2030,3,14),
  focusedDay: _focusedDay,
  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  startingDayOfWeek: StartingDayOfWeek.monday,
  onDaySelected: _onDaySelected,
  eventLoader: _getEventsForDay,
  headerStyle: const HeaderStyle(formatButtonVisible: false),
 
),
        Table(
            border: TableBorder.all(), // Añade un borde a la tabla
            children:  [
              const TableRow(
                children: [
                  
                    
                     Center(child: Text('Dia selecionado')),
                  
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hora de inicio'),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Hora de termino'),
                  ),
                ],
              ),
              TableRow(
                children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    
                    child: Text("$dia",
                    style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold),),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:   horas(1),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child:  horas(2)
                  ),
                ],
              ),
            ],
          ),
Expanded(
  child: ValueListenableBuilder<List<Event>>(
    valueListenable: _selectedEvent,
   builder: (context,value, _){
    return ListView.builder(
      itemCount: value.length,
      itemBuilder: (context,index){
      return Container(
        margin: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(),
            borderRadius: BorderRadius.circular(12)
          ),
        child: ListTile(
          onTap: () => print(""),
          title: Text('${value[index]}'),
          ),
      );
      
    });
   }),
),

Text("$dia " " ${pahora.toString()}" " ${pahora2.toString()} "),
            MaterialButton(highlightColor: AppTheme.backcolorGreen,
            color:AppTheme.backcolorGreen ,
            height: 50,
            minWidth: 100
            ,onPressed: (){
                  final ruta=MaterialPageRoute(builder: (context){
                        return  const Survey(
                        ); }
                      );
                      Navigator.push(context,ruta);
            }, child: 
            Text("guardar")
            ,),
          ],
         ),
         
)
    );
  }

int pahora=7;
int pahora2=7;


  SizedBox horas(int variaa) {
    return SizedBox(
                      width: 30,
                      height: 80,
                      child: ListWheelScrollView.useDelegate(
                        onSelectedItemChanged: (index) {
                setState(() {
                  if(variaa ==1){
                  pahora = index+7; // Asignar el índice seleccionado a la variable

                  } else if (variaa ==2){
                    pahora2=index+7;
                  }
                }); },
                        itemExtent: 50,
                        perspective: 0.008,
                        diameterRatio: 1.4,
                        physics: FixedExtentScrollPhysics() ,
                         childDelegate: ListWheelChildBuilderDelegate(
                          childCount: 14,
                          builder: (context, index){
                            return Hours(
                              horas: index,
                            );
                          }
                         )),
                    );
  }
}