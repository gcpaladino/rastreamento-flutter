import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mana/screens/login/recovery/components/recovery_form.dart';
import 'package:mana/services/auth_service.dart';

class RecoveryAccountScreen extends StatefulWidget {
  final BaseAuth auth;

  RecoveryAccountScreen({@required this.auth});

  @override
  _RecoveryAccountScreenState createState() => _RecoveryAccountScreenState();
}

class _RecoveryAccountScreenState extends State<RecoveryAccountScreen> {
  TextEditingController emailController = TextEditingController();

  final _formKey = new GlobalKey<FormState>();

  bool _isLoading;

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
      _isLoading = true;
    });
    if (validateAndSave()) {
      _sendRecovery();
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _sendRecovery() {
    try {
      widget.auth.sendRecoveryAccount(emailController.text);
      _showVerifyEmailSentDialog(emailController.text);
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _formKey.currentState.reset();
      });
    }
  }

  @override
  void initState() {
    _isLoading = false;
    super.initState();
  }

  void resetForm() {
    _formKey.currentState.reset();
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
        backgroundColor: Colors.blue[600],
        title: Text("Recuperação de senha",
            style: TextStyle(
                color: Colors.white,
                fontSize: 16.0,
                fontFamily: "Poppins-Medium")),
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
                SizedBox(height: ScreenUtil.getInstance().setHeight(10)),
                _showRegisterForm(),
                SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                _showActionsSigin(),
                SizedBox(
                  height: ScreenUtil.getInstance().setHeight(40),
                ),
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
                  child: Text("RECUPERAR",
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

  Widget _showRegisterForm() {
    return new RecoveryForm(
      emailController,
    );
  }

  Widget _showCircularProgress() {
    if (_isLoading) {
      return Center(
          child: CircularProgressIndicator(
        backgroundColor: Colors.purple[800],
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
          title: new Text("Oi mana, verifique seu email!"),
          content: new Text(
              "Um link de recuperação de conta foi enviando para " + email),
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
