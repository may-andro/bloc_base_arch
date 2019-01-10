import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';
import 'package:flutter_bloc_base_arch/ui/component/scroll_indicator.dart';

class HeaderCard extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                  child: Container(
                    height: 5.0,
                    child: ScrollIndicator(
                      cardCount: bloc.testList.length,
                      scrollPercent: (bloc.currentQuestionIndex) / bloc.testList.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Select the correct translation!',
              style: Theme.of(context)
                  .textTheme
                  .title
                  .copyWith(fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    );
  }
}
