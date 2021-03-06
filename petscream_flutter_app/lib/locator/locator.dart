


import 'package:get_it/get_it.dart';
import 'package:petscream_flutter_app/services/ad_service.dart';
import 'package:petscream_flutter_app/services/user_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerSingleton<UserService>(
      new UserService()
  );
  locator.registerSingleton<AdService>(
      new AdService()
  );
}