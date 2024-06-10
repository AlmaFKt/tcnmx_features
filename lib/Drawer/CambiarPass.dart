import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';

class CambiarPass extends StatefulWidget {
  const CambiarPass({super.key});

  @override
  State<CambiarPass> createState() => _CambiarPassState();
}

class _CambiarPassState extends State<CambiarPass> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cambiar contraseña'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 28, right: 28, bottom: 80),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: _oldPasswordController,
                      decoration:
                          InputDecoration(labelText: 'Contraseña antigua'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu contraseña antigua';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: _newPasswordController,
                      decoration:
                          InputDecoration(labelText: 'Nueva contraseña'),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor ingresa tu nueva contraseña';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: _confirmPasswordController,
                      decoration: InputDecoration(
                          labelText: 'Confirma tu nueva contraseña'),
                      obscureText: true,
                      validator: (value) {
                        if (value != _newPasswordController.text) {
                          return 'Las contraseñas no coinciden';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 18),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            User user = FirebaseAuth.instance.currentUser!;
                            AuthCredential credential =
                                EmailAuthProvider.credential(
                              email: user.email!,
                              password: _oldPasswordController.text,
                            );

                            // Reauthenticate
                            await user.reauthenticateWithCredential(credential);

                            // Update password
                            await user
                                .updatePassword(_newPasswordController.text);

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Éxito'),
                                  content: Text('Contraseña actualizada'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          } catch (e) {
                            String errorMessage;
                            if (e is FirebaseAuthException) {
                              switch (e.code) {
                                case 'wrong-password':
                                  errorMessage =
                                      'La contraseña antigua es incorrecta.';
                                  break;
                                case 'weak-password':
                                  errorMessage =
                                      'La nueva contraseña es demasiado débil.';
                                  break;
                                default:
                                  errorMessage =
                                      'Ocurrió un error al actualizar la contraseña.';
                              }
                            } else {
                              errorMessage = 'Ocurrió un error inesperado.';
                            }

                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text(errorMessage),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('OK'),
                                      onPressed: () {
                                        Get.to(() => mobileBody());
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        }
                      },
                      child: Text(
                        'Cambiar contraseña',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
