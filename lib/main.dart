import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:rental_app/presentation/color_ext.dart';

import 'data/repository_impl.dart';
import 'firebase_options.dart';
import 'presentation/home_screen.dart';
import 'presentation/repository_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await _setUpRemoteConfig();

  runApp(const MyApp());
}

Future<FirebaseRemoteConfig> _setUpRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;

  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ),
  );

  await remoteConfig.setDefaults(
    {
      'scaffold_color': Colors.white.toHex(),
      'app_bar_title_color': const Color(0xff333333).toHex(),
      'text_field_color': Colors.grey[100]!.toHex(),
      'shadow_color': Colors.grey[300]!.toHex(),
    },
  );

  return remoteConfig;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final remoteConfig = FirebaseRemoteConfig.instance;

  @override
  void initState() {
    remoteConfig.addListener(() {
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldColor = remoteConfig.getString('scaffold_color');
    final titleColor = remoteConfig.getString('app_bar_title_color');
    final textFieldColor = remoteConfig.getString('text_field_color');

    return RepositoryProvider(
      repository: DummyRepositoryImpl(),
      child: MaterialApp(
        title: 'Rental App',
        theme: ThemeData(
          scaffoldBackgroundColor: ColorHex.fromHex(scaffoldColor),
          backgroundColor: ColorHex.fromHex(scaffoldColor),
          inputDecorationTheme: InputDecorationTheme(
            fillColor: ColorHex.fromHex(textFieldColor),
            filled: true,
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          appBarTheme: AppBarTheme(
            backgroundColor: ColorHex.fromHex(scaffoldColor),
            elevation: 0,
            centerTitle: false,
            toolbarTextStyle: _titleTextStyle.copyWith(
              color: ColorHex.fromHex(titleColor),
            ),
            titleTextStyle: _titleTextStyle.copyWith(
              color: ColorHex.fromHex(titleColor),
            ),
          ),
        ),
        home: const MyHomePage(),
      ),
    );
  }

  TextStyle get _titleTextStyle {
    return const TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.bold,
      color: Color(0xff333333),
    );
  }
}
