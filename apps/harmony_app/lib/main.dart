import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:harmony_app/src/home_page/data_holder.dart';
import 'package:harmony_app/src/home_page/home_page_view.dart';
import 'package:library_pkg/library_pkg.dart';
import 'package:localization_pkg/localization_pkg.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  _registerDependencies();
  runApp(LocalizationWidget(child: const HarmonyApp()));
}

class HarmonyApp extends StatelessWidget {
  const HarmonyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      title: 'Harmony',
      theme: darkTheme.copyWith(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: darkTheme.appBarTheme.copyWith(backgroundColor: Colors.transparent),
        iconTheme: darkTheme.iconTheme.copyWith(color: Colors.black),
      ),
      home: const SafeArea(
        child: HomePageView(),
      ),
    );
  }
}

void _registerDependencies() {
  GetIt.instance.registerSingleton<DataHolder>(DataHolder());
}
