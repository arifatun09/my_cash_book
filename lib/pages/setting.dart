import 'package:my_cash_book/pages/login.dart';
import 'package:my_cash_book/style.dart';
import 'package:my_cash_book/dbHelper.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  final int? userId;

  const Setting({Key? key, this.userId}) : super(key: key);

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();

  String errorMessage = '';
  var oldPasswordColor = greyColor;
  var newPasswordColor = greyColor;

  void _refreshScreen(
      String errorMessage, var oldPasswordColor, var newPasswordColor) async {
    setState(() {
      this.errorMessage = errorMessage;
      this.oldPasswordColor = oldPasswordColor;
      this.newPasswordColor = newPasswordColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pengaturan'),
        backgroundColor: greyColor,
      ),
      backgroundColor: greyColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: whiteColor,
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        bottom: 16,
                      ),
                      child: Text(
                        'Ganti Password',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: oldPasswordColor,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: greyColor,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _oldPasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: oldPasswordColor,
                          ),
                          hintText: 'Password lama',
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: newPasswordColor,
                        ),
                      ),
                      child: TextFormField(
                        obscureText: true,
                        cursorColor: greyColor,
                        keyboardType: TextInputType.visiblePassword,
                        controller: _newPasswordController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          icon: Icon(
                            Icons.lock,
                            color: newPasswordColor,
                          ),
                          hintText: 'Password baru',
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await _changePassword();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: greyColor,
                        ),
                        margin: const EdgeInsets.only(top: 12),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Simpan',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Center(
                        child: Text(
                          errorMessage,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: dangerColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Login(),
                          ),
                          (route) => false,
                        )
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: dangerColor,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 28,
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Logout',
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            'assets/img/myphoto.png',
                            width: 144,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Padding(
                              padding: EdgeInsets.only(
                                bottom: 16,
                              ),
                              child: Text(
                                'About this App..',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Aplikasi ini dibuat oleh:',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Nama: Arifatun Nisa'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('NIM: 214176118'),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text('Tanggal: 29 September 2023'),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _changePassword() async {
    var state = await DbHelper.changePassword(
      int.parse(widget.userId.toString()),
      _oldPasswordController.text,
      _newPasswordController.text,
    );

    if (state) {
      _refreshScreen('', greyColor, greyColor);
    } else if (_oldPasswordController.text == '' &&
        _newPasswordController.text == '') {
      _refreshScreen('Semua field harus di isi!', dangerColor, dangerColor);
    } else if (_oldPasswordController.text == '') {
      _refreshScreen('Password lama harus di isi!', dangerColor, greyColor);
    } else if (_newPasswordController.text == '') {
      _refreshScreen('Password baru harus di isi!', greyColor, dangerColor);
    } else {
      _refreshScreen('Password lama salah', dangerColor, greyColor);
    }
  }
}
