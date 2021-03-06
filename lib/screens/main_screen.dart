import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MainHeaderWalletWidget extends StatefulWidget {
  @override
  State<MainHeaderWalletWidget> createState() => _MainHeaderWalletWidgetState();
}

class _MainHeaderWalletWidgetState extends State<MainHeaderWalletWidget> {
  final numberFormat = new NumberFormat("##,##0", "en_US");

//calling API---> Get Sender Data
  final urlCallServer =
      Uri.http('192.168.0.163:8000', '/persons/62af2ee318eebeed601ef707');
  var SenderMoney = 0;
  Future<void> GEtData() async {
    final response = await http.get(urlCallServer);
    final ExtractedData = json.decode(response.body);
    setState(() {
      SenderMoney = ExtractedData['amount'];
    });
    print(SenderMoney);
  }

  @override
  void initState() {
    GEtData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: Stack(
            children: [
              Stack(children: [
                Stack(children: [
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(bottom: 10),
                    width: 400,
                    height: 200,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Color.fromRGBO(211, 148, 239, 1),
                            Color.fromRGBO(133, 178, 245, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50))),
                    child: Container(
                      height: 80,
                      margin: EdgeInsets.only(top: 60),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Wallet',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          (SenderMoney == 0)
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  'EGP ${numberFormat.format(SenderMoney)}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w900),
                                ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ]),
              Container(
                margin: EdgeInsets.only(top: 70),
                child: SvgPicture.asset(
                  'assets/images/Vector.svg',
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(left: 10, top: 30, bottom: 30),
          alignment: Alignment.topLeft,
          child: Text(
            'Transfer',
            style: TextStyle(
              color: Color.fromRGBO(22, 27, 69, 1),
              fontSize: 30,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
      ],
    );
  }
}
