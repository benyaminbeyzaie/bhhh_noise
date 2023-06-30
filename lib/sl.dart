import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> setupSL() async {
  final SharedPreferences preferences = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(preferences);
}
