import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tecnamex_features/Drawer/CambiarPass.dart';
import 'package:tecnamex_features/Drawer/CorreosProfs.dart';
import 'package:tecnamex_features/Drawer/ValidarHora.dart';
import 'package:tecnamex_features/theme/theme.dart';
import 'package:tecnamex_features/constants.dart';
import '../loguear/inicio_sesion.dart';
import '../theme/theme_provider.dart';

class mobileBody extends StatefulWidget {
  const mobileBody({super.key});

  @override
  State<mobileBody> createState() => _mobileBodyState();
}

class _mobileBodyState extends State<mobileBody> {
  late User? _user;
  int _currentIndex = 0;

  final List<Widget> _pages = [
    CambiarPass(),
    CorreosProfesores(),
    ValidarHorario(),
    // otras paginas
  ];

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        _user = user;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar,
      backgroundColor: Theme.of(context).colorScheme.background,
      body: _currentIndex == 0
          ? SizedBox(
              height: 80,
              child: GreetingWidget,
            )
          : _pages[_currentIndex - 1],
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SvgPicture.asset(
              'images/TecNM_logo.svg',
              width: 50,
              height: 50,
            ),
            UserAccountsDrawerHeader(
              accountEmail: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData && snapshot.data!.email != null) {
                    return Text(snapshot.data!.email!);
                  } else {
                    return GestureDetector(
                      onTap: () {
                        //Get.offAll(() => LoginPage());
                      },
                    );
                  }
                },
              ),
              accountName: StreamBuilder<User?>(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                  if (snapshot.hasData && snapshot.data!.displayName != null) {
                    return Text(
                      snapshot.data!.displayName!,
                      style: TextStyle(fontSize: 22.0),
                    );
                  } else {
                    return Text(
                      'Estudiante',
                      style: TextStyle(fontSize: 20.0),
                    );
                  }
                },
              ),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 27, 58, 133),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.assignment_ind_sharp),
              title: const Text(
                'Credencial',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 1;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text(
                'Biblioteca Digital',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 2;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.email_outlined),
              title: const Text(
                'Correos Profesores',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 3;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.question_circle),
              title: const Text(
                'Consultas',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 4;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.person),
              title: const Text(
                'Mis datos personales',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 5;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.check_mark_circled),
              title: const Text(
                'Validar horario',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 6;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.monetization_on_outlined),
              title: const Text(
                'Recursos financieros',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 7;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(CupertinoIcons.person_3),
              title: const Text(
                'Comite Academico',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 8;
                });
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: const Icon(Icons.lock_person_outlined),
              title: const Text(
                'Cambiar password',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                setState(() {
                  _currentIndex = 9;
                });
                Navigator.of(context).pop();
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Divider(),
            ),
            ListTile(
              leading: const Icon(Icons.logout_outlined),
              title: const Text(
                'Salir',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () async {
                try {
                  await Auth.signUserOut(context);
                  Get.to(() => LoginPage());
                } catch (e) {}
              },
            ),
            SwitchListTile(
              title: const Text(
                'Tema',
                style: TextStyle(fontSize: 17.0),
              ),
              secondary: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
                  return Icon(
                    themeProvider.isLightMode
                        ? Icons.wb_sunny
                        : Icons.nights_stay,
                  );
                },
              ),
              value: Provider.of<ThemeProvider>(context).isLightMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
          ],
        ),
      ),
      drawerScrimColor: Colors.transparent,
    );
  }
}
