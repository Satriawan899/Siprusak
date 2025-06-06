import 'package:geolocator/geolocator.dart';

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    throw Exception('Layanan lokasi tidak aktif');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      throw Exception('Izin lokasi ditolak');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    throw Exception('Izin lokasi ditolak secara permanen');
  }

  return await Geolocator.getCurrentPosition();
}
