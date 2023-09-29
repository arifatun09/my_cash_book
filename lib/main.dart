import 'package:flutter/material.dart';
import 'package:my_cash_book/pages/dashboard.dart';
import 'package:my_cash_book/pages/login.dart';
import 'package:my_cash_book/pages/income.dart';
import 'package:my_cash_book/pages/expanse.dart';
import 'package:my_cash_book/pages/history.dart';
import 'package:my_cash_book/pages/setting.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => const Login(),
      '/dashboar': (context) => const Dashboard(),
      '/income': (context) => const Income(),
      '/expense': (context) => const Expanse(),
      '/history': (context) => const History(),
      '/setting': (context) => const Setting(),
    },
  ));
}
