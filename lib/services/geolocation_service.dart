import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  static Future<Position> getCurrentPosition() async {
    final permission = await Geolocator.checkPermission();

    final blocked = permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever;

    if (blocked) {
      return Future.error(
          'Location permissions are denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
