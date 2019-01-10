import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/model/test_answer_response_model.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';
import 'package:flutter_bloc_base_arch/ui/component/header_card.dart';
import 'package:flutter_bloc_base_arch/ui/component/test_card.dart';

class TestTextMcqPager extends StatelessWidget {
  final PageController pageController;

  TestTextMcqPager(this.pageController);

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    return StreamBuilder<List<TextMcqTestCardModel>>(
        stream: bloc.broadcastTestListStream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<List<TextMcqTestCardModel>> snapshot) {
          if (snapshot.hasData) {
            return _buildContent(snapshot.data);
          } else if (snapshot.hasError) {
            return Offstage();
          } else {
            return Offstage();
          }
        });
  }

  Widget _buildContent(List<TextMcqTestCardModel> testList) {
    return Stack(children: <Widget>[
      SafeArea(child: HeaderCard()),
      Positioned(
        top: 100,
        left: 0.0,
        right: 0.0,
        bottom: 0.0,
        child: NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overscroll) {
            overscroll.disallowGlow();
          },
          child: PageView(
            controller: pageController,
            physics: NeverScrollableScrollPhysics(),
            children: testList.map((TextMcqTestCardModel textMcqTestCardModel) {
              return TestCard(textMcqTestCardModel: textMcqTestCardModel);
            }).toList(),
          ),
        ),
      ),
    ]);
  }
}
