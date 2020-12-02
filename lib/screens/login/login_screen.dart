import 'package:flutter/material.dart';
import 'package:mana/screens/login/register/register_user_screen.dart';
import 'package:mana/services/auth_service.dart';
import 'package:mana/widgets/CustomIcons.dart';
import 'package:mana/widgets/SocialIcons.dart';
import 'package:mana/screens/login/components/login_form.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({this.auth, this.loginCallback});

  final BaseAuth auth;
  final VoidCallback loginCallback;

  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String _errorMessage;
  final _formKey = new GlobalKey<FormState>();
  bool _isEmailVerified = false;
  bool _isLoading;
  bool _isSelected = false;

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform login or signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      try {
        String userId = "";
        userId = await widget.auth
            .signIn(emailController.text, passwordController.text);

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          _checkEmailVerification();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage =
              "Error ao tentar entrar, verifique seu email ou senha!";
          _formKey.currentState.reset();
        });
      }
    } else {
      setState(() {
        _errorMessage = "";
        _isLoading = false;
      });
    }
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  Widget radioButton(bool isSelected) => Container(
        width: 18.0,
        height: 18.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 3.0, color: Colors.blue[500])),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                    shape: BoxShape.circle, color: Colors.blue[500]),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  Widget _showFormScreen() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 120.0),
            child: Column(
              children: <Widget>[
                // SizedBox(
                //   width: ScreenUtil.getInstance().setWidth(110),
                //   height: ScreenUtil.getInstance().setHeight(290),
                // ),
                SizedBox(height: ScreenUtil.getInstance().setHeight(80)),
                _showLoginForm(),
                SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                showErrorMessage(),
                SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                _showActionsSigin(),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(120),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    horizontalLine(),
                    Text("Entrar com",
                        style: TextStyle(
                            color: Colors.blue[500],
                            fontSize: 16.0,
                            fontFamily: "Poppins-Medium")),
                    horizontalLine()
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(40),
                ),
                _showSocialLogin(),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(60),
                ),
                _showRegister(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showSocialLogin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SocialIcon(
          colors: [
            Color(0xFF102397),
            Color(0xFF187adf),
            Color(0xFF00eaf8),
          ],
          iconData: CustomIcons.facebook,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFFff4f38),
            Color(0xFFff355d),
          ],
          iconData: CustomIcons.googlePlus,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFF17ead9),
            Color(0xFF6078ea),
          ],
          iconData: CustomIcons.twitter,
          onPressed: () {},
        ),
        SocialIcon(
          colors: [
            Color(0xFF00c6fb),
            Color(0xFF005bea),
          ],
          iconData: CustomIcons.linkedin,
          onPressed: () {},
        )
      ],
    );
  }

  Widget _showActionsSigin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(
              width: 12.0,
            ),
            GestureDetector(
              onTap: _radio,
              child: radioButton(_isSelected),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text("lembrar",
                style: TextStyle(
                    color: Colors.blue[500],
                    fontSize: 15,
                    fontFamily: "Poppins-Medium"))
          ],
        ),
        InkWell(
          child: Container(
            width: ScreenUtil.getInstance().setWidth(330),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[500], Colors.blue[200]]),
                borderRadius: BorderRadius.circular(6.0),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFF6078ea).withOpacity(.3),
                      offset: Offset(0.0, 8.0),
                      blurRadius: 8.0)
                ]),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: validateAndSubmit,
                child: Center(
                  child: Text("ENTRAR",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Poppins-Bold",
                          fontSize: 18,
                          letterSpacing: 1.0)),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget _showLoginForm() {
    return LoginForm(emailController, passwordController, widget.auth);
  }

  Widget _showFormTop() {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 38.0, right: 38.0, top: 16.0),
          child: Image.asset("assets/img/image_01.png"),
        ),
        Expanded(
          child: Container(),
        ),
        Image.asset("assets/img/image_02.png"),
      ],
    );
  }

  Widget _showRegister() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Ainda não tem conta? ",
          style:
              TextStyle(color: Colors.blue[500], fontFamily: "Poppins-Medium"),
        ),
        InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return RegisterUserScreen(
                  auth: widget.auth, registerCallback: () {});
            }));
          },
          child: Text("Criar conta",
              style: TextStyle(
                  color: Colors.blue[500], fontFamily: "Poppins-Bold")),
        )
      ],
    );
  }

  Widget showErrorMessage() {
    if (_errorMessage.length > 0 && _errorMessage != null) {
      return new Text(
        _errorMessage,
        style: TextStyle(
            fontSize: 13.0,
            color: Colors.red,
            height: 1.0,
            fontWeight: FontWeight.w300),
      );
    } else {
      return new Container(
        height: 0.0,
      );
    }
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.blue[500],
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void _showVerifyEmailSentDialog(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Ola, falta bem pouquinho!"),
          content:
              new Text("Um link de confirmação foi enviando para " + email),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Enviar novamente"),
              onPressed: () {
                Navigator.of(context).pop();
                _resentVerifyEmail();
              },
            ),
            new FlatButton(
              child: new Text("Ok"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _checkEmailVerification() async {
    _isEmailVerified = await widget.auth.isEmailVerified();
    if (!_isEmailVerified) {
      _showVerifyEmailSentDialog(this.emailController.text);
    } else {
      widget.loginCallback();
    }
  }

  void _resentVerifyEmail() {
    widget.auth.sendEmailVerification();
    _showVerifyEmailSentDialog(this.emailController.text);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return new Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _showFormTop(),
          _showFormScreen(),
          _showCircularProgress(),
        ],
      ),
    );
  }
}
