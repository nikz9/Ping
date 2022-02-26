import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;

import 'registerscreen.dart';
import '../HomeScreen/homescreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const routeName = '/Login';
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _validate = true;

  Future<void> _requestPermission() async {
    await [
      Permission.locationWhenInUse,
      Permission.microphone,
      Permission.contacts,
      Permission.storage,
    ].request();
  }

  Future<int> _loginAuth() async {
    var url = Uri.parse('http://10.0.2.2:3000/login');
    var response = await http.post(
      url,
      body: {'loginkey': _controller1.text, 'number': _controller2.text},
    );
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double sp = media.size.height > media.size.width
        ? media.size.height
        : media.size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(sp * 0.02),
                child: Text(
                  'PING',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sp * 0.05,
                  ),
                ),
              ),
              Container(
                //height: sp * 0.31,
                width: sp * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(width: sp * 0.001),
                  borderRadius: BorderRadius.circular(sp * 0.02),
                  color: Theme.of(context).backgroundColor,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.02,
                          right: sp * 0.01,
                          left: sp * 0.01,
                        ),
                        child: TextField(
                          controller: _controller1,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).iconTheme.color as Color,
                              ),
                            ),
                            hintText: '  Login-Key',
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                            errorText: _validate ? null : 'Invalid',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.03,
                          right: sp * 0.01,
                          left: sp * 0.01,
                        ),
                        child: TextField(
                          controller: _controller2,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).iconTheme.color as Color,
                              ),
                            ),
                            hintText: '  Registered-Number(With Country Code)',
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                            errorText: _validate ? null : 'Invalid',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.01,
                        ),
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              _validate = true;
                            });
                            if (await _loginAuth() == 200) {
                              await _requestPermission();
                              Navigator.of(context)
                                  .pushNamed(HomeScreen.routename);
                            } else {
                              setState(() {
                                _validate = false;
                              });
                            }
                          },
                          child: const Text('Login'),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.01,
                          bottom: sp * 0.02,
                        ),
                        child: GestureDetector(
                          child: const Text('So you forget the key again?!😑'),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (ctx) => const Recovery(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: sp * 0.01,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(RegisterScreen.routeName);
                  },
                  child: const Text('Register'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Recovery extends StatelessWidget {
  const Recovery({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final double sp = media.orientation == Orientation.portrait
        ? media.size.height
        : media.size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(sp * 0.02),
                child: Text(
                  'PING',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: sp * 0.05,
                  ),
                ),
              ),
              Container(
                height: sp * 0.17,
                width: sp * 0.4,
                decoration: BoxDecoration(
                  border: Border.all(width: sp * 0.001),
                  borderRadius: BorderRadius.circular(
                    sp * 0.02,
                  ),
                  boxShadow: const [BoxShadow(color: Colors.grey)],
                  color: Theme.of(context).backgroundColor,
                ),
                child: Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.02,
                          right: sp * 0.01,
                          left: sp * 0.01,
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    Theme.of(context).iconTheme.color as Color,
                              ),
                            ),
                            hintText: '  Registered number',
                            hintStyle: TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText2!.color,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: sp * 0.01,
                        ),
                        child: ElevatedButton(
                          child: const Text('CONFIRM'),
                          onPressed: () {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                duration: Duration(seconds: 5),
                                content: Text(
                                  'LOGIN-KEY sent to your Registered Number/Email',
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
