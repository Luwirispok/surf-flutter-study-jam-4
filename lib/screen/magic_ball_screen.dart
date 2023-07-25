import 'package:flutter/material.dart';
import 'package:surf_practice_magic_ball/core/data_source.dart';
import 'package:surf_practice_magic_ball/generated/assets.dart';

class MagicBallScreen extends StatelessWidget {
  const MagicBallScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [
            Color(0xff100C2C),
            Color(0xff000002),
          ]),
        ),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Spacer(flex: 180),
            MagicBallWidget(),
            Spacer(flex: 60),
            DescriptionWidget(),
            Spacer(flex: 60),
          ],
        ),
      ),
    );
  }
}

class MagicBallWidget extends StatefulWidget {
  const MagicBallWidget({super.key});

  @override
  State<MagicBallWidget> createState() => _MagicBallWidgetState();
}

class _MagicBallWidgetState extends State<MagicBallWidget> {
  String fortuneReading = '';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () async {
        EightBallDataSource.getRandomFortuneReading().then((value) {
          JustTranslateDataSource.getTranslation(text: value).then((value) {
            setState(() {
              fortuneReading = value;
            });
          }).catchError((_) {
            setState(() {
              fortuneReading = value;
            });
          });
        }).catchError((_) {});
      },
      child: Column(
        children: [
          SizedBox(
            width: width / 375 * 320,
            child: Stack(
              alignment: AlignmentDirectional.center,
              children: [
                Image.asset(
                  Assets.assetsBall,
                  fit: BoxFit.fitWidth,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    fortuneReading,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: width / 375 * 32,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: height / 812 * 70),
          Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Image.asset(Assets.assetsShadowFaint),
              Image.asset(Assets.assetsShadowStrong),
            ],
          ),
        ],
      ),
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Text(
      'Нажмите на шар или\nпотрясите телефон',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: const Color(0xff727272),
        fontSize: width / 375 * 16,
      ),
    );
  }
}
