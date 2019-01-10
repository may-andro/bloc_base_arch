import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class ErrorContent extends StatelessWidget {
  final NetworkErrorAnimation animation;

  ErrorContent({@required AnimationController controller})
      : animation = new NetworkErrorAnimation(controller);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CloudCutColoredImage(Container(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: <Widget>[
                Positioned(
                  bottom: 16.0,
                  left: 0,
                  right: 0,
                  child: Transform(
                    transform: new Matrix4.diagonal3Values(
                      1.4 - animation.sizeTranslation.value,
                      1.4 - animation.sizeTranslation.value,
                      1.0,
                    ),
                    alignment: Alignment.center,
                    child: SafeArea(
                      child: Icon(
                        Icons.signal_wifi_off,
                        color: Colors.white,
                        size: MediaQuery.of(context).size.width * 0.3,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    top: 16.0,
                    right: 8.0,
                    child: Transform(
                      transform: new Matrix4.translationValues(
                        1 - animation.xTranslation.value,
                        0.0,
                        0.0,
                      ),
                      child: SafeArea(
                        child: Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.3,
                        ),
                      ),
                    )),
                Positioned(
                    top: 24.0,
                    left: 8.0,
                    child: Transform(
                      transform: new Matrix4.translationValues(
                        animation.xTranslation.value,
                        0.0,
                        0.0,
                      ),
                      child: SafeArea(
                        child: Icon(
                          Icons.cloud,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.width * 0.2,
                        ),
                      ),
                    )),
              ],
            ),
          )),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 48,
                  ),
                  Transform(
                    transform: new Matrix4.diagonal3Values(
                      animation.sizeTranslation.value * 2,
                      animation.sizeTranslation.value * 2,
                      1.0,
                    ),
                    alignment: Alignment.center,
                    child: AutoSizeText(
                      'Ooops!',
                      style: Theme.of(context).textTheme.display2.copyWith(
                          color: animation._colorTween.value,
                          fontFamily: 'Raleway-Regular',
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  AutoSizeText(
                    'No internet connection found!\nCheck you connection',
                    style: Theme.of(context).textTheme.subtitle.copyWith(
                        color: Colors.blueGrey,
                        fontFamily: 'Raleway-Regular',
                        fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 24,
                  ),

                  RaisedButton(
                    color: Colors.blueGrey,
                    onPressed: () {

                    },
                    child: AutoSizeText(
                      'Try again',
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.white,
                          fontFamily: 'Raleway-Regular',
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ))
        ]);
  }
}

class CloudCutColoredImage extends StatelessWidget {
  CloudCutColoredImage(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new ClipPath(
      clipper: new CustomShapeClipper(),
      child: new DecoratedBox(
        decoration: BoxDecoration(color: Colors.red),
        child: child,
      ),
    );
  }
}

class CustomShapeClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final Path path = Path();
    path.lineTo(0.0, size.height - 60);

    var zeroControlPoint = new Offset(size.width / 8, size.height - 20);
    var zeroPoint = new Offset(size.width / 4, size.height - 40);
    path.quadraticBezierTo(
        zeroControlPoint.dx, zeroControlPoint.dy, zeroPoint.dx, zeroPoint.dy);

    var firstControlPoint = new Offset(size.width * (3 / 8), size.height);
    var firstPoint = new Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    var secondControlPoint = Offset(size.width * (5 / 8), size.height);
    var secondPoint = new Offset(size.width * (6 / 8), size.height - 40);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    var thirdControlPoint = Offset(size.width * (7 / 8), size.height - 20);
    var thirdPoint = Offset(size.width * (8 / 8), size.height - 70);
    path.quadraticBezierTo(thirdControlPoint.dx, thirdControlPoint.dy,
        thirdPoint.dx, thirdPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class NetworkErrorAnimation {
  NetworkErrorAnimation(this.controller)
      : sizeTranslation = new Tween(begin: 0.4, end: 0.7).animate(
    new CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ),
  ),
        labelOpacity = new Tween(begin: 0.4, end: 1.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: Curves.ease,
          ),
        ),
        xTranslation = new Tween(begin: 60.0, end: 0.0).animate(
          new CurvedAnimation(
            parent: controller,
            curve: Curves.ease,
          ),
        ),
        _colorTween = ColorTween(begin: Colors.red, end: Colors.deepOrangeAccent).animate(
          new CurvedAnimation(
            parent: controller,
            curve: Curves.ease,
          ),
        );

  final AnimationController controller;
  final Animation<double> sizeTranslation;
  final Animation<double> labelOpacity;
  final Animation<double> xTranslation;
  final Animation _colorTween;
}
