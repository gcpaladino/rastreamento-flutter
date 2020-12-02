import 'package:flutter/widgets.dart';
import 'package:mana/screens/root_screen.dart';
import 'package:mana/services/auth_service.dart';

final Auth authFirebase = new Auth();

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => new RootScreen(auth: authFirebase),
  //"/recovery": (BuildContext context) => RecoveryAccountScreen(auth: authFirebase),
};
