import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderMapWidget extends StatelessWidget {
  final double deliveryLat;
  final double deliveryLng;

  const OrderMapWidget({
    super.key,
    required this.deliveryLat,
    required this.deliveryLng,
  });

  @override
  Widget build(BuildContext context) {
    final deliveryLocation = LatLng(deliveryLat, deliveryLng);

    return SizedBox(
      height: 220,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: deliveryLocation,
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("delivery"),
              position: deliveryLocation,
              infoWindow: const InfoWindow(title: "Delivery Address"),
            ),
          },
          zoomControlsEnabled: false,
          myLocationButtonEnabled: false,
        ),
      ),
    );
  }
}
