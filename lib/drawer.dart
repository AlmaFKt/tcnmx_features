import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class myDrawer extends StatefulWidget {
  const myDrawer({super.key});
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  State<myDrawer> createState() => _myDrawerState();
}

class _myDrawerState extends State<myDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Color.fromARGB(217, 251, 251, 251),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          //Header 
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

            //To show the user's name in the drawer header
            accountName: StreamBuilder<User?>(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
                if (snapshot.hasData && snapshot.data!.displayName != null) {
                  //user's display name 
                  return Text(snapshot.data!.displayName!,
                      style: TextStyle(fontSize: 22.0));
                } else {
                  return Text(
                    'Estudiante', // Default or fallback name
                    style: TextStyle(fontSize: 20.0),
                  );
                }
              },
            ),
            decoration: BoxDecoration(
              color: Color.fromARGB(219, 46, 100, 226),
            ),
          ),

          //HOME BUTTON
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

          //Search BUTTON 
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

          //DIVIDER
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
                  // Sign out the user
                 // signUserOut();
                  // Navigate to the login screen
                  Get.offAll(() => ());
                } catch (e) {
                  // Error message
                  String errorMessage =
                      'An error occurred while signing out. Please try again.';

                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Error'),
                        content: Text(errorMessage),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop(); // Close the dialog
                            },
                            child: Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
        ],
      ),
    );
  }
}