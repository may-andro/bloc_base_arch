import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';

class TextOptions extends StatelessWidget {
  final TextMcqOptions option;

  TextOptions(this.option);

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    return InkWell(
      onTap: () {
        var testAnswerResponseModel = TestAnswerResponseModel(
          isAnswered: true,
          textOptions: option
        );

        bloc.optionClickedSink.add(testAnswerResponseModel);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: new ConstrainedBox(
            constraints: new BoxConstraints(
              minHeight: 75.0,
              minWidth: double.infinity,
            ),
            child: StreamBuilder<TestAnswerResponseModel>(
              stream: bloc.optionClickedStream,
              builder: (BuildContext context, AsyncSnapshot<TestAnswerResponseModel> snapshot) {
                var selectedColor = Colors.white;

                if(snapshot.hasData) {
                  if (snapshot.data.textOptions == option) {
                    selectedColor = snapshot.data.textOptions.isAnswer ? Colors.green: Colors.red;
                  } else {
                    selectedColor = Colors.white;
                  }
                }

                return Container(
                    decoration: BoxDecoration(
                      color: selectedColor,
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                            option.optionText,
                            style: Theme.of(context)
                                .textTheme
                                .body1
                                .copyWith(fontWeight: FontWeight.w500),
                          )),
                    )
                );
              },
            ),

        ),
      ),
    );
  }
}
