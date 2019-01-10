import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DialogContent extends StatelessWidget {
  final String title;
  final String subtitle;
  final String positiveText;
  final String negativeText;
  final Function onPositiveCallback;
  final Function onNegativeCallBack;

  DialogContent(
      {
        @required this.title,
        @required this.subtitle,
        @required this.positiveText,
        @required this.negativeText,
        @required this.onPositiveCallback,
        @required this.onNegativeCallBack
      });

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width/2,
        height: MediaQuery.of(context).size.height/2,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.0)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  color: Colors.teal),
              child: Center(
                child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: AutoSizeText(
                      title,
                      style: Theme.of(context).textTheme.headline.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            Padding(
                padding: EdgeInsets.all(16.0),
                child: AutoSizeText(
                  subtitle,
                  style: Theme.of(context).textTheme.subhead.copyWith(
                      color: Colors.blueGrey, fontWeight: FontWeight.w300),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AutoSizeText(
                      negativeText,
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.grey, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: onNegativeCallBack,
                ),
                SizedBox(
                  width: 16.0,
                ),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: AutoSizeText(
                      positiveText,
                      style: Theme.of(context).textTheme.button.copyWith(
                          color: Colors.teal, fontWeight: FontWeight.w500),
                    ),
                  ),
                  onTap: onPositiveCallback,
                ),
              ],
            )
          ],
        ));
  }
}
