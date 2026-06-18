import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:onebite_user_app/constants/app_colors.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  LatLng _pickedLocation = const LatLng(33.6844, 73.0479);
  bool _isLoadingAddress = false;

  Future<void> _confirmLocation() async {
    setState(() => _isLoadingAddress = true);

    String address = "";
    try {
      final placemarks = await placemarkFromCoordinates(
        _pickedLocation.latitude,
        _pickedLocation.longitude,
      );

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        address = [
          place.street,
          place.subLocality,
          place.locality,
        ].where((e) => e != null && e.isNotEmpty).join(", ");
      }
    } catch (e) {
      address = "";
    }

    if (!mounted) return;

    Navigator.pop(context, {
      "location": _pickedLocation,
      "address": address,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Select Delivery Location")),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: _pickedLocation,
              zoom: 15,
            ),
            onCameraMove: (position) {
              _pickedLocation = position.target;
            },
          ),
          const Center(
            child: Icon(
              Icons.location_pin,
              size: 48,
              color: Colors.red,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 52,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _isLoadingAddress ? null : _confirmLocation,
            child: _isLoadingAddress
                ? const CircularProgressIndicator(color: Colors.white)
                : const Text(
              "Confirm Location",
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}