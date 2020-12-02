import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mana/widgets/ui_helper.dart';

class RegisterForm extends StatefulWidget {
  RegisterForm(this.emailTextController, this.passwordTextController,
      this.confirmPasswordTextController);

  final TextEditingController confirmPasswordTextController;
  final TextEditingController emailTextController;
  final TextEditingController passwordTextController;

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
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
            Text("Crie seu acesso",
                style: TextStyle(
                    color: Colors.blue[600],
                    fontSize: ScreenUtil.getInstance().setSp(32),
                    fontFamily: "Poppins-Bold",
                    letterSpacing: .6)),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            TextFormField(
              controller: widget.emailTextController,
              maxLines: 1,
              keyboardType: TextInputType.emailAddress,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.blue[600], fontSize: 14.0),
                icon: new Icon(
                  Icons.mail,
                  color: Colors.blue[600],
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Informe um email valido!' : null,
              onSaved: (value) =>
                  widget.emailTextController.text = value.trim(),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            TextFormField(
              controller: widget.passwordTextController,
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Senha",
                hintStyle: TextStyle(color: Colors.blue[600], fontSize: 14.0),
                icon: new Icon(
                  Icons.lock,
                  color: Colors.blue[600],
                ),
              ),
              validator: (value) =>
                  value.isEmpty ? 'Informe uma senha valida!' : null,
              onSaved: (value) =>
                  widget.passwordTextController.text = value.trim(),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            TextFormField(
              controller: widget.confirmPasswordTextController,
              maxLines: 1,
              obscureText: true,
              autofocus: false,
              decoration: InputDecoration(
                hintText: "Confirmar senha",
                hintStyle: TextStyle(color: Colors.blue[600], fontSize: 14.0),
                icon: new Icon(
                  Icons.lock,
                  color: Colors.blue[300],
                ),
              ),
              validator: (value) => value != widget.passwordTextController.text
                  ? 'Senhas não conferem!'
                  : null,
              onSaved: (value) =>
                  widget.passwordTextController.text = value.trim(),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
          ],
        ),
      ),
    );
  }
}
