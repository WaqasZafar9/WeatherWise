import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_helper.dart';

final currentweatherprovider = FutureProvider.autoDispose((ref){
  return ApiHelper.getCurrentWeather();
});