import 'digimon_model.dart';
import 'package:flutter/material.dart';


class AddDigimonFormPage extends StatefulWidget {
  const AddDigimonFormPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddDigimonFormPageState createState() => _AddDigimonFormPageState();
}

class _AddDigimonFormPageState extends State<AddDigimonFormPage> {
  TextEditingController nameController = TextEditingController();

  void submitPilot(BuildContext context) { 
  if (nameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.redAccent,
        content: Text('You forgot to insert the digimon name'),
      ));
    } else {
      String formattedForWiki = nameController.text.trim().replaceAll(' ', '_');
      var newDigimon = Digimon(formattedForWiki);
      Navigator.of(context).pop(newDigimon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A1A), 
      appBar: AppBar(
        title: const Text('Añadir nuevo piloto', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFFD32F2F),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: const Color(0xFF1A1A1A),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextField(
                controller: nameController,
                style: const TextStyle(color: Colors.white, fontSize: 18),
                //onChanged: (v) => nameController.text = v,
                decoration: const InputDecoration(
                  labelText: 'Nombre del Piloto (Wikipedia)',
                  labelStyle: const TextStyle(color: Colors.grey),
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFFD32F2F)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD32F2F),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () => submitPilot(context),
                  child: const Text(
                    'GUARDAR PILOTO',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
            
          ]),
        ),
      ),
    );
  }
}
