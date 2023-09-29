import 'package:my_cash_book/pages/dashboard.dart';
import 'package:my_cash_book/dbHelper.dart';
import 'package:my_cash_book/style.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String errorMessage = '';
  var usernameColor = greyColor;
  var passwordColor = greyColor;

  void _refreshScreen(
      String errorMessage, var usernameColor, var passwordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.usernameColor = usernameColor;
      this.passwordColor = passwordColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double defaultLoginSize = size.height - (size.height * 0.2);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            width: size.width,
            height: defaultLoginSize,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/img/icon.png',
                  width: 190,
                  height: 155,
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'My Cash Book',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: greyColor,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: 30,
                  ),
                  child: Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          // color: const Color(0xFFD6E4FF).withAlpha(144),
                          border: Border.all(
                            color: greyColor,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: greyColor,
                          keyboardType: TextInputType.text,
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.person,
                              color: greyColor,
                            ),
                            hintText: 'Username',
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(32),
                          // color: const Color(0xFFD6E4FF).withAlpha(144),
                          border: Border.all(
                            color: greyColor,
                          ),
                        ),
                        child: TextFormField(
                          cursorColor: greyColor,
                          keyboardType: TextInputType.visiblePassword,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              Icons.lock,
                              color: greyColor,
                            ),
                            hintText: 'Password',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () async {
                          await _login();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: greyColor,
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 16),
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          alignment: Alignment.center,
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: whiteColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.25,
                            ),
                          ),
                        ),
                      ),
                      Text(
                        errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: dangerColor,
                          fontWeight: FontWeight.w600,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    var state = await DbHelper.login(
      _usernameController.text,
      _passwordController.text,
    );

    if (state.isNotEmpty) {
      _refreshScreen('', greyColor, greyColor);
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Dashboard(
            userId: state[0]['id'],
          ),
        ),
        (route) => false,
      );
    } else if (_usernameController.text == '' &&
        _passwordController.text == '') {
      _refreshScreen(
          'Username dan password harus di isi!', dangerColor, dangerColor);
    } else if (_usernameController.text == '') {
      _refreshScreen('Username harus di isi!', dangerColor, greyColor);
    } else if (_passwordController.text == '') {
      _refreshScreen('Password harus di isi!', greyColor, dangerColor);
    } else {
      _refreshScreen(
        'Username atau Password Salah',
        greyColor,
        greyColor,
      );
    }
  }
}
