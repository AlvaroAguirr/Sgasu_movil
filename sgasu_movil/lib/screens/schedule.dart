import 'package:flutter/material.dart';
import 'package:sgasu_movil/models/event.dart';
import 'package:sgasu_movil/screens/survey.dart';
import 'package:sgasu_movil/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';

class Schedule extends StatefulWidget {
  const Schedule({super.key});

  @override
  State<Schedule> createState() => _ScheduleState();
}
 
class _ScheduleState extends State<Schedule> {
CalendarFormat _calendarFormat=CalendarFormat.month;
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
  super.dispose();
 }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay){
    if(!isSameDay(_selectedDay, selectedDay)){

    setState(() {
_selectedDay =selectedDay;  
_focusedDay=focusedDay;
_selectedEvent.value =_getEventsForDay(selectedDay);
    });
    }
  }


List<Event> _getEventsForDay(DateTime day){
  return events[day] ?? [];
}

  @override
  Widget build(BuildContext context) {
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

                events.addAll({
                  _selectedDay! : [Event(_eventControler.text)]
                  });
          Navigator.of(context).pop();
          _selectedEvent.value=_getEventsForDay(_selectedDay!);
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
  firstDay: DateTime.utc(2010,3,14),
  lastDay: DateTime.utc(2030,3,14),
  focusedDay: _focusedDay,
  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
  calendarFormat: _calendarFormat,
  startingDayOfWeek: StartingDayOfWeek.monday,
  onDaySelected: _onDaySelected,
  eventLoader: _getEventsForDay,
  calendarStyle: const CalendarStyle(
    outsideDaysVisible: false,
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

SizedBox(height: 7,),
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
          onTap: () => print("${value.length}"),
          title: Text('${value[index]}'),
          ),
      );
      
    });
   }),
),



              //   TableCalendar(
              //     locale: "en_US",
              //     rowHeight: 43,
              //     headerStyle: 
              //       const HeaderStyle(formatButtonVisible: false,titleCentered: true),
              //       availableGestures: AvailableGestures.all,
              //       selectedDayPredicate: (day) => isSameDay(day, today),
              //     focusedDay: today,
              //     firstDay:DateTime.utc(2020,10,16) ,
              //     lastDay: DateTime.utc(2025,3,14),
              //     onDaySelected: _onDaySelected,
              // ),
              Text(_selectedDay.toString().split(" ")[0]),
              SizedBox(height: 10),
              Text("aqui habra un widget que muestre la hora"),
              SizedBox(height: 100),
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
            ,)
          ],
         ),
         
)
    );
  }
}