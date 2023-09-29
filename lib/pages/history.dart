import 'package:my_cash_book/style.dart';
import 'package:my_cash_book/format.dart';
import 'package:my_cash_book/dbHelper.dart';
import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({Key? key}) : super(key: key);

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<Map<String, dynamic>> _transactions = [];

  void _refreshTransactions() async {
    final data = await DbHelper.fetchTransactions();
    setState(() {
      _transactions = data;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Cashflow'),
        backgroundColor: greyColor,
      ),
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
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 8.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 16,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    _transactions[index]['description'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    _transactions[index]['date'],
                                    style: const TextStyle(
                                      color: greyColor,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                _transactions[index]['category'] == 'income'
                                    ? Icons.add
                                    : Icons.remove,
                                size: 20,
                                color:
                                    _transactions[index]['category'] == 'income'
                                        ? successColor
                                        : dangerColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: Text(
                                  'Rp',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: _transactions[index]['category'] ==
                                            'income'
                                        ? successColor
                                        : dangerColor,
                                  ),
                                ),
                              ),
                              Text(
                                Format.convertToIdr(
                                    _transactions[index]['nominal'], 0),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: _transactions[index]['category'] ==
                                          'income'
                                      ? successColor
                                      : dangerColor,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  itemCount: _transactions.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: greyColor,
                      indent: 12,
                      endIndent: 12,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
