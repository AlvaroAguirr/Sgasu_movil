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
  DateTime today = DateTime.now();
  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventControler = TextEditingController();

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
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
                "Horario",
                style: TextStyle(
                  fontSize: 40,
                  color: AppTheme.whiteColor,
                  fontFamily: 'Raleway',
                ),
              ))
            ]),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      scrollable: true,
                      title: const Text("Hora del evento"),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          controller: _eventControler,
                        ),
                      ),
                      actions: [],
                    );
                  });
            },
            child: const Icon(Icons.add)),
        body: Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            color: AppTheme.whiteColor,
          ),
          child: Column(
            children: [
              Text(
                "Día seleccionado: " + today.toString().split(" ")[0],
                style: const TextStyle(fontFamily: 'Raleway', fontSize: 20),
              ),
              Container(
                child: TableCalendar(
                  locale: "en_US",
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(
                      formatButtonVisible: false, titleCentered: true),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2020, 10, 16),
                  lastDay: DateTime.utc(2025, 3, 14),
                  onDaySelected: _onDaySelected,
                ),
              ),
              Text(today.toString().split(" ")[0]),
              SizedBox(height: 20),
              Text("aqui habra un widget que muestre la hora"),
              SizedBox(height: 200),
              MaterialButton(
                highlightColor: AppTheme.backcolorGreen,
                color: AppTheme.backcolorGreen,
                height: 50,
                minWidth: 350,
                onPressed: () {
                  final ruta = MaterialPageRoute(builder: (context) {
                    return const Survey();
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
              )
            ],
          ),
        ));
  }
}
