import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatelessWidget {
  static const routeName = '/map';
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final accessibleRoute = Polyline(
      polylineId: const PolylineId('accessible'),
      width: 6,
      color: Colors.indigo,
      points: const [
        LatLng(37.42796133580664, -122.085749655962),
        LatLng(37.4285, -122.0862),
        LatLng(37.4290, -122.0857),
      ],
    );

    final entrances = <Marker>{
      const Marker(
        markerId: MarkerId('entrance1'),
        position: LatLng(37.4280, -122.0859),
        infoWindow: InfoWindow(title: 'Accessible Entrance A'),
      ),
      const Marker(
        markerId: MarkerId('entrance2'),
        position: LatLng(37.4292, -122.0855),
        infoWindow: InfoWindow(title: 'Ramp Entrance B'),
      ),
    };

    return Scaffold(
      appBar: AppBar(title: const Text('Campus Map')),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: GoogleMap(
                  initialCameraPosition: const CameraPosition(
                    target: LatLng(37.42796133580664, -122.085749655962),
                    zoom: 16,
                  ),
                  polylines: {accessibleRoute},
                  markers: entrances,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.directions),
                  label: const Text('Get Directions'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52)),
                )),
                const SizedBox(width: 12),
                Expanded(
                    child: ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.accessible),
                  label: const Text('Accessible Routes'),
                  style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(52)),
                )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
