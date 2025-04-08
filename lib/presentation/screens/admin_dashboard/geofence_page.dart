import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance_system/core/services/attendance_service.dart';
import 'package:gps_attendance_system/l10n/l10n.dart';
import 'package:gps_attendance_system/presentation/widgets/snakbar_widget.dart';

class GeofencePage extends StatefulWidget {
  const GeofencePage({super.key});

  @override
  State<GeofencePage> createState() => _GeofencePageState();
}

class _GeofencePageState extends State<GeofencePage> {
  GoogleMapController? _googleMapController;
  bool mapTapped = false;
  Set<Circle> _circle = {};
  LatLng? _companyLocation;

  // Get company location
  Future<void> _fetchCompanyLocation() async {
    try {
      final docSnapshot = await AttendanceService.fetchCompanyLocation();
      if (docSnapshot.exists) {
        final data = docSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _companyLocation = LatLng(
            data['latitude'] as double,
            data['longitude'] as double,
          );
          print('company location coordinates: $_companyLocation');
        });
      } else {
        setState(() {
          _companyLocation = LatLng(30.0447, 31.2389);
        });
      }
    } catch (e) {
      print('Error getting company location: $e');
    }
  }

  @override
  void initState() {
    _fetchCompanyLocation();
    super.initState();
  }

  void _updateCircle(LatLng newLocation) {
    setState(() {
      _circle = {
        Circle(
          circleId: const CircleId('value'),
          center: newLocation,
          radius: 100,
          strokeWidth: 2,
          strokeColor: Colors.blue,
          fillColor: Colors.blue.withValues(alpha: 0.3),
        ),
      };
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _googleMapController = controller;
  }

  void _onMapTap(LatLng loc) {
    setState(() {
      _companyLocation = loc;
      mapTapped = true;
      _updateCircle(loc);
    });
  }

  Future<void> _saveLocation() async {
    await AttendanceService.updateCompanyLocation(
      _companyLocation!.latitude,
      _companyLocation!.longitude,
    );
    CustomSnackBar.show(
      context,
      AppLocalizations.of(context).geofenceChangedSuccessfully,
      color: chooseSnackBarColor(ToastStates.SUCCESS),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).geofence),
      ),
      body: Stack(
        children: [
          if (_companyLocation == null)
            const Center(child: CircularProgressIndicator())
          else
            GoogleMap(
              onMapCreated: _onMapCreated,
              onTap: _onMapTap,
              zoomControlsEnabled: false,
              initialCameraPosition: CameraPosition(
                target: _companyLocation ?? LatLng(30.0447, 31.2389),
                zoom: 15,
              ),
              markers: {
                Marker(
                  infoWindow: const InfoWindow(title: 'Your Company'),
                  markerId: const MarkerId('Your Company'),
                  position: _companyLocation ?? const LatLng(30.0447, 31.2389),
                ),
              },
              circles: _circle,
            ),
          if (mapTapped)
            Positioned(
              bottom: 20,
              left: 20,
              child: ElevatedButton(
                onPressed: _saveLocation,
                child: Text(AppLocalizations.of(context).changeLoc),
              ),
            ),
        ],
      ),
    );
  }
}
