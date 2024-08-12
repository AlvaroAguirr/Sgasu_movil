import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sgasu_movil/models/event.dart';
import 'package:sgasu_movil/screens/hours.dart';
import 'package:sgasu_movil/screens/tile.dart';
import 'package:sgasu_movil/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Scroll extends StatefulWidget {
  const Scroll({super.key});

  @override
  State<Scroll> createState() => _ScrollState();
}

class _ScrollState extends State<Scroll> {
CalendarFormat _calendarFormat=CalendarFormat.month;
DateTime _focusedDay= DateTime.now();
DateTime? _selectedDay;


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

  print('Día del mes: $dia');


    return Scaffold(
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
        child: Text(
          "fiesl"
        ),
        ),
        actions: [
      
        ]
      );
    });
  },
child: const Icon(Icons.add)
),

      body: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(40),
        color: AppTheme.whiteColor,
         ),
        margin: EdgeInsets.all(20),
        child: ListView(
          children: [
            Text("asd"),

TableCalendar(
  firstDay: DateTime.utc(2010,3,14),
  lastDay: DateTime.utc(2030,3,14),
  focusedDay: _focusedDay,
  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  calendarFormat: _calendarFormat,
  startingDayOfWeek: StartingDayOfWeek.monday,
  onDaySelected: _onDaySelected,
  eventLoader: _getEventsForDay,
  calendarStyle: const CalendarStyle(
    outsideDaysVisible: true,
  ),
  onFormatChanged: (format){
    if(_calendarFormat !=format){
      setState(() {
        _calendarFormat=format;
      });
    }
  },
  onPageChanged: (focusDay){
    _focusedDay=focusDay;
  },
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("holas"),
                //horas 
                Container(
                  width: 70,
                  height: 100,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.3,
                    physics: FixedExtentScrollPhysics() ,
                     childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 14,
                      builder: (context, index){
                        return Hours(
                          horas: index,
                        );
                      }
                     )),
                ), // par minutos
                Container(
                  width: 70,
                  height: 100,
                  child: ListWheelScrollView.useDelegate(
                    itemExtent: 50,
                    perspective: 0.005,
                    diameterRatio: 1.3,
                    physics: FixedExtentScrollPhysics() ,
                     childDelegate: ListWheelChildBuilderDelegate(
                      childCount: 60,
                      builder: (context, index){
                        return Hours(
                          horas: index,
                        );
                      }
                     )),
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}