import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:tecnamex_features/loguear/inicio_sesion.dart';
import 'theme/theme_provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();

  // Define the signUserOut method as a static method
  static Future<void> signUserOut(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
  }
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.primary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //Logo TecNM
          SvgPicture.asset(
            'images/TecNM_logo.svg',
            width: 50,
            height: 50,
          ),

          //Cabecera del Drawer
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

            //Para mostrar el nombre del usuario
            accountName: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasData && snapshot.data!.displayName != null) {
                  //user's display name
                  return Text(snapshot.data!.displayName!,
                      style: TextStyle(fontSize: 22.0));
                } else {
                  return Text(
                    'Estudiante', // Predeterminado
                    style: TextStyle(fontSize: 20.0),
                  );
                }
              },
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 27, 58, 133),
            ),
          ),

          //Credencial BUTTON
          ListTile(
            leading: const Icon(Icons.assignment_ind_sharp),
            title: const Text(
              'Credencial',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll( HomePage());
            },
          ),

          //Biblioteca BUTTON
          ListTile(
              leading: const Icon(Icons.menu_book),
              title: const Text(
                'Biblioteca Digital',
                style: TextStyle(fontSize: 17.0),
              ),
              onTap: () {
                //Get.offAll( HomePage());
              }),

          ListTile(
            leading: const Icon(Icons.email_outlined),
            title: const Text(
              'Correos Profesores',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(CupertinoIcons.question_circle),
            title: const Text(
              'Consultas',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(CupertinoIcons.person),
            title: const Text(
              'Mis datos personales',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(CupertinoIcons.check_mark_circled),
            title: const Text(
              'Validar horario',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.monetization_on_outlined),
            title: const Text(
              'Recursos financieros',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(CupertinoIcons.person_3),
            title: const Text(
              'Comite Academico',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          ListTile(
            leading: const Icon(Icons.lock_person_outlined),
            title: const Text(
              'Cambiar password',
              style: TextStyle(fontSize: 17.0),
            ),
            onTap: () {
              //Get.offAll(HomePage());
            },
          ),

          //DIVIDOR
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
                // Call the signUserOut method using the class name
                await MyDrawer.signUserOut(context);
                // Navigate to the login screen
                Get.offAll(() => LoginPage());
              } catch (e) {
                // Error handling code...
              }
            },
          ),

//Boton switch para cambiar el tema
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
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
    );
  }
}
