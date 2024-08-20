import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sgasu_movil/global/common/toast.dart';
import 'package:sgasu_movil/models/event.dart';
import 'package:sgasu_movil/models/gif.dart';
import 'package:sgasu_movil/screens/hours.dart';
import 'package:sgasu_movil/screens/survey.dart';
import 'package:sgasu_movil/theme/app_theme.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Schedule extends StatefulWidget {
  final String nSalon;
  final String nEdificio;

  const Schedule({
    required this.nSalon,
    required this.nEdificio,
    super.key,
  });

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _diaSeman = '';

  Map<DateTime, List<Event>> events = {};
  TextEditingController _eventControler = TextEditingController();
  late final ValueNotifier<List<Event>> _selectedEvent;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvent = ValueNotifier(_getEventsForDay(_selectedDay!));
    _diaSeman = DateFormat('EEEE').format(_selectedDay!);
  }

  @override
  void dispose() {
    _eventControler.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _diaSeman = DateFormat('EEEE').format(selectedDay);
        _focusedDay = focusedDay;
        _selectedDay = selectedDay;
        _selectedEvent.value = _getEventsForDay(selectedDay);
        _loadData();
      });
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = _selectedDay!;
    String dia = DateFormat('d').format(now);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(90),
        child: AppBar(
          title: const Column(
            children: [
              SizedBox(height: 30),
              Center(
                child: Text(
                  "SGASU",
                  style: TextStyle(fontSize: 40, color: AppTheme.whiteColor),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: AppTheme.whiteColor,
        ),
        child: ListView(
          children: [
            Text("Apartando ${widget.nSalon} del ${widget.nEdificio}"),
            Expanded(
              child: TableCalendar(
                rowHeight: 42,
                firstDay: DateTime.utc(2024, 3, 14),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                startingDayOfWeek: StartingDayOfWeek.monday,
                onDaySelected: _onDaySelected,
                eventLoader: _getEventsForDay,
                headerStyle: const HeaderStyle(formatButtonVisible: false),
              ),
            ),
            Expanded(
              child: Table(
                border: TableBorder.all(), // Añade un borde a la tabla
                children: [
                  const TableRow(
                    children: [
                      Center(child: Text('Día seleccionado')),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hora de inicio'),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Hora de término'),
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "$dia",
                          style: const TextStyle(
                              fontSize: 45, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: horas(1),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: horas(2),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all()),
                child: _dataloaded
                    ? FutureBuilder(
                        future: _listadoHorarios,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView(
                              children: _listHorarios(snapshot.data!),
                            );
                          } else if (snapshot.hasError) {
                            print("${snapshot.error} en el listado");
                            return const Text("Ocurrió un error al consultar");
                          }
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      )
                    : const Text("Horarios apartados "),
              ),
            ),
            // Expanded(
            //   child: ValueListenableBuilder<List<Event>>(
            //     valueListenable: _selectedEvent,
            //     builder: (context, value, _) {
            //       return ListView.builder(
            //         itemCount: value.length,
            //         itemBuilder: (context, index) {
            //           return Container(
            //             margin:
            //                 const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            //             decoration: BoxDecoration(
            //               border: Border.all(),
            //               borderRadius: BorderRadius.circular(12),
            //             ),
            //             child: ListTile(
            //               onTap: () => print(""),
            //               title: Text('${value[index]}'),
            //             ),
            //           );
            //         },
            //       );
            //     },
            //   ),
            // ),


            Text("$dia ${pahora.toString()} ${pahora2.toString()}"),
            MaterialButton(
              highlightColor: AppTheme.backcolorGreen,
              color: AppTheme.backcolorGreen,
              height: 50,
              minWidth: 100,
              onPressed: () async {
                    DateTime currentDate = DateTime.now();

                 
                if(_selectedDay !=null){
                  if(_selectedDay!.isBefore(currentDate)){
                    Fluttertoast.cancel();
                    showToast(message: "La fecha seleccionada  es anterior a la fecha actual");
                  }else {
                       List<Gif> existingEvents = await _getevento(_selectedDay!);
        bool isConflict = existingEvents.any((event) => event.name == pahora.toString());
                     if (isConflict) {
          Fluttertoast.cancel();
          showToast(message: "Ya existe un evento a la hora de inicio seleccionada");
        } else
                if (pahora < pahora2) {
                  final ruta = MaterialPageRoute(builder: (context) {
                    return Survey(
                      horaIni: pahora,
                      horaFinal: pahora2,
                      fechadia: dia,
                    );
                  });
                  Navigator.push(context, ruta);
                } else {
                   Fluttertoast.cancel();
                  showToast(message: 'La hora de finalización debe ser mayor a la de inicio');
                   }
                  }
                }
              },
              child: const Text("Guardar"),
            ),
          ],
        ),
      ),
    );
  }

  int pahora = 7;
  int pahora2 = 7;

  Future<List<Gif>>? _listadoHorarios;
  bool _dataloaded = false;

  Future<List<Gif>> _getevento(DateTime selectedDay) async {
      String formattedDate = DateFormat('d').format(selectedDay);

      int cambio2= int.parse(formattedDate);
    // para leer datos del sistema web
    final response = await http.get(Uri.parse("http://192.168.100.9:8000/API/solicitud"));
    List<Gif> gifs = [];
    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      final jsonData = jsonDecode(body);
      
      for (var item in jsonData) {
        
      if(item["rt_dia"]==cambio2)  {

          gifs.add(Gif(item["request_time"], item["rt_horafin"]));
        }
        }

       

   
      return gifs;
    } else {
      throw Exception("Falló la conexión");
    }
  }

  void _loadData() {
    setState(() {
      _dataloaded = true;
      _listadoHorarios = _getevento(_selectedDay!);
    });
  }

  List<Widget> _listHorarios(List<Gif> data) {
    List<Widget> horas = [];

    for (Gif hora in data) {
      horas.add(
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), border: Border.all()),
          child: Container(child: Text("Apartado de ${hora.name} hasta la ${hora.url}")),
        ),
      );
    }

    return horas;
  }

  SizedBox horas(int variaa) {
    return SizedBox(
      width: 30,
      height: 80,
      child: ListWheelScrollView.useDelegate(
        onSelectedItemChanged: (index) {
          setState(() {
            if (variaa == 1) {
              pahora = index + 7; // Asignar el índice seleccionado a la variable
            } else if (variaa == 2) {
              pahora2 = index + 7;
            }
          });
        },
        itemExtent: 50,
        perspective: 0.008,
        diameterRatio: 1.4,
        physics: const FixedExtentScrollPhysics(),
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: 14,
          builder: (context, index) {
            return Hours(
              horas: index,
            );
          },
        ),
      ),
    );
  }
}