import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';

class ProgressHandler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    return StreamBuilder<bool>(
        stream: bloc.progressStream,
        builder: (BuildContext buildContext,
            AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData && snapshot.data) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Offstage();
          } else {
            return Offstage();
          }
        });
  }
}
