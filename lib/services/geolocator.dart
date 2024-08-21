import 'package:geolocator/geolocator.dart';

Future<Position> getLocation() async{
  LocationPermission permission;

  permission = await Geolocator.checkPermission();
  if(permission == LocationPermission.denied){
    permission = await Geolocator.requestPermission();
    if(permission == LocationPermission.denied){
      return Future.error('Location permission are denied');
    }
  }
  if (permission == LocationPermission.deniedForever){
    return Future.error('Location permission are permanently denied, we cannot request permissions.',);
  }
  return await Geolocator.getCurrentPosition();
}