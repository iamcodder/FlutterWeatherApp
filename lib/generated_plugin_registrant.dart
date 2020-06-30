//
// Generated file. Do not edit.
//

// ignore: unused_import
import 'dart:ui';

import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:fluttertoast/fluttertoast_web.dart';
import 'package:location_web/location_web.dart';

// ignore: public_member_api_docs
void registerPlugins(PluginRegistry registry) {
  FluttertoastWebPlugin.registerWith(
      registry.registrarFor(FluttertoastWebPlugin));
  LocationWebPlugin.registerWith(registry.registrarFor(LocationWebPlugin));
  registry.registerMessageHandler();
}
