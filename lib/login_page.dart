import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ioteggincubatorapp/mqtt.dart';
import 'package:ioteggincubatorapp/pages/dashboard.dart';
import 'package:ioteggincubatorapp/pages/drawer.dart';
import 'package:mqtt_client/mqtt_client.dart';

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 120.0,
        child: Image.asset('assets/images/egg.jpg'),
      ),
    );

    final email = TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      // initialValue: 'larteyjoshua@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _passwordController,
      autofocus: false,
      // initialValue: '7f8a9110',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot Username and password? Check the device label?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    Future<void> _makeConnection() async {
      showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            content: Center(child: CircularProgressIndicator()),
          );
        },
      );
      final client = await Mqttwrapper.instance.initializemqtt(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      if ( Mqttwrapper.instance.client?.connectionStatus?.state ==
          MqttConnectionState.connected) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashBoard()),
        );
      } else {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            content: Text('Connection failed, Enter Your Details.'),
            action: SnackBarAction(
                label: 'OKAY',
                onPressed: () {
                  _scaffoldKey.currentState.removeCurrentSnackBar();
                }),
          ),
        );
        Navigator.pop(context);
      }
    }

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: RaisedButton(
        shape: StadiumBorder(),
        child: Text(
          Mqttwrapper.instance.client?.connectionStatus?.state ==
                  MqttConnectionState.connected
              ? 'Logout'
              : 'Login',
          style: TextStyle(color: Colors.white),
        ),
        color: Colors.deepOrange,
        onPressed: Mqttwrapper.instance.client?.connectionStatus?.state ==
                MqttConnectionState.connected
            ? () {
                Mqttwrapper.instance.client.disconnect();
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(
                    content: Text('Broker has been disconnected.'),
                    action: SnackBarAction(
                        label: 'OKAY',
                        onPressed: () {
                          _scaffoldKey.currentState.removeCurrentSnackBar();
                        }),
                  ),
                );
                setState(() {});
              }
            : () async {
                await _makeConnection();
              },
      ),
    );

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'MQTT Connection',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
//        elevation: 0.5,
      ),
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
//      drawer: drawer,
    );
  }
}
