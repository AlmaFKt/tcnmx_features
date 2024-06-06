import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../components/mi_textfield.dart';

class ForgotPwPage extends StatefulWidget {
  const ForgotPwPage({Key? key}) : super(key: key);

  @override
  State<ForgotPwPage> createState() => _ForgotPwPageState();
}

class _ForgotPwPageState extends State<ForgotPwPage> {
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future pwReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text.trim());
      // Always show a success message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'If the email is registered, a password reset email has been sent to ${emailController.text.trim()}'),
          );
        },
      );
    } catch (e) {
      // Show a dialog with the error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Error: ${e.toString()}'),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 52, 105, 179),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                    ],
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  Text(
                    'INSTITUTO TECNOLÓGICO DE ZACATEPEC',
                    style: GoogleFonts.montserrat(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Esta opción es solo para estudiantes, el personal dirigirse a recursos humanos.',
                style: GoogleFonts.heebo(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Text(
                'Te llegará un correo para restablecer tu contraseña.',
                style: GoogleFonts.heebo(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(
              height: 25,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),
            ),

            const SizedBox(
              height: 30,
            ),

            const SizedBox(
              height: 30,
            ),

            MaterialButton(
              onPressed: pwReset,
              child: Text('Proceder',
              style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
              color: Color.fromARGB(255, 52, 105, 179),
            ),
          ],
        ),
      ),
    );
  }
}
