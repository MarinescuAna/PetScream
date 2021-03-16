import 'package:get_it/get_it.dart';
import 'package:pet_scream_flutter_proj/services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerSingleton<UserService>(
      new UserService()
  );

}