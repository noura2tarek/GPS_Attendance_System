import 'package:geolocator/geolocator.dart';

const double greekCampusLat = 30.0444;
const double greekCampusLng = 31.2357;
const double geofenceRadius = 100;

Future<bool> isWithinGeofence(Position position) async {
  double distance = Geolocator.distanceBetween(
    position.latitude,
    position.longitude,
    greekCampusLat,
    greekCampusLng,
  );

  return distance <= geofenceRadius;
}
