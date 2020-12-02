import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mana/screens/login/register/components/register_form.dart';
import 'package:mana/services/auth_service.dart';
import 'package:mana/widgets/CustomIcons.dart';
import 'package:mana/widgets/SocialIcons.dart';

class RegisterUserScreen extends StatefulWidget {
  final BaseAuth auth;
  final VoidCallback registerCallback;

  RegisterUserScreen({this.auth, this.registerCallback});

  @override
  _RegisterUserScreenState createState() => _RegisterUserScreenState();
}

class _RegisterUserScreenState extends State<RegisterUserScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  bool _isLoading;
  String _errorMessage;

  // Check if form is valid before perform login or signup
  bool validateAndSave() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  // Perform signup
  void validateAndSubmit() async {
    setState(() {
      _errorMessage = "";
      _isLoading = true;
    });
    if (validateAndSave()) {
      String userId = "";
      try {
        userId = await widget.auth
            .signUp(emailController.text, passwordController.text);
        widget.auth.sendEmailVerification();
        _showVerifyEmailSentDialog(emailController.text);

        setState(() {
          _isLoading = false;
        });

        if (userId.length > 0 && userId != null) {
          widget.registerCallback();
        }
      } catch (e) {
        print('Error: $e');
        setState(() {
          _isLoading = false;
          _errorMessage = "Error ao cadastrar usuária, tente novamente!";
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

  @override
  void initState() {
    _errorMessage = "";
    _isLoading = false;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
    _errorMessage = "";
  }

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);

    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[500],
        title: Text(
          "Cadastro",
          style: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontFamily: "Poppins-Medium"),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _showFormScreen(),
          _showCircularProgress(),
        ],
      ),
    );
  }

  Widget _showFormScreen() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: new Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
            child: Column(
              children: <Widget>[
                showErrorMessage(),
                SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                _showRegisterForm(),
                SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                _showActionsSigin(),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(40),
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(30),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    horizontalLine(),
                    Text("Registrar com",
                        style: TextStyle(
                            color: Colors.blue[600],
                            fontSize: 16.0,
                            fontFamily: "Poppins-Medium")),
                    horizontalLine()
                  ],
                ),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(40),
                ),
                _showSocialLogin(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _showActionsSigin() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Container(
            alignment: Alignment.center,
            width: ScreenUtil.getInstance().setWidth(330),
            height: ScreenUtil.getInstance().setHeight(100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.blue[600], Colors.blue[300]]),
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
                  child: Text("CADASTRAR",
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

  Widget _showRegisterForm() {
    return RegisterForm(
      emailController,
      passwordController,
      confirmPasswordController,
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
        backgroundColor: Colors.blue[600],
      ));
    }
    return Container(
      height: 0.0,
      width: 0.0,
    );
  }

  void toggleFormMode() {
    Navigator.of(context).pop();
  }

  void _showVerifyEmailSentDialog(String email) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Oi mana, falta bem pouquinho!"),
          content:
              new Text("Um link de confirmação foi enviando para " + email),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Entendi"),
              onPressed: () {
                toggleFormMode();
                Navigator.of(context).pop("/");
              },
            ),
          ],
        );
      },
    );
  }
}
