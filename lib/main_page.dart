import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rokeet/rokeet.dart';

class MainPage extends AbstractRokeetPage {
  static RPageCreator CREATOR = (rokeet, data) => MainPage(rokeet);

  MainPage(rokeet, {Key? key}) : super(rokeet, key: key);

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends RState<MainPage, RStep> {
  bool _isLoggedIn = true;

  @override
  void initState() {
    super.initState();
    String? token = rokeet.storage.get("access_token");
    _isLoggedIn = token != null && token.isNotEmpty;
  }

  @override
  Widget buildPage(BuildContext context) {
    if (!this._isLoggedIn) {
      return RokeetStepPage(rokeet, stepId: "login");
    }
    return FutureBuilder<RStep?>(
        future: rokeet.getStep("home"),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return getLoadingWidget();
          }

          var data = snapshot.data;
          var body = rokeet.buildWidget(data!.body!)!;
          Key key = Key(data.id!);
          return Scaffold(
            body: SafeArea(
              child: body,
            ),
            key: key,
          );
        });
  }
}
