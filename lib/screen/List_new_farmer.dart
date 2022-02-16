import 'package:flutter/material.dart';
import '../constant/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class NewCustomer {
  final String? CustName;
  final String? CustAddress;
  final String? CustPhone;
  final String? State;
  final String? City;
  final String? PAN;
  final String? AADHAR;
  final String? GSTIN;
  NewCustomer(
      {this.CustName,
      this.CustAddress,
      this.CustPhone,
      this.State,
      this.City,
      this.PAN,
      this.AADHAR,
      this.GSTIN});
}

class ListNewCustomer extends StatefulWidget {
  static const String id = 'ListNewFarmer';
  @override
  _ListNewCustomerState createState() => _ListNewCustomerState();
}

class _ListNewCustomerState extends State<ListNewCustomer> {
  List<NewCustomer> newCustomerList = [];

  void getListFarmaer() async {
    var url = Uri.http('117.240.18.180:3002',
        '/api/AreaCustomer/GetNewCustomer/$AreaCode', {'q': '{http}'});
    print(url);
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print('data');
      var data = convert.jsonDecode(response.body);
      for (var c in data) {
        setState(() {
          newCustomerList.add(NewCustomer(
            CustName: c["CustName"].toString(),
            CustAddress: c["CustAddress"].toString(),
            CustPhone: c["CustPhone"].toString(),
            State: c["State"].toString(),
            City: c["City"].toString(),
            PAN: c["PAN"].toString(),
            AADHAR: c["AADHAR"].toString(),
            GSTIN: c["GSTIN"].toString(),
          ));
        });

        // print(c["CustName"].toString());
      }
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getListFarmaer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List New Farmer'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              'Hello: $UserName   Area:$AreaName',
              style: TextStyle(fontSize: 19),
              textAlign: TextAlign.left,
            ),
            SizedBox(
              height: 5,
            ),
            Divider(
              height: 3,
              thickness: 1.5,
              color: Colors.blue,
            ),
            Expanded(child:   ListView.builder(
              itemBuilder: (context, index) => Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name:' + newCustomerList[index].CustName.toString()),
                    Text('Address:' + newCustomerList[index].CustAddress.toString()),
                    Text('Phone:' + newCustomerList[index].CustPhone.toString()),
                    Text('PAN:' + newCustomerList[index].PAN.toString()),
                    Divider(
                      height: 3,
                      thickness: 1.5,
                      color: Colors.blue,
                    ),
                    SizedBox(height: 5,)
                  ],
                ),
              ),
              itemCount: newCustomerList.length,
            ),
            ),

          ],
        ),
      ),
    );
  }
}
