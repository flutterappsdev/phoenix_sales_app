import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:open_whatsapp/open_whatsapp.dart';
import '../widgets/rounded_button.dart';
//import 'package:toast/toast.dart';
import '../network/network.dart';
import '../constant/constants.dart';
import '../screen/menu_sales_screen.dart';

class SaveSupply extends StatefulWidget {
  static const String id = 'SaveSupply';
  @override
  _SaveSupplyState createState() => _SaveSupplyState();
}

class _SaveSupplyState extends State<SaveSupply> {
  String? bd1, bd2 = '';
  String? _MobileNumber = '';
  String? _CCode = '';
  String? _CName = '';
  String? _dmNumber = '';
  String? _dmDate = 'TR/0000000/';
  String? _totalChicks = '';
  String? _trasnitMortality = '';
  String? _hdate = '';
  String? _ctype = '';
  String? _remarks = '';
  String? _rate = '';
  String? _hatchery = '';

  double height = 10;
  double fontSize = 18;
  bool _isSaved = false;

  getSupplyData() async {
    SharedPreferences shpSypply = await SharedPreferences.getInstance();

    setState(() {
      _CName = shpSypply.getString('customerName')!;
      _CCode = shpSypply.getString('customerCode');
      _MobileNumber = shpSypply.getString('mobile');
      _dmNumber = shpSypply.getString('dmno');
      _dmDate = shpSypply.getString('dmdate');
      _totalChicks = shpSypply.getString('totalchicks');
      _trasnitMortality = shpSypply.getString('transit_mortality');
      _hdate = shpSypply.getString('hatch_date');
      _hatchery = shpSypply.getString('hatchery');
      _ctype = shpSypply.getString('chicks_type');
      _rate = shpSypply.getString('rate');
      _remarks = shpSypply.getString('remark');
    });
  }

  void fetchDMNumber() async {
    try {
      Uri url = Uri.parse('$Url/GetDMNumber?AreaCode=$AreaCode');
      NetworkHelper networkHelper = NetworkHelper(url);
      var data = await networkHelper.getData();
      // print(data);
      setState(() {
        if (data['DmNo'].length > 0) {
          _dmNumber = data['DmNo'][0]['DmNo'];
          print('dmno' + _dmNumber!);
        } else {
          _dmNumber = '-';
        }
      });
    } catch (e) {
      print(e);
      setState(() {
        _dmNumber = '-';
      });
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    getSupplyData();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Save Supply'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: height,
              ),
              Row(
                children: [
                  Text(
                    _CCode!,
                    style: TextStyle(fontSize: fontSize),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: Text(
                      _CName!,
                      style: TextStyle(fontSize: fontSize),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Mobile:$_MobileNumber",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "DM:$_dmNumber",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "DM Date:$_dmDate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Hatch Date:$_hdate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Chick :$_ctype",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Total Chick :$_totalChicks",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Transit Mortality:$_trasnitMortality",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "Rate:$_rate",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "$_hatchery",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: height,
              ),
              Text(
                "$_remarks",
                style: TextStyle(fontSize: fontSize),
              ),
              SizedBox(
                height: 20,
              ),
              _isSaved ? Center(child: CircularProgressIndicator(strokeWidth: 2,))  : RoundedButton(
                  title: 'Save Supply',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      _isSaved =true;
                    });
                    var connectivityResult =
                        await Connectivity().checkConnectivity();
                    if (connectivityResult != ConnectivityResult.mobile &&
                        connectivityResult != ConnectivityResult.wifi) {
                      Fluttertoast.showToast(msg : "Please check Network Connectivity", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
                      return;
                    }


                    fetchDMNumber();
                    try {
                      Uri url =
                         Uri.parse('$Url/InsertDMData?AreaCode=$AreaCode&Area=$AreaName&DMNo=$_dmNumber&'
                      +
                      "DMDate=$_dmDate&HatchDate=$_hdate&uname=$UserName&Code=$_CCode&CName=$_CName&"
                      +
                      "Chick_type=$_ctype&"
                      +
                      "CihckRate=$_rate&Remarks=$_remarks&TotalChicks=$_totalChicks&Mortality=$_trasnitMortality&Hatchries=$_hatchery");
                      //print(url);
                      NetworkHelper networkHelper = NetworkHelper(url);
                      var data = await networkHelper.getData();
                        print(data);
                    } catch (e) {
                      print(e);
                    }
                    // showToast("Show Long Toast", duration: Toast.LENGTH_LONG);
                    Fluttertoast.showToast(msg : "Supply Information Saved...", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);

                    Navigator.of(context).pop();

                    try {

                      double freeper=0,free=0,chicks_qty=0,biiling_qty=0,amount = 0 ;
                      if (_ctype == 'Broiler')
                        {
                          freeper = 2;
                          free = (double.parse(_totalChicks.toString()) + double.parse(_trasnitMortality.toString())) * 2/102;
                          chicks_qty = (double.parse(_totalChicks.toString()) + double.parse(_trasnitMortality.toString())) ;
                          biiling_qty = (double.parse(_totalChicks.toString()) + double.parse(_trasnitMortality.toString())) - free;
                          amount = biiling_qty * double.parse(_rate.toString());
                        }
                      if (_ctype == 'Broiler(M)')
                      {
                        freeper = 2;
                      }
                      if (_ctype == 'Layer')
                      {
                        freeper = 5;
                      }
                      if (_ctype == 'Cockrel')
                      {
                        freeper = 0;
                      }

                      String _msg =
                          "Supplied $_ctype Chicks having Qty $_totalChicks With  ${freeper.toStringAsFixed(0)} , Final Qty ${biiling_qty.toStringAsFixed(0)} @ $_rate   amount ${amount.toStringAsFixed(0) } to $_CName  by DM $_dmNumber For Any Query Contact:9685043413 "  ;
                      List<String> recipents = [_MobileNumber!];
                      String _r = await sendSMS(
                          message: _msg, recipients: recipents);
                      //print(_r);
                      FlutterOpenWhatsapp.sendSingleMessage(
                         "91$_MobileNumber", _msg);
                    } catch (e) {
                      print(e);
                    }


                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SalesMenuGrid()),
                    );
                    SharedPreferences shpSypply =
                    await SharedPreferences.getInstance();
                    shpSypply.clear();
                  },),
              SizedBox(
                height: 5,
              ),
              RoundedButton(
                  title: 'Previous...',
                  colour: Colors.lightBlueAccent,
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          ),
        ),
      ),
    );
  }
}
