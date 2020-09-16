import 'package:get_it/get_it.dart';
import 'package:survivalrunner/helpers/audio_helper.dart';

/// This is a service locator for global objects.
/// WARNING: DO NOT ABUSE THIS.
/// IT IS FOR CLASSES THAT ARE NEEDED ANYWHERE.
final locator = GetIt.instance;
void setupServiceLocator() {
  locator.registerLazySingleton<AudioHelper>(() => AudioHelper());
}
