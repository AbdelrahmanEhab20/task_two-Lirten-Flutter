// import 'dart:core';

import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class SecondScreenShowData extends StatefulWidget {
  static const routeName = '/blue-page';

  @override
  State<SecondScreenShowData> createState() =>
      _SecondScreenShowDataReceiverState();
}

class _SecondScreenShowDataReceiverState extends State<SecondScreenShowData> {
  String? nameReceiver;
  int? amountTransfer;
  int? bankAcc;

  var _loadInitData = false;
  @override
  void didChangeDependencies() {
    if (_loadInitData == false) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      amountTransfer = routeArgs['amountTransfer'];
      nameReceiver = routeArgs['nameReceiver'];
      bankAcc = routeArgs['bankAcc'];
      GetRecieverData();
      GEtSenderData();
    }

    _loadInitData = true;
    super.didChangeDependencies();
  }

//calling API---> Get Reciever Data
  Map ReceiverData = {};
  Future<void> GetRecieverData() async {
    final urlCallServer =
        Uri.http('192.168.0.163:8000', '/persons/byName/${nameReceiver}');
    final response = await http.get(urlCallServer);
    final ExtractedData = json.decode(response.body);
    print(ExtractedData);
    setState(() {
      ReceiverData = ExtractedData;
    });
  }

//calling API---> Get Sender Data
  final urlCallServer =
      Uri.http('192.168.0.163:8000', '/persons/62af2ee318eebeed601ef707');
  Map SenderData = {};
  Future<void> GEtSenderData() async {
    final response = await http.get(urlCallServer);
    final ExtractedData = json.decode(response.body);
    setState(() {
      SenderData = ExtractedData;
    });
  }

  final urlCallServerNew =
      Uri.http('192.168.0.163:8000', '/persons/finish-Transfer');
  Future<void> FinishTransferRequest() async {
    final response = await http.post(urlCallServerNew,
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'amountTransfer': amountTransfer,
          'idSender': SenderData['_id'],
          'idReceiver': ReceiverData['_id']
        }));
    final ExtractedResponse = json.decode(response.body);
    print(ExtractedResponse);
    if (ExtractedResponse['Receiver Cash'] != null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Transfer Process Done Successfully \n--------------------------------------',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.w900),
                ),
                content: Text(
                    "Receiver Name: ${ReceiverData['firstName']} ${ReceiverData['lastName']}\n -----------------------\n Receiver Cash After Update: ${ExtractedResponse['Receiver Cash']}",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w900)),
                actions: [
                  TextButton(
                      child: Text('OK'),
                      onPressed: (() {
                        Navigator.of(ctx).pushReplacementNamed('/');
                      }))
                ],
              ));
    } else {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text(
                  'Transfer Suspended',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
                ),
                content: Text(ExtractedResponse['error']),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: (() => Navigator.of(ctx).pop()),
                  )
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(22, 27, 69, 1),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(22, 27, 69, 1),
          elevation: 0,
          title: Image.asset(
            'assets/images/LogoPixelFrame.png',
            width: 140,
            height: 120,
          ),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          width: 350,
          height: 700,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 40),
                  child: Center(
                    child: Text(
                      "Are you sure you want to transfer?",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 40),
                        child: Text(
                          'From',
                          style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      SenderData == {}
                          ? CircularProgressIndicator()
                          : Container(
                              width: 195,
                              child: ListTile(
                                title: Text(
                                  '${SenderData['firstName']} ${SenderData['lastName']}',
                                  style: TextStyle(
                                      fontSize: 18,

                                      // fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                                subtitle: Text(
                                  '# ${SenderData['bankAccount']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 50),
                        child: Text(
                          'To',
                          style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      ReceiverData == {}
                          ? CircularProgressIndicator()
                          : Container(
                              width: 195,
                              child: ListTile(
                                title: Container(
                                  // margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    '${ReceiverData['firstName']} ${ReceiverData['lastName']}',
                                    style: TextStyle(
                                        fontSize: 18,
                                        // fontWeight: FontWeight.w800,
                                        color: Colors.white),
                                  ),
                                ),
                                subtitle: Text(
                                  '# ${ReceiverData['bankAccount']}',
                                  style: TextStyle(
                                      fontSize: 16,
                                      // fontWeight: FontWeight.w800,
                                      color: Colors.white),
                                ),
                              )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Amount',
                          style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          width: 195,
                          child: ListTile(
                            title: Text(
                              'EGP ${amountTransfer}',
                              style: TextStyle(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Date',
                          style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          width: 195,
                          child: ListTile(
                            title: Text(
                              "${DateFormat.yMMMEd().format(DateTime.now())}",
                              style: TextStyle(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 85,
                        child: Text(
                          'Note',
                          style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.normal,
                              color: Colors.white),
                        ),
                      ),
                      Container(
                          width: 195,
                          child: ListTile(
                            title: Text(
                              'This process will be finished after press Confirm ',
                              style: TextStyle(
                                  fontSize: 18,
                                  // fontWeight: FontWeight.w800,
                                  color: Colors.white),
                            ),
                          )),
                    ],
                  ),
                ),
                Container(
                  // color: Color(0xFF161B45),
                  margin: EdgeInsets.symmetric(vertical: 25),
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  width: 370,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      end: Alignment.topRight,
                      begin: Alignment.bottomLeft,
                      colors: [
                        Color(0xFFD393EF),
                        Color(0xFF2BD4FB),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(30.5),
                  ),
                  child: TextButton(
                    onPressed: () {
                      FinishTransferRequest();
                    },
                    child: Text(
                      'CONFIRM',
                      style: TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 255, 255, 255),
                          fontFamily: 'Avenir LT Std'),
                    ),
                  ),
                ),
                RadiantGradientMask(
                  child: Container(
                    // color: Color(0xFF161B45),
                    margin: EdgeInsets.symmetric(vertical: 15),
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    width: 370,
                    height: 42,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Color.fromARGB(255, 191, 187, 187)),
                      borderRadius: BorderRadius.circular(30.5),
                    ),
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed('/');
                      },
                      child: Text(
                        'CANCEL',
                        style: TextStyle(
                            fontSize: 18,
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontFamily: 'Avenir LT Std'),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Lorem ipsum dolor sit consectetur adipiscingLorem ipsum dolor sit.
class RadiantGradientMask extends StatelessWidget {
  RadiantGradientMask({required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => RadialGradient(
        center: Alignment.center,
        radius: 0.5,
        colors: [
          Color(0xFFD393EF),
          Color(0xFF2BD4FB),
        ],
        tileMode: TileMode.mirror,
      ).createShader(bounds),
      child: child,
    );
  }
}
