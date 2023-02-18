import 'package:get_it/get_it.dart';
import 'package:videalpha/AuthProvider/Auth_provider.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<AuthProvider>(AuthProvider());

// Alternatively you could write it if you don't like global variables
  // GetIt.I.registerSingleton<AppModel>(AppModel());
}
