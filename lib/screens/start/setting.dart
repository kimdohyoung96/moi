import 'package:provider/provider.dart';
import 'package:untitled1/components/Icons.dart';
import 'package:untitled1/data/terms.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/start/styles.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  _movePOS() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TermsPage(title: "서비스 이용약관", type: "pos")));
  }

  _movePrivacyPolicy() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TermsPage(title: "개인정보 처리방침", type: "pp")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          foregroundColor: gray01,
          title: Text(
            "약관동의",
            style: body2Bold,
          )),
      body: _buildbody(),
      bottomNavigationBar:
      TextButton(
        onPressed: () async {
          context.read<PageController>().animateToPage(2,
              duration: Duration(milliseconds: 500),
              curve: Curves.ease);
        },
        child: Text(
          '모두 동의하고 시작하기',
          style: Theme.of(context).textTheme.button,
        ),
      ),
    );
  }

  Widget _buildbody() {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              children: <Widget>[_settingMenus()],
            )));
  }

  Widget _settingMenus() {
    return Container(
        margin: const EdgeInsetsDirectional.only(top: 10),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _menuButton("서비스 이용약관 (필수)", _movePOS),
            _menuButton("개인정보 수집 및 이용 (필수)", _movePrivacyPolicy)
          ],
        ));
  }

  Widget _menuButton(text, onTap) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        decoration: BorderBottom,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: body1Bold,
              ),
              arrowIcon(),
            ]),
      ),
      onTap: onTap,
    );
  }
}