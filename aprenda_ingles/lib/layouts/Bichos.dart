import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Bichos extends StatefulWidget {
  @override
  _BichosState createState() => _BichosState();
}

class _BichosState extends State<Bichos> {
  AudioCache _audioCache = AudioCache(prefix: "audios/");

  _executa(String nomeAudio) {
    _audioCache.play(nomeAudio + ".mp3");
  }

  @override
  void initState() {
    super.initState();
    _audioCache.loadAll([
      "cao.mp3",
      "gato.mp3",
      "leao.mp3",
      "macaco.mp3",
      "ovelha.mp3",
      "vaca.mp3"
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
            _executa("cao");
          },
          child: Image.asset("assets/image/cao.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("gato");
          },
          child: Image.asset("assets/image/gato.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("leao");
          },
          child: Image.asset("assets/image/leao.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("macaco");
          },
          child: Image.asset("assets/image/macaco.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("ovelha");
          },
          child: Image.asset("assets/image/ovelha.png"),
        ),
        GestureDetector(
          onTap: () {
            _executa("vaca");
          },
          child: Image.asset("assets/image/vaca.png"),
        ),
      ],
    );
  }
}
