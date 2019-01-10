import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';
import 'package:flutter_bloc_base_arch/ui/component/continue_button.dart';
import 'package:flutter_bloc_base_arch/ui/component/dialog_content.dart';
import 'package:flutter_bloc_base_arch/ui/component/error_handler.dart';
import 'package:flutter_bloc_base_arch/ui/component/fluid_top_bar.dart';
import 'package:flutter_bloc_base_arch/ui/component/progress_handler.dart';
import 'package:flutter_bloc_base_arch/ui/component/test_pager.dart';

class TextMcqTest extends StatefulWidget {

  TextMcqTest();

  @override
  _TextMcqTestPageState createState() => _TextMcqTestPageState();
}

class _TextMcqTestPageState extends State<TextMcqTest>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  Animation<double> enterAnimation;

  TestTextMcqBloc testTextMcqBloc;

  PageController _pageController;

  @override
  void initState() {
    super.initState();
    testTextMcqBloc = TestTextMcqBloc();
    testTextMcqBloc.fetchTestSink.add('level1');

    _pageController = PageController();

    _animationController =
        AnimationController(duration: Duration(milliseconds: 400), vsync: this)
          ..addStatusListener((AnimationStatus status) {
            switch (status) {
              case AnimationStatus.forward:
                break;
              case AnimationStatus.reverse:
                break;
              case AnimationStatus.completed:
                break;
              case AnimationStatus.dismissed:
                if (testTextMcqBloc.currentQuestionIndex <
                    testTextMcqBloc.testList.length) {
                  _pageController.animateToPage(
                      testTextMcqBloc.currentQuestionIndex,
                      duration: Duration(microseconds: 1000),
                      curve: Curves.fastOutSlowIn);
                  testTextMcqBloc.optionClickedSink.add(null);
                } else {
                  //Navigator.of(context).pushNamedAndRemoveUntil('/testScore', (Route<dynamic> route) => false);
                  _pageController.animateToPage(
                      0,
                      duration: Duration(microseconds: 1000),
                      curve: Curves.fastOutSlowIn);
                  testTextMcqBloc.optionClickedSink.add(null);
                  testTextMcqBloc.resetTest();
                }
                break;
            }
          });

    enterAnimation = new Tween(begin: 1.0, end: 0.0).animate(
      new CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    testTextMcqBloc.optionClickedStream.listen(_startAnimationAndShowContinueButton);

    testTextMcqBloc.navigateStream.listen(_navigateToNextTestCard);
  }

  Future _navigateToNextTestCard(int page) async {
    _animationController.reverse();
  }

  Future _startAnimationAndShowContinueButton(
      TestAnswerResponseModel testAnswerResponseModel) async {
    if (testAnswerResponseModel != null) {
      _animationController.forward();
    }
    testTextMcqBloc.testAnswerResponseModel = testAnswerResponseModel;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    testTextMcqBloc.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
              child:  DialogContent(
                title: 'Quit Test?',
                subtitle: 'Without finishing the test you can not unlock next level. Do you still want to quit?',
                positiveText: 'Exit',
                negativeText: 'Dissmiss',
                onNegativeCallBack: () {
                  Navigator.of(context).pop(false);
                },onPositiveCallback: () {
                Navigator.of(context).pop(true);
              },
              )
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: BaseBlocProvider(bloc: testTextMcqBloc,
        child: new Scaffold(
            backgroundColor: Colors.grey[300],
            body: AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget child) {
                  return Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.6,
                        child: TopBar(child: Container()),
                      ),
                      ProgressHandler(),
                      TestTextMcqPager(_pageController),
                      ErrorHandler(),
                      Transform(
                        alignment: FractionalOffset.topLeft,
                        transform: Matrix4.translationValues(
                          0.0,
                          (enterAnimation.value) *
                              MediaQuery.of(context).size.height,
                          0.0,
                        ),
                        child: ContinueButton(),
                      )
                    ],
                  );
                })),
      ),
    );
  }
}
