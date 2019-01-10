import 'package:flutter/material.dart';
import 'package:flutter_bloc_base_arch/base_bloc/base_bloc_provider.dart';
import 'package:flutter_bloc_base_arch/ui/bloc/test_text_mcq_bloc.dart';
import 'package:flutter_bloc_base_arch/ui/component/error_content.dart';

class ErrorHandler extends StatefulWidget {
  @override
  ErrorHandlerState createState() {
    return new ErrorHandlerState();
  }
}

class ErrorHandlerState extends State<ErrorHandler>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    super.initState();

    animationController = new AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        }

        if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BaseBlocProvider.of<TestTextMcqBloc>(context);

    return AnimatedBuilder(
        animation: animationController,
        builder: (BuildContext context, Widget child) {
          return StreamBuilder<bool>(
              stream: bloc.errorStream,
              builder:
                  (BuildContext buildContext, AsyncSnapshot<bool> snapshot) {
                if (snapshot.hasData && snapshot.data) {
                  return ErrorContent(
                    controller: animationController,
                  );
                } else if (snapshot.hasError) {
                  return Offstage();
                } else {
                  return Offstage();
                }
              });
        });
  }
}
