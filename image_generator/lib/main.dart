
import 'package:flutter/material.dart';
import 'package:image_generator/api/rest.dart';
import 'package:image_generator/utils/booleancheck.dart';


void main() {
  runApp(MaterialApp( home:MyApp()));
}

final ValueNotifier<ThemeMode> _notifier = ValueNotifier(ThemeMode.light);
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: _notifier,
        builder: (_, mode, __) {
          return MaterialApp(
             
            // initialRoute: '/',
            // onGenerateRoute: RouteGenerator.generateRoutes,
            // navigatorKey: NavigationService().navigatorKey,
            debugShowCheckedModeBanner: false,
            themeMode: mode,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            title: 'Flutter Demo',
            home: Scaffold(
              appBar: AppBar(
                elevation: 50,
                title: Text('AI Image Generator'),
                centerTitle: true,
                actions: [
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: IconButton(
                        icon: mode == ThemeMode.light
                            ? Icon(Icons.dark_mode)
                            : Icon(Icons.light_mode_outlined),
                        onPressed: () => _notifier.value =
                            mode == ThemeMode.light
                                ? ThemeMode.dark
                                : ThemeMode.light,
                      )),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: textController,
                      decoration: InputDecoration(
                          hintText: "Enter the prompt",
                          filled: true,
                          contentPadding: const EdgeInsets.all(16),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6)),
                          labelStyle: const TextStyle(color: Colors.red)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: 150,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 6,
                            shadowColor: mode == ThemeMode.light
                                ? Color.fromARGB(255, 222, 216, 231)
                                : Color.fromARGB(255, 200, 151, 206)),
                        onPressed: () {
                          booleancheck.isLoading = true;
                          convertTextToImage(textController.text, context);
                          
                          setState(() {});
                        },
                        
                        child: booleancheck.isLoading
                            ? const SizedBox(
                                height: 15,
                                width: 15,
                                child: CircularProgressIndicator(),
                              )
                            : const Text('Generate Image'),
                      ),
                    )
                  ],
                ),
              ),
              bottomNavigationBar: Container(
                color: mode == ThemeMode.light
                    ? Color.fromARGB(255, 222, 216, 231)
                    : Color.fromARGB(255, 53, 51, 58),
                height: 30,
                child: Center(child: Text('Made by Tronzard')),
              ),
            ),
          );
        });
}
}
