import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';
import '../components/mi_boton.dart';
import '../components/mi_textfield.dart';
import '../theme/theme_provider.dart';
import 'olvidaste_contraseña.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //Text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //sign user in method event
  void signUserIn() async {
    // Validate email and password
    if (emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty) {
      // Empty email or password
      showErrorDialog('Please enter both email and password.');
      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      // Close the loading indicator
      Navigator.pop(context);

      // Navigate to the home page
      Get.to(() => mobileBody());
    } on FirebaseAuthException catch (e) {
      // Close the loading indicator
      Navigator.pop(context);

      // Handle specific authentication errors
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showErrorDialog('Incorrect Email or Password');
      } else {
        // Handle other authentication errors
        showErrorDialog('Incorrect Email or Password');
      }
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(errorMessage),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null, // Set the appBar property to null
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(children: [
            Center(
              child: Column(children: [
                const SizedBox(height: 60),

                //Logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/TecNM_logo.svg',
                      width: 80,
                      height: 80,
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                //PlodCat (logo) text
                Text('INSTITUTO TECNOLÓGICO DE ZACATEPEC',
                    style: GoogleFonts.montserrat(fontSize: 18)),

                const SizedBox(
                  height: 40,
                ),

                //(Welcome!) text
                Text('Ingresa tu usuario',
                    style: GoogleFonts.heebo(fontSize: 20)),

                const SizedBox(
                  height: 20,
                ), // this makes a type of space betweeno your objects

                //username textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Usuario',
                  obscureText: false,
                ), // u can find the code for this object in components

                const SizedBox(
                  height: 12,
                  width: 20,
                ),

                //password textfield
                MyTextField(
                  controller: passwordController,
                  hintText: 'Contraseña',
                  obscureText: true,
                ),

                const SizedBox(
                  height: 12,
                  width: 20,
                ),

                //forgot password TEXT (In a row)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(ForgotPwPage());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          '¿Olvidaste tu contraseña?',
                          style: TextStyle(
                              color: Color.fromARGB(255, 81, 122, 180)),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(
                  height: 32,
                ),

//divididor
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0),
                  child: Divider(
                    color: Color.fromARGB(
                        121, 0, 0, 128), // Replace with your desired color
                  ),
                ),

                Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 30,
                    ),

                    //Boton de Ingresar
                    MyButton(
                      text: 'Ingresar',
                      onTap: () {
                        signUserIn();
                      },
                    ),

                    const SizedBox(
                      height: 30,
                    ),

                    // Boton toggle de tema
                    Consumer<ThemeProvider>(
                      builder: (context, themeProvider, child) {
                        return IconButton(
                          icon: Icon(
                            themeProvider.isLightMode
                                ? Icons.wb_sunny
                                : Icons.nights_stay,
                          ),
                          onPressed: () {
                            // Tema toggle
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          },
                        );
                      },
                    ),
                  ],
                ),
              ]),
            )
          ]),
        ),
      ),
    );
  }
}
