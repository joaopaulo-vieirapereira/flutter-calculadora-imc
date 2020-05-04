import 'package:flutter/material.dart';

// Função principal
void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weigthController = TextEditingController();
  TextEditingController heigthController = TextEditingController();
  String _infoText = ("Informe seus dados!");

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _resetFilds() {
    weigthController.text = "";
    heigthController.text = "";
    setState(() {
      _infoText = ("Informe seus dados!");
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weigth = double.parse(weigthController.text);
      double heigth = double.parse(heigthController.text) / 100;
      double imc = weigth / (heigth * heigth); //Formular IMC: Altura * Peso²
      print(imc);
      if (imc < 17) {
        _infoText =
            "Muito abaixo do Peso! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 17 && imc <= 18.49) {
        _infoText = "Abaixo do peso! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.5 && imc <= 29.99) {
        _infoText = "Peso normal! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc <= 29.99) {
        _infoText = "Acima do peso! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc <= 34.99) {
        _infoText = "Obesidade I! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc <= 39.99) {
        _infoText =
            "Obesidade II - Severa! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 40) {
        _infoText =
            "Obesidade III - Mórbida! \n Seu IMC: ${imc.toStringAsPrecision(4)}";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Logo App - Nome da Drawer '),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Item 3'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                  //Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: false,
          backgroundColor: Colors.blue,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFilds,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.person,
                    size: 140.0,
                    color: Colors.blue,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Peso (Kg)",
                        labelStyle:
                            TextStyle(color: Colors.blue, fontSize: 23.0)),
                    controller: weigthController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira seu Peso!";
                      }
                    },
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Altura (Cm)",
                        labelStyle:
                            TextStyle(color: Colors.blue, fontSize: 23.0)),
                    controller: heigthController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Insira sua altura!";
                      }
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                    child: Container(
                      height: 50.0,
                      child: RaisedButton(
                        onPressed: () {
                          if (_formKey.currentState.validate()) {
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  ),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.blue, fontSize: 22.0))
                ],
              ),
            )));
  }
}
