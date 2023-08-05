import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mlocalizations/core/utils/extension/localization_extension.dart';
import 'package:mlocalizations/core/utils/preference/preference_util.dart';
import 'package:provider/provider.dart';

import 'core/viewmodels/localization/localization_provider.dart';
import 'core/viewmodels/localization/notify_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferenceUtil.instance.initializePreference();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocalizationProvider()..initialize()),
        ChangeNotifierProvider(create: (_) => NotifyProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocalizationProvider>(
      builder: (context, localProv, _) => MaterialApp(
        title: "mlocalizations",
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.black,
            ),
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            elevation: 0,
          ),
        ),
        home: const HomePage(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: localProv.locale,
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      log('RESUMED');
      context.read<LocalizationProvider>().localePlatform();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("mlocalizations"),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20))),
                  builder: (context) {
                    return ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                          child: Container(
                            height: 5,
                            width: 40,
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text("Bahasa", style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700)),
                        ),
                        ListTile(
                          title: const Text("English"),
                          trailing: SizedBox(
                            height: 30,
                            width: 30,
                            child: LocalizationProvider.instance(context).locale?.languageCode == LocalizationEnum.localeEN.locale
                                ? Container(
                                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                    child: const Icon(Icons.done, size: 15, color: Colors.white),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          onTap: () async {
                            await LocalizationProvider.instance(context).changeLocale(const Locale('en'), LocalizationEnum.localeEN.locale).then(
                              (value) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Center(child: CircularProgressIndicator()),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).then((value) async {
                              await Future.delayed(const Duration(seconds: 1));
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            });
                          },
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text("Indonesia"),
                          trailing: SizedBox(
                            height: 30,
                            width: 30,
                            child: LocalizationProvider.instance(context).locale?.languageCode == LocalizationEnum.localeID.locale
                                ? Container(
                                    decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
                                    child: const Icon(Icons.done, size: 15, color: Colors.white),
                                  )
                                : const SizedBox.shrink(),
                          ),
                          onTap: () async {
                            await LocalizationProvider.instance(context).changeLocale(const Locale('id'), LocalizationEnum.localeID.locale).then(
                              (value) {
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (context) {
                                    return Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: const Center(child: CircularProgressIndicator()),
                                      ),
                                    );
                                  },
                                );
                              },
                            ).then((value) async {
                              await Future.delayed(const Duration(seconds: 1));
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                            });
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.settings)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("languageCode: ${context.loc.localeName}", style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 20),
            Text("Bahasa: ${context.loc.name}"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NavOne()));
              },
              child: Text('Goto: ${context.loc.navOne}'),
            ),
          ],
        ),
      ),
    ).localeNotify();
  }
}

class NavOne extends StatelessWidget {
  const NavOne({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.navOne),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const NavTwo()));
          },
          child: Text('Goto: ${context.loc.navTwo}'),
        ),
      ),
    );
  }
}

class NavTwo extends StatelessWidget {
  const NavTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.loc.navTwo),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Back: ${context.loc.navOne}'),
        ),
      ),
    );
  }
}
