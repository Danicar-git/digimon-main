import 'package:flutter/material.dart';
import 'digimon_model.dart';
import 'dart:async';


class DigimonDetailPage extends StatefulWidget {
  final Digimon digimon;
  const DigimonDetailPage(this.digimon, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _DigimonDetailPageState createState() => _DigimonDetailPageState();
}

class _DigimonDetailPageState extends State<DigimonDetailPage> {
  final double digimonAvarterSize = 150.0;
  double _sliderValue = 10.0;

  Widget get addYourRating {
    return Column(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                flex: 1,
                child: Slider(
                  activeColor: const Color(0xFFD32F2F),
                  inactiveColor: Colors.grey[800],
                  min: 0.0,
                  max: 10.0,
                  value: _sliderValue,
                  onChanged: (newRating) {
                    setState(() {
                      _sliderValue = newRating;
                    });
                  },
                ),
              ),
              Container(
                  width: 50.0,
                  alignment: Alignment.center,
                  child: Text(
                    '${_sliderValue.toInt()}',
                    style: const TextStyle(color: Colors.white, fontSize: 25.0, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
        submitRatingButton,
      ],
    );
  }

  void updateRating() {
    if (_sliderValue < 5) {
      _ratingErrorDialog();
    } else {
      setState(() {
        widget.digimon.rating = _sliderValue.toInt();
      });
    }
  }

  Future<void> _ratingErrorDialog() async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error!'),
            content: const Text("Come on! They're good!"),
            actions: <Widget>[
              TextButton(
                child: const Text('Try Again'),
                onPressed: () => Navigator.of(context).pop(),
              )
            ],
          );
        });
  }

  Widget get submitRatingButton {
    return ElevatedButton(
      onPressed: () => updateRating(),
      child: const Text('Submit'),
    );
  }

  Widget get digimonImage {
    return Hero(
      tag: widget.digimon,
      child: Container(
        height: digimonAvarterSize,
        width: digimonAvarterSize,
        constraints: const BoxConstraints(),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFD32F2F), width: 4.0),
            boxShadow: [
              // ignore: deprecated_member_use
              BoxShadow(color: const Color(0xFFD32F2F).withOpacity(0.8), blurRadius: 20, spreadRadius: -5),
            ],
            image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(widget.digimon.imageUrl ?? ""))),
      ),
    );
  }

  Widget get rating {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // Estrella dorada y texto blanco grande
        const Icon(Icons.star, size: 40.0, color: Color(0xFFFFD700)),
        Text('${widget.digimon.rating}/10', 
        style: const TextStyle(color: Colors.white, fontSize: 30.0, fontWeight: FontWeight.bold))
      ],
    );
  }

  Widget get digimonProfile {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      decoration: const BoxDecoration(
        color: Color(0xFF37474F),
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          digimonImage,
          const SizedBox(height: 15),
          Text(widget.digimon.formattedName, style: const TextStyle(color: Colors.white, fontSize: 32.0, fontWeight: FontWeight.bold)),
          Text('${widget.digimon.levelDigimon}', style: const TextStyle(color: Colors.grey, fontSize: 20.0, fontStyle: FontStyle.italic)),
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: rating,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet ${widget.digimon.name}'),
      ),
      body: ListView(
        children: <Widget>[digimonProfile, addYourRating],
      ),
    );
  }
}
