import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


class Numeros extends StatefulWidget {
  @override
  _NumerosState createState() => _NumerosState();
}

class _NumerosState extends State<Numeros> {
  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _executa(String nomeAudio) {
    _audioCache.play(nomeAudio + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "1.mp3",
      "2.mp3",
      "3.mp3",
      "4.mp3",
      "5.mp3",
      "6.mp3"
    ]);
  }

  @override
  Widget build(BuildContext context) {
    double largura =
        MediaQuery.of(context).size.width; // largura do dispositivo
    double altura = MediaQuery.of(context).size.height; // altura do dispositivo

    return GridView.count(
      //quantidade de colunas ou linhas
      crossAxisCount: 2,
      childAspectRatio: MediaQuery.of(context).size.aspectRatio * 2,
      // calcula automaticamente o tamanho da tela do disposistivo
      scrollDirection: Axis.vertical,
      children: <Widget>[
        GestureDetector(
          onTap: () {
            _executa("1");
          },
          child: Image.asset("assets/image/1.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("2");
          },
          child: Image.asset("assets/image/2.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("3");
          },
          child: Image.asset("assets/image/3.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("4");
          },
          child: Image.asset("assets/image/4.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("5");
          },
          child: Image.asset("assets/image/5.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("6");
          },
          child: Image.asset("assets/image/6.png"),
        ),
      ],
    );
  }
}