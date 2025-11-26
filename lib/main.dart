import 'package:flutter/material.dart';
import 'dart:async';
import 'digimon_model.dart';
import 'digimon_list.dart';
import 'new_digimon_form.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Color racingRed = Color(0xFFD32F2F);
    const Color asphaltBlack = Color(0xFF1A1A1A);
    
    return MaterialApp(
      title: 'MotoGP Pilots',
      theme: ThemeData.dark().copyWith(
        primaryColor: racingRed,
        scaffoldBackgroundColor: asphaltBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: racingRed,
          centerTitle: true,
          elevation: 10,
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: racingRed,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(fontWeight: FontWeight.bold)
          )
        ),
          colorScheme: ColorScheme.fromSwatch().copyWith(secondary: racingRed)
      ),
      home: const MyHomePage(
        title: 'MotoGP Pilots',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage({super.key, required this.title});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {//añadir pilotos según la referencia de la API de la wikipedia
  List<Digimon> initialDigimons = [
  Digimon('Marc_Marquez'), 
  Digimon('Álex_Márquez'), 
  Digimon('Enea_Bastianini'),
  Digimon('Francesco_Bagnaia'),
  Digimon('Joan_Mir'),
  Digimon('Jorge_Martín'),
  Digimon('Fabio_Di_Giannantonio'),
  Digimon('Jack_Miller_(motociclista)'),
  Digimon('Brad_Binder'),
  Digimon('Miguel_Oliveira'),
  Digimon('Luca_Marini'),
  Digimon('Aleix_Espargaro'),
  Digimon('Johann_Zarco'),
  Digimon('Pedro_Acosta_(motociclista)'),
  Digimon('Fabio_Quartararo')
];
  Future _showNewPilot() async {
    Digimon newDigimon = await Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
      return const AddDigimonFormPage();
    }));
    //print(newDigimon);
    initialDigimons.add(newDigimon);
      setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var key = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _showNewPilot,
          ),
        ],
      ),
      body: Container(
          child: Center(
            child: DigimonList(initialDigimons),
          )),
    );
  }
}
