import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorService {
  Future<Map<String, String>> getCurrentLocation() async {
    Map<String, String> locationData = {};

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationData['error'] = 'Location services are disabled.';
      return locationData;
    }

    // Check for location permissions
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        locationData['error'] = 'Location permissions are denied';
        return locationData;
      }
    }

    // Get the current position
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);

      // Get the first result from the reverse geocoding
      Placemark placemark = placemarks.first;

      locationData['latitude'] = position.latitude.toString();
      locationData['longitude'] = position.longitude.toString();
      locationData['address'] = '${placemark.street}, ${placemark.locality}, ${placemark.postalCode}, ${placemark.country}';

      return locationData;
    } catch (e) {
      locationData['error'] = 'Error getting location: $e';
      return locationData;
    }
  }
}
