import 'package:flutter/material.dart';
import 'package:test_rick/app.dart';
import 'package:test_rick/config/router.dart';
import 'package:test_rick/dependency_injection/app_component.dart';

void main() {
WidgetsFlutterBinding.ensureInitialized();
configureDependencies();
AppRouterHelper.instance;
runApp(const RickAndMortyApp());
}
