import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'components/greeting_utils.dart';

// Archivo para definir constantes y reutilizarlas en el proyecto

var myAppBar = AppBar(
  backgroundColor: Color.fromARGB(255, 94, 125, 198),
  title: Center(
    child: Builder(builder: (BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Texto Titulo de appBar
          Flexible(
            child: Text(
              'Instituto Tecnológico de Zacatepec',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onTertiary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 10),

          //Logo de ITZ
          SvgPicture.asset(
            'images/TecZaca.svg',
            width: 40,
          ),
        ],
      );
    }),
  ),
);

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

class Auth {
  static Future<void> signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}
