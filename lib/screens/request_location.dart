import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:sip_rusak/services/main_navigation.dart';
import '../services/location_service.dart';
import 'package:geocoding/geocoding.dart';

class RequestLocationPage extends StatefulWidget {
  const RequestLocationPage({super.key});

  @override
  State<RequestLocationPage> createState() => _RequestLocationPageState();
}

class _RequestLocationPageState extends State<RequestLocationPage> {
  String locationText = "Membutuhkan lokasi anda..";
  bool isLoading = true;
  IconData? statusIcon;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    setState(() {
      locationText = "Memeriksa izin lokasi...";
      isLoading = true;
      statusIcon = null;
    });

    try {
      final Position position = await determinePosition();

      // Proses reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      final Placemark place = placemarks.first;

      setState(() {
        locationText =
            "Lokasi berhasil diperoleh:\n${place.country}, ${place.administrativeArea}, ${place.locality}";
        isLoading = false;
        statusIcon = Icons.check_circle_outline;
      });

      await Future.delayed(const Duration(seconds: 2));
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder:
              (context, animation, secondaryAnimation) => MainNavigation(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    } catch (e) {
      setState(() {
        locationText = "Terjadi kesalahan: $e";
        isLoading = false;
        statusIcon = Icons.error_outline;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isLoading
                    ? Lottie.asset(
                      'assets/animation/animation1.json',
                      height: 200,
                    )
                    : Icon(
                      statusIcon,
                      size: 64,
                      color:
                          statusIcon == Icons.check_circle_outline
                              ? Colors.green
                              : Colors.red,
                    ),
                const SizedBox(height: 24),
                Text(
                  locationText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
