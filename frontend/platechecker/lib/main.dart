  
import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:platechecker/bloc_delegate.dart';
import 'package:platechecker/components/main_form.dart';
import 'package:platechecker/styles/themes.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = MyBlocDelegate();

  // FormBlocDelegate.notifyOnFieldBlocTransition = true;
  // FormBlocDelegate.notifyOnFormBlocTransition = true;

  final cameras = await availableCameras();

  runApp(App(camera: cameras.first));
}

class App extends StatelessWidget {
  final CameraDescription camera;

  const App({Key key, @required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Themes.formTheme,
      initialRoute: 'home',
      routes: {
        'home': (context) => HomeScreen(camera: camera)
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  final CameraDescription camera;

  const HomeScreen({Key key, @required this.camera}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Registra il veicolo!'),
        elevation: 2,
      ),
      body: new MainForm(camera: camera)
    );
  }
}