import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tecnamex_features/responsive/mobile_body.dart';

class ValidarHorario extends StatefulWidget {
  const ValidarHorario({super.key});

  @override
  State<ValidarHorario> createState() => _ValidarHorarioState();
}

class _ValidarHorarioState extends State<ValidarHorario> {
  bool horarioValidado = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Validar Horario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check,
                color: Theme.of(context)
                    .colorScheme
                    .tertiary,
                    size: 40), 
            SizedBox(
                height: 10), 
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).colorScheme.shadow),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text(
                          horarioValidado
                              ? 'Horario validado'
                              : 'No se pudo validar el horario',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.tertiary)),
                      actions: <Widget>[
                        TextButton(
                          child: Text('OK',
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                          onPressed: () {
                            Navigator.of(context)
                                .pop(); 
                            if (horarioValidado) {
                              Get.to(mobileBody()); 
                            }
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text(
                'Validar',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
