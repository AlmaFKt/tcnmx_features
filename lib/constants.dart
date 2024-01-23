import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/greeting_utils.dart';

// Archivo para definir constantes y reutilizarlas en el proyecto

var myAppBar = AppBar(
  backgroundColor: Color.fromARGB(255, 94, 125, 198),
  title: Center(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Texto Titulo de appBar
        Text(
          'Instituto Tecnológico de Zacatepec',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w100,
          ),
        ),

        const SizedBox(width: 35),
        // Espacio entre el texto y el logo

        //Logo de ITZ
        SvgPicture.asset(
          'images/TecZaca.svg',
          width: 50,
        ),
      ],
    ),
  ),
);

//Color de fondo de todas las interfaces responsivas
var myBackground = Color.fromARGB(255, 246, 246, 246);

//Widget para mostrar el saludo en la interfaz
var GreetingWidget = Container(
  width: double.infinity,
  padding: EdgeInsets.all(16.0),
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 204, 237, 241),
    borderRadius: BorderRadius.vertical(bottom: Radius.circular(16.0)),
    border: Border.all(
      color: Color.fromARGB(255, 7, 12, 146), // Color del borde
      width: 0.5,
    ),
  ),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        //Saludo de la hora del día
        GreetingUtils.getGreeting() + '!',
        style: TextStyle(
          fontSize: 20,
          color: const Color.fromARGB(255, 0, 0, 0),
        ),
      ),
      Text(
        //Saludo del día de la semana
        GreetingUtils.getCurrentDayGreeting(),
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    ],
  ),
);
