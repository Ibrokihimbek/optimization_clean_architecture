import "package:geolocator/geolocator.dart" as geo;
import "package:location/location.dart";
export "package:location/location.dart";

const (double, double) point = (41.2995, 69.2401);

abstract class LocationService {
  Future<PermissionStatus> hasPermission();

  Future<bool> isRequestService();

  Future<bool> openAppSettings();

  Future<bool> openLocationSettings();

  Future<geo.Position> currentPosition();

  Future<(double, double)> determinePosition();
}

class LocationServiceImpl implements LocationService {
  LocationServiceImpl({required this.location});

  final Location location;

  @override
  Future<PermissionStatus> hasPermission() async {
    late PermissionStatus permissionGranted;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied ||
        permissionGranted == PermissionStatus.deniedForever) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.denied ||
          permissionGranted != PermissionStatus.deniedForever) {
        return permissionGranted;
      }
    }

    late geo.LocationPermission permission;

    permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied ||
        permission == geo.LocationPermission.deniedForever) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied ||
          permission == geo.LocationPermission.deniedForever) {
        return permission == geo.LocationPermission.deniedForever
            ? PermissionStatus.deniedForever
            : PermissionStatus.denied;
      }
    }

    if (permission == geo.LocationPermission.deniedForever ||
        permission == geo.LocationPermission.denied) {
      return permission == geo.LocationPermission.deniedForever
          ? PermissionStatus.deniedForever
          : PermissionStatus.denied;
    }

    return permissionGranted;
  }

  @override
  Future<bool> isRequestService() async {
    if (!(await location.serviceEnabled())) {
      final bool locationEnabled = await location.requestService();
      return locationEnabled;
    }
    return true;
  }

  @override
  Future<bool> openLocationSettings() async =>
      geo.Geolocator.openLocationSettings();

  @override
  Future<bool> openAppSettings() async => geo.Geolocator.openAppSettings();

  @override
  Future<(double, double)> determinePosition() async {
    final geo.Position position = await geo.Geolocator.getCurrentPosition();
    return (position.latitude, position.longitude);
  }

  @override
  Future<geo.Position> currentPosition() async {
    final geo.Position position = await geo.Geolocator.getCurrentPosition();
    return position;
  }
}
