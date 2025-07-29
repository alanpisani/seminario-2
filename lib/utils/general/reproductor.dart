import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:audioplayers/audioplayers.dart';

class Reproductor {
  static final Reproductor _instancia = Reproductor._interna();
  late AudioPlayer _player;

  Reproductor._interna() {
    _player = AudioPlayer();
  }

  factory Reproductor() => _instancia;

  Future<void> _reproduciendo(String rutaSonido, {bool loop = false}) async {
    await _player.stop();
    final mp3 = await rootBundle.load('assets/$rutaSonido');
    final carpetaTemporal = await getTemporaryDirectory();
    final archivoTemporal = File('${carpetaTemporal.path}/$rutaSonido');
    await archivoTemporal.create(recursive: true);
    await archivoTemporal.writeAsBytes(mp3.buffer.asUint8List());
    await _player.setReleaseMode(loop ? ReleaseMode.loop : ReleaseMode.stop);
    await _player.setVolume(1.0);
    await _player.play(DeviceFileSource(archivoTemporal.path));
  }

  Future<void> reproducirSonido(String rutaSonido) async {
    await _reproduciendo(rutaSonido);
  }

  Future<void> reproducirSonidoEnLoop(String rutaSonido) async {
    await _reproduciendo(rutaSonido, loop: true);
  }

  Future<void> detener() async {
    await _player.stop();
  }

}
