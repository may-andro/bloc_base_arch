import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:flutter_bloc_base_arch/ui/component/option_item.dart';

class TestCard extends StatelessWidget {
  const TestCard({this.textMcqTestCardModel});

  final TextMcqTestCardModel textMcqTestCardModel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: textMcqTestCardModel.options.length + 1,
        itemBuilder: (context, index) {

        switch(index) {
          case 0: return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Center(
              child: Text(
                textMcqTestCardModel.questions,
                style: Theme.of(context).textTheme.headline,
              ),
            ),
          );

          default: return TextOptions(textMcqTestCardModel.options[index - 1]);
        }
    });
  }
}
