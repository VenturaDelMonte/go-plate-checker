import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:form_bloc/form_bloc.dart';
import 'package:platechecker/components/camera.dart';
import 'package:platechecker/widgets/widgets.dart';

class MainForm extends StatelessWidget {

  final CameraDescription camera;

  const MainForm({Key key, @required this.camera}) : super(key: key);

  loadCameraWidget(context, index) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) => TakePictureScreen(camera: camera),
      ),
    ); 
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<MainFormBloc>(
      create: (context) => MainFormBloc(),
      child: Builder(
        builder: (context) {
          final formBloc = BlocProvider.of<MainFormBloc>(context);

          return Scaffold(
            appBar: AppBar(title: Text('Modulo')),
            body: FormBlocListener<MainFormBloc, String, String>(
              onSubmitting: (context, state) => LoadingDialog.show(context),
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Notifications.showSnackBarWithSuccess(
                    context, state.successResponse);
              },
              onFailure: (context, state) {
                LoadingDialog.hide(context);
                Notifications.showSnackBarWithError(
                    context, state.failureResponse);
              },
              child: BlocBuilder<MainFormBloc, FormBlocState>(
                  builder: (context, state) {
                return ListView(
                  physics: ClampingScrollPhysics(),
                  children: <Widget>[
                    TextFieldBlocBuilder(
                      textFieldBloc: state.fieldBlocFromPath('name'),
                      decoration: InputDecoration(
                        labelText: 'Nome',
                        prefixIcon: Icon(Icons.sentiment_very_satisfied),
                      ),
                      errorBuilder: (context, error) {
                        switch (error) {
                          case FieldBlocValidatorsErrors.requiredTextFieldBloc:
                            return 'You must write amazing text.';
                            break;
                          default:
                            return 'This text is nor valid.';
                        }
                      },
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: state.fieldBlocFromPath('surname'),
                      decoration: InputDecoration(
                        labelText: 'Cognome',
                        prefixIcon: Icon(Icons.sentiment_very_satisfied),
                      ),
                      errorBuilder: (context, error) {
                        switch (error) {
                          case FieldBlocValidatorsErrors.requiredTextFieldBloc:
                            return 'You must write amazing text.';
                            break;
                          default:
                            return 'This text is nor valid.';
                        }
                      },
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: state.fieldBlocFromPath('email'),
                      decoration: InputDecoration(
                        labelText: 'Indirizzo E-Mail',
                        prefixIcon: Icon(Icons.sentiment_very_satisfied),
                      ),
                      errorBuilder: (context, error) {
                        switch (error) {
                          case FieldBlocValidatorsErrors.requiredTextFieldBloc:
                            return 'You must write amazing text.';
                            break;
                          default:
                            return 'This text is nor valid.';
                        }
                      },
                    ),
                    TextFieldBlocBuilder(
                      textFieldBloc: state.fieldBlocFromPath('plate'),
                      decoration: InputDecoration(
                        labelText: 'Targa Veicolo',
                        prefixIcon: Icon(Icons.sentiment_very_satisfied),
                      ),
                      errorBuilder: (context, error) {
                        switch (error) {
                          case FieldBlocValidatorsErrors.requiredTextFieldBloc:
                            return 'You must write amazing text.';
                            break;
                          default:
                            return 'This text is nor valid.';
                        }
                      },
                    ),
                    FormButton(
                      text: 'Foto 1',
                      onPressed: () { loadCameraWidget(context, 0); },
                    ),
                    FormButton(
                      text: 'Foto 2',
                      onPressed: () { loadCameraWidget(context, 1); },
                    ),
                    FormButton(
                      text: 'Foto 3',
                      onPressed: () { loadCameraWidget(context, 2); },
                    ),
                    FormButton(
                      text: 'Foto 4',
                      onPressed: () { loadCameraWidget(context, 3); },
                    ),
                    FormButton(
                      text: 'Foto 5',
                      onPressed: () { loadCameraWidget(context, 4); },
                    ),
                    FormButton(
                      text: 'Foto 6',
                      onPressed: () { loadCameraWidget(context, 5); },
                    ),
                    FormButton(
                      text: 'Invia',
                      onPressed: formBloc.submit,
                    ),
                    FormButton(
                      text: 'Annulla',
                      onPressed: formBloc.clear,
                    ),
                  ],
                );
              }),
            ),
          );
        },
      ),
    );
  }
}

class MainFormBloc extends FormBloc<String, String> {
  MainFormBloc() {
    addFieldBloc(
      fieldBloc: TextFieldBloc(
        name: 'name',
        validators: [FieldBlocValidators.requiredTextFieldBloc],
      ),
    );
    addFieldBloc(
      fieldBloc: TextFieldBloc(
        name: 'surname',
        validators: [FieldBlocValidators.requiredTextFieldBloc],
      ),
    );
    addFieldBloc(
      fieldBloc: TextFieldBloc(
        name: 'email',
        validators: [FieldBlocValidators.requiredTextFieldBloc],
      ),
    );
    addFieldBloc(
      fieldBloc: TextFieldBloc(
        name: 'plate',
        validators: [FieldBlocValidators.requiredTextFieldBloc],
      ),
    );
  }

  void loadPicture(int index, CameraDescription camera) {

  }

  @override
  Stream<FormBlocState<String, String>> onSubmitting() async* {
    // Awesome logic...

    // Get the fields values:


    // print(state.fieldBlocFromPath('text').asTextFieldBloc.value);
    // print(state.fieldBlocFromPath('boolean').asBooleanFieldBloc.value);
    // print(state.fieldBlocFromPath('select1').asSelectFieldBloc<String>().value);
    // print(state.fieldBlocFromPath('select2').asSelectFieldBloc<String>().value);
    // print(state
    //     .fieldBlocFromPath('multiSelect')
    //     .asMultiSelectFieldBloc<String>()
    //     .value);

    await Future<void>.delayed(Duration(seconds: 2));
    yield state.toSuccess(successResponse: 'Success', canSubmitAgain: true);
  }
}