import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';

class ContinueButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);
    var containerColor = bloc.testAnswerResponseModel == null
        ? Colors.white
        : bloc.testAnswerResponseModel.textOptions.isAnswer
            ? Colors.green[200]
            : Colors.red[200];
    return Stack(
      children: <Widget>[
        Container(
          color: Colors.transparent,
        ),
        Positioned(
          bottom: 0.0,
          left: 0.0,
          right: 0.0,
          child: Container(
            color: containerColor,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildTextLabel(context),
                  _buildAnswerText(context),
                  SizedBox(
                    height: 16.0,
                  ),
                  _buildButton(context),
                  SizedBox(
                    height: 16.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    var color = bloc.testAnswerResponseModel == null
        ? Colors.white
        : bloc.testAnswerResponseModel.textOptions.isAnswer
            ? Colors.green
            : Colors.red;

    return Center(
      child: Container(
        height: 48.0,
        width: double.infinity,
        child: RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(8.0)),
          padding: EdgeInsets.all(0.0),
          color: color,
          child: Text('Continue',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(color: Colors.white)),
          onPressed: () {
            bloc.currentQuestionIndex = bloc.currentQuestionIndex + 1;
            bloc.navigateSink.add(bloc.currentQuestionIndex);
          },
        ),
      ),
    );
  }

  Widget _buildAnswerText(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);
    var color = bloc.testAnswerResponseModel == null
        ? Colors.white
        : bloc.testAnswerResponseModel.textOptions.isAnswer
            ? Colors.white
            : Colors.red;
    var opacity = bloc.testAnswerResponseModel == null
        ? 0.0
        : bloc.testAnswerResponseModel.textOptions.isAnswer ? 0.0 : 1.0;
    var label = bloc.testAnswerResponseModel == null
        ? ''
        : '${bloc.testAnswerResponseModel.textOptions.answer}';

    return StreamBuilder<TestAnswerResponseModel>(
      stream: bloc.optionClickedStream,
      builder: (BuildContext context,
          AsyncSnapshot<TestAnswerResponseModel> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.textOptions.isAnswer) {
            return SizedBox(height: 16,);
          } else {
            return Opacity(
              opacity: opacity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: AutoSizeText(
                  label,
                  style: Theme.of(context).textTheme.body1.copyWith(
                      color: color,
                      fontFamily: 'Raleway-Regular',
                      fontWeight: FontWeight.w500),
                  textAlign: TextAlign.left,
                ),
              ),
            );
          }
        } else {
          return Offstage();
        }
      },
    );
  }

  Widget _buildTextLabel(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    var labelColor = bloc.testAnswerResponseModel == null
        ? Colors.white
        : bloc.testAnswerResponseModel.textOptions.isAnswer
            ? Colors.white
            : Colors.red;

    var labelText = bloc.testAnswerResponseModel == null
        ? ''
        : bloc.testAnswerResponseModel.textOptions.isAnswer
            ? 'You are correct'
            : 'Correct answer is:';

    return AutoSizeText(
      labelText,
      style: Theme.of(context).textTheme.headline.copyWith(
          color: labelColor,
          fontFamily: 'Raleway-Regular',
          fontWeight: FontWeight.w700),
      textAlign: TextAlign.left,
    );
  }
}
