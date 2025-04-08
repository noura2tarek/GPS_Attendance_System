import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gps_attendance_system/core/services/attendance_service.dart';

class CompanyLocation extends StatefulWidget {
  const CompanyLocation({super.key});

  @override
  State<CompanyLocation> createState() => _CompanyLocationState();
}

class _CompanyLocationState extends State<CompanyLocation> {
  LatLng? _companyLocation;

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
        });
      } else {
        setState(() {
          _companyLocation = LatLng(30.0447, 31.2389);
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCompanyLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          child: _companyLocation == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _companyLocation!,
                    zoom: 14,
                  ),
                  markers: {
                    Marker(
                      infoWindow: const InfoWindow(title: 'Company'),
                      markerId: const MarkerId('Company'),
                      position: _companyLocation!,
                    ),
                  },
                  zoomControlsEnabled: false,
                ),
        ),
      ),
    );
  }
}
