import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/constants/common_size.dart';
import 'package:untitled1/states/user_notifier.dart';
import 'package:untitled1/utils/logger.dart';
import 'package:provider/provider.dart';

class IntroPage extends StatelessWidget {
  IntroPage(PageController pageController, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;

        final imgSize = size.width - 32;  // Dynamic 레이아웃 강의
        final sizeOfPosImg = imgSize * 0.1;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: common_padding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '모두의 이동',
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(color: Theme.of(context).colorScheme.primary),
                ),
                SizedBox(
                  width: imgSize,
                  height: imgSize,
                  child: Stack(
                    children: [
                      ExtendedImage.asset('assets/imgs/carrot_intro.png'),
                      Positioned(
                          width: sizeOfPosImg,
                          left: imgSize * 0.45,
                          top: imgSize * 0.45,
                          height: sizeOfPosImg,
                          child: ExtendedImage.asset(
                              'assets/imgs/Vector.png')),
                    ],
                  ),
                ),
                Text(
                  '모두의 이동',
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  '''모두의 이동.
내 동네를 설정하고 시작해보세요.''',
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextButton(
                      onPressed: () async {
                        context.read<PageController>().animateToPage(1,
                            duration: Duration(milliseconds: 500),
                            curve: Curves.ease);
                        logger.d('on text button clicked!!!');
                      },
                      child: Text(
                        '내 동네 설정하고 시작하기',
                        style: Theme.of(context).textTheme.button,
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
