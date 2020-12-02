import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mana/screens/login/recovery/recovery_account_screen.dart';
import 'package:mana/services/auth_service.dart';
import 'package:mana/widgets/ui_helper.dart';

class LoginForm extends StatefulWidget {
  final BaseAuth auth;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  LoginForm(this.emailTextController, this.passwordTextController, this.auth);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    //screenHeight = MediaQuery.of(context).size.height;
    return new Container(
      width: screenWidth,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextFormField(
              controller: widget.emailTextController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.blue[500], fontSize: 14.0),
                icon: new Icon(
                  Icons.mail,
                  color: Colors.blue[500],
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Informe um email valido!' : null,
              onSaved: (value) =>
                  widget.emailTextController.text = value.trim(),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            TextFormField(
              controller: widget.passwordTextController,
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Senha",
                hintStyle: TextStyle(color: Colors.blue[500], fontSize: 14.0),
                icon: new Icon(
                  Icons.lock,
                  color: Colors.blue[500],
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Informe uma senha valida!' : null,
              onSaved: (value) =>
                  widget.passwordTextController.text = value.trim(),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(46),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return RecoveryAccountScreen(auth: widget.auth);
                    }));
                  },
                  child: Text(
                    "Esqueci minha senha?",
                    style: TextStyle(
                        color: Colors.blue[500],
                        fontFamily: "Poppins-Medium",
                        fontSize: ScreenUtil.getInstance().setSp(26)),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(46),
            ),
          ],
        ),
      ),
    );
  }
}
