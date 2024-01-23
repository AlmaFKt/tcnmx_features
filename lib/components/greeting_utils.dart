// Class to avoid the DRY principle
//Clase para evitar el principio DRY (no repetirte a ti mismo)

//Con authStateChanges() podemos obtener el estado de la autenticación
import 'package:firebase_auth/firebase_auth.dart';

class GreetingUtils {
  //Para obtener el saludo dependiendo de la hora del día
  static String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Buenos días';
    }
    if (hour < 17) {
      return 'Buenas tardes';
    }
    return 'Buenas noches';
  }

//Para obtener el saludo dependiendo del día de la semana
  static String getCurrentDayGreeting() {
    final Map<int, String> dayGreetings = {
      DateTime.monday: 'Buen Lunes',
      DateTime.tuesday: 'Genial Martes',
      DateTime.wednesday: 'Excelente Miércoles',
      DateTime.thursday: 'Feliz Jueves',
      DateTime.friday: 'Fantástico Viernes',
      DateTime.saturday: 'Súper Sábado',
      DateTime.sunday: 'Domingo de descanso',
    };

//Para obtener el día actual
    final int currentDay = DateTime.now().weekday;
    return dayGreetings[currentDay] ?? 'Hello';
  }

//Para obtener el nombre del usuario ??
  static String getUserName(User? user) {
    return user?.displayName ?? 'User Name';
  }
}
