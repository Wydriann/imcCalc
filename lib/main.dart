import 'package:flutter/material.dart';

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

    String infoTexto = "Informe seus dados";

    TextEditingController weightController = TextEditingController();
    TextEditingController heightController = TextEditingController();

    Widget buildTextField(String label, TextEditingController controller) {
      return TextField( 
              decoration: InputDecoration(
                labelText: label, labelStyle: TextStyle(color: Colors.blue, fontSize: 20.0),
                border:  OutlineInputBorder(),
              ),
              style: TextStyle(color: Colors.black, fontSize: 25.0),
              keyboardType: TextInputType.number,
              controller: controller,
            );
    }

    void _resetFields(){
      setState(() {  
      weightController.text = "";
      heightController.text = "";
      infoTexto = "Informe seus dados";
      });
    } // Reseta os dados calculados

    void _calculate(){
      double weight = double.parse(weightController.text); // transforma a String em Double
      double height = double.parse(heightController.text) / 100; //Stransforma em Double e em cm pra calcular melhor
      double imc = weight / (height * height);
      setState(() {       
      if (imc < 17) {
        infoTexto = "Muito Abaixo do Peso \n IMC: ${imc.toStringAsPrecision(4)})";
      } else if (imc >= 17 && imc <= 18.49) {
        infoTexto = "Abaixo do peso \n IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 18.5 && imc <= 24.99) {
        infoTexto = "Peso Ideial \n IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 25 && imc <= 29.99) {
        infoTexto = "Acima do Peso \n IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 30 && imc <= 34.99) {
        infoTexto = "Obesidade I \n IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc >= 35 && imc <= 39.99) {
        infoTexto = "Obesidade II (Severa) \n IMC: ${imc.toStringAsPrecision(4)}";
      } else if (imc > 40) {
        infoTexto = "Obesidade III (Mórbida) \n IMC: ${imc.toStringAsPrecision(4)}";
      }
      },
      );
        // Calcula a lógica do imc e retorna o resultado dizendo o estado
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh),
             onPressed: () {_resetFields();},
             ),
          ],
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
              Icon(Icons.person_outline, size: 170.0, color: Colors.black,),
              buildTextField("Peso (Kg)", weightController),
              Divider(),
              buildTextField("Altura (cm)", heightController),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    child: Text("Verificar", style: TextStyle(color: Colors.white, fontSize: 25.0),),
                    onPressed: (){
                      _calculate();
                    },
                    color: Colors.blueGrey,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(infoTexto, style: TextStyle(color: Colors.blue, fontSize: 25.0),
                textAlign: TextAlign.center,),
              )
            ],
           ),
        ),

      );
    }
  }