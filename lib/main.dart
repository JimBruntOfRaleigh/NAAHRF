import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:national_alliance_against_home_repair_fraud/custom_widgets.dart';
import 'localizations.dart';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        LocalDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
      builder: (context, child) {
        return FormThemeProvider(
          theme: const FormTheme(
            checkboxTheme: CheckboxFieldTheme(
              canTapItemTile: true,
            ),
            radioTheme: RadioFieldTheme(
              canTapItemTile: true,
            ),
          ),
          child: child!,
        );
      },
      home: const QuestionAndAnswerForm(),
      // AllFieldsForm(),
    );
  }
}

//TODO don't need this.
class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key? key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  const LoadingDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: const EdgeInsets.all(12.0),
            color: Colors.transparent,
            child: const CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

//TODO change this to something else.
class SuccessScreen extends StatelessWidget {
  const SuccessScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(Icons.tag_faces, size: 100),
            const SizedBox(height: 10),
            const Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => const QuestionAndAnswerForm())),
              icon: const Icon(Icons.replay),
              label: const Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionAndAnswerFormBloc extends FormBloc<String, String> {
  late List<SelectFieldBloc> _questions;
  late List<BooleanFieldBloc> _answers;

  static final List<String> questionsBefore = [
    "researchedTheProject",
    "consultedArchitect",
    "gottenThreeEstimates",
    "contractingSpecialists",
    "selectedContractor",
    "gottenReferences",
    "verifiedInsuranceCoverage",
    "verifiedBusinessLicense",
    "verifiedContractorLicense",
    "verifiedContractorBonded",
    "consideredBuyingBond",
    "gottenSubcontractorInfo",
    "gottenScopeOfWork",
    "agreedToPaySchedule",
    "understandContract",
    "lawyerReview",
  ];

  static final List<String> questionsDuring = [
    "takenPhotos",
    "securedValuables",
    "copiesOfPermits",
    "dailyProgressJournal",
    "takingPicturesThroughout",
    "gettingRegularUpdates",
    "gettingAllChangeOrdersRecorded",
  ];

  static final List<String> questionsAfter = [
    "projectCompleted",
    "clearedAndCleaned",
    "inspectionsApproved",
    "releasesSigned",
    "finalPaymentAffidavitSigned",
    "haveAllPapers",
    "haveApplicableNotices"
  ];

  QuestionAndAnswerFormBloc() {
    _questions = List<SelectFieldBloc>.empty(growable: true);
    _answers = List<BooleanFieldBloc>.empty(growable: true);

    //setup blocs for inputs and displays.
    // questions are always yes/no which trigger answer display.
    // answers have been left as BooleanFieldBloc to leave open question of
    //  understanding the answer given, or doing other types of actions.
    final int numQuestions =
        questionsBefore.length + questionsDuring.length + questionsAfter.length;
    for (int i = 0; i < numQuestions; i++) {
      _questions.add(SelectFieldBloc(items: ['Yes', 'No']));
      _answers.add(BooleanFieldBloc(validators: [], initialValue: false));
    }

    //put questions in the correct 'step' before, during, or after the project.
    for (int i = 0; i < questionsBefore.length; i++) {
      addFieldBloc(step: 0, fieldBloc: _questions[i]);
    }

    for (int i = questionsBefore.length;
        i < (questionsBefore.length + questionsDuring.length);
        i++) {
      addFieldBloc(step: 1, fieldBloc: _questions[i]);
    }
    for (int i = questionsBefore.length + questionsDuring.length;
        i <
            (questionsBefore.length +
                questionsDuring.length +
                questionsAfter.length);
        i++) {
      addFieldBloc(step: 2, fieldBloc: _questions[i]);
    }

    //setup the answers so they are shown when the answer to
    // a question is 'no'
    for (int i = 0; i < _questions.length; i++) {
      var q = _questions[i];
      var a = _answers[i];
      q.onValueChanges(onData: (previous, current) async* {
        if (current.value == 'No') {
          addFieldBloc(fieldBloc: a);
        } else {
          removeFieldBloc(fieldBloc: a);
        }
        // else if (current.value == 'Yes') {
        //   removeFieldBloc(fieldBloc: a);
        // }
      });
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }

  @override
  void onSubmitting() async {
    try {
      //await Future<void>.delayed(const Duration(milliseconds: 500));
      emitSuccess();
    } catch (e) {
      emitFailure();
    }
  }
}

class QuestionAndAnswerForm extends StatefulWidget {
  const QuestionAndAnswerForm({Key? key}) : super(key: key);

  @override
  _QuestionAndAnswerFormState createState() => _QuestionAndAnswerFormState();
}

class _QuestionAndAnswerFormState extends State<QuestionAndAnswerForm> {
  // this variable determines whether the back-to-top button is shown or not
  bool _showBackToTopButton = false;

  // scroll controller
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        setState(() {
          if (_scrollController.offset >= 400) {
            _showBackToTopButton = true; // show the back-to-top button
          } else {
            _showBackToTopButton = false; // hide the back-to-top button
          }
        });
      });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose(); // dispose the controller
    super.dispose();
  }

  // This function is triggered when the user presses the back-to-top button
  void _scrollToTop() {
    _scrollController.animateTo(0,
        duration: const Duration(milliseconds: 800), curve: Curves.easeInOut);
  }

  
  @override
  Widget build(BuildContext context) {
    //size of the screen
    final Size size = MediaQuery.of(context).size;

    return BlocProvider(
        create: (context) => QuestionAndAnswerFormBloc(),
        child: Builder(builder: (context) {
          final formBloc = BlocProvider.of<QuestionAndAnswerFormBloc>(context);
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                title: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: Local.of(context).get('orgName'),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),
              floatingActionButton: _showBackToTopButton == false
                  ? null
                  : FloatingActionButton(
                      onPressed: _scrollToTop,
                      child: const Icon(Icons.arrow_upward),
                    ),
              body: SafeArea(
                  child: FormBlocListener<QuestionAndAnswerFormBloc, String,
                          String>(
                      onSubmitting: (context, state) =>
                          LoadingDialog.show(context),
                      onSubmissionFailed: (context, state) =>
                          LoadingDialog.hide(context),
                      onSuccess: (context, state) {
                        LoadingDialog.hide(context);

                        if (state.stepCompleted == state.lastStep) {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const SuccessScreen()));
                        } else {
                          //_scrollToTop(state.currentStep);
                        }
                      },
                      onFailure: (context, state) {
                        LoadingDialog.hide(context);
                      },
                      child: SizedBox(
                        height: size.height,
                        width: size.width,
                        child: SingleChildScrollView(
                          controller: _scrollController,
                          physics: const ClampingScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          child: Container(
                            //TODO: fix this.
                            height: 6000,
                            child: StepperFormBlocBuilder
                            <QuestionAndAnswerFormBloc>(
                              formBloc:
                                  context.read<QuestionAndAnswerFormBloc>(),
                              type: StepperType.horizontal,
                              physics: const NeverScrollableScrollPhysics(),
                              stepsBuilder: (formBloc) {
                                return [
                                  _beforeProject(formBloc!),
                                  _duringProject(formBloc),
                                  _afterProject(formBloc),
                                ];
                              },
                              onStepContinue: (formBloc) {
                                formBloc?.submit();
                                _scrollToTop();
                              },
                              onStepCancel: (formBloc){
                                formBloc?.previousStep();
                                _scrollToTop();
                              },
                              onStepTapped: (formBloc, index){
                                formBloc?.updateCurrentStep(index);
                                _scrollToTop();
                              },
                            ),
                          ),
                        ),
                      ))),
            ),
          );
          // This is our back-to-top button
        }));
  }

  //these 'Steps' save responses to their questions!
  FormBlocStep _beforeProject(QuestionAndAnswerFormBloc formBloc) {
    return FormBlocStep(
        title: Text(Local.of(context).get('beforeProject')),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: QuestionAndAnswerFormBloc.questionsBefore.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildQuestion(
                      context,
                      formBloc._questions[index],
                      formBloc._answers[index],
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsBefore[index] +
                              'Q'),
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsBefore[index] +
                              'A'),
                      index % 2 == 0 ? 0.1 : -0.1);
                })));
  }
  FormBlocStep _duringProject(QuestionAndAnswerFormBloc formBloc) {
    return FormBlocStep(
        title: Text(Local.of(context).get('duringProject')),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: QuestionAndAnswerFormBloc.questionsDuring.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildQuestion(
                      context,
                      formBloc._questions[index +
                          QuestionAndAnswerFormBloc.questionsBefore.length],
                      formBloc._answers[index +
                          QuestionAndAnswerFormBloc.questionsBefore.length],
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsDuring[index] +
                              'Q'),
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsDuring[index] +
                              'A'),
                      index % 2 == 0 ? -0.1 : 0.1);
                })));
  }
  FormBlocStep _afterProject(QuestionAndAnswerFormBloc formBloc) {
    return FormBlocStep(
        title: Text(Local.of(context).get('afterProject')),
        content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: QuestionAndAnswerFormBloc.questionsAfter.length,
                itemBuilder: (BuildContext context, int index) {
                  return buildQuestion(
                      context,
                      formBloc._questions[index +
                          QuestionAndAnswerFormBloc.questionsBefore.length +
                          QuestionAndAnswerFormBloc.questionsDuring.length],
                      formBloc._answers[index +
                          QuestionAndAnswerFormBloc.questionsBefore.length +
                          QuestionAndAnswerFormBloc.questionsDuring.length],
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsAfter[index] +
                              'Q'),
                      Local.of(context).get(
                          QuestionAndAnswerFormBloc.questionsAfter[index] +
                              'A'),
                      index % 2 == 0 ? 0.1 : -0.1);
                })));
  }
}
