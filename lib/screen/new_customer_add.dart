import 'package:connectivity/connectivity.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../constant/constants.dart';
import 'dart:convert';

class NewCustomeradd extends StatefulWidget {
  static const id = 'NewCustomeradd';
  @override
  _NewCustomeraddState createState() => _NewCustomeraddState();
}

class _NewCustomeraddState extends State<NewCustomeradd> {
  GlobalKey<CSCPickerState> _cscPickerKey = GlobalKey();
  final GlobalKey<ScaffoldState> ScafoldKey = new GlobalKey<ScaffoldState>();

  final _custName = TextEditingController();
  final _custAddress = TextEditingController();
  final _custMobile = TextEditingController();
  final _custPAN = TextEditingController();
  final _custGST = TextEditingController();
  final _custAADHAR = TextEditingController();

  String? countryValue = "";
  String? stateValue = "";
  String? cityValue = "";
  String? address = "";
  bool _isSaved = false;

  void showSnackBar(String tittle) {
    final snackBar = SnackBar(
      content: Text(
        tittle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    ScafoldKey.currentState!.showSnackBar(snackBar);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ScafoldKey,
      appBar: AppBar(
        title: const Text("New Farmer"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:const  EdgeInsets.all(8),
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _custName,
                maxLength: 50,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  icon: Icon(Icons.person),
                  hintText: 'What do people call you?',
                  labelText: 'Customer Name *',
                ),
              ),
             const SizedBox(
                height: 3,
              ),
              TextFormField(
                controller: _custAddress,
                maxLines: 3,
                maxLength: 100,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  icon: Icon(Icons.add_location),
                  hintText: 'What is Address?',
                  labelText: 'Customer Address *',
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              TextFormField(
                controller: _custMobile,
                maxLength: 10,
                decoration: const InputDecoration(
                  icon: Icon(Icons.mobile_friendly),
                  hintText: 'Mobile/Phone?',
                  labelText: 'Mobile *',
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              TextFormField(
                controller: _custPAN,
                maxLength: 10,
                decoration: const InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  hintText: 'PAN?',
                  labelText: 'Customer PAN *',
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              TextFormField(
                controller: _custGST,
                maxLength: 16,
                decoration: const InputDecoration(
                  icon: Icon(Icons.confirmation_number),
                  hintText: 'GSTIN?',
                  labelText: 'Customer GST Number *',
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              TextFormField(
                controller: _custAADHAR,
                maxLength: 16,
                decoration: const InputDecoration(
                  icon: Icon(Icons.sports_baseball),
                  hintText: 'AADHAR?',
                  labelText: 'Customer AADHAR*',
                ),
              ),
              const SizedBox(
                height: 0,
              ),
              CSCPicker(
                ///Enable disable state dropdown [OPTIONAL PARAMETER]
                showStates: true,

                /// Enable disable city drop down [OPTIONAL PARAMETER]
                showCities: true,

                ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
                flagState: CountryFlag.ENABLE,

                ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
                dropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
                disabledDropdownDecoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.grey.shade300, width: 1)),

                ///placeholders for dropdown search field
                countrySearchPlaceholder: "Country",
                stateSearchPlaceholder: "State",
                citySearchPlaceholder: "City",

                ///labels for dropdown
                countryDropdownLabel: "*Country",
                stateDropdownLabel: "*State",
                cityDropdownLabel: "*City",

                ///Default Country
                defaultCountry: DefaultCountry.India,

                //Disable country dropdown (Note: use it with default country)
                disableCountry: true,

                selectedItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                ///DropdownDialog Heading style [OPTIONAL PARAMETER]
                dropdownHeadingStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),

                ///DropdownDialog Item style [OPTIONAL PARAMETER]
                dropdownItemStyle: const TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),

                ///Dialog box radius [OPTIONAL PARAMETER]
                dropdownDialogRadius: 10.0,

                ///Search bar radius [OPTIONAL PARAMETER]
                searchBarRadius: 10.0,

                onCountryChanged: (value) {
                  setState(() {
                    ///store value in country variable
                    countryValue = value;
                  });
                },

                onStateChanged: (value) {
                  setState(() {
                    ///store value in state variable
                    stateValue = value;
                  });
                },

                onCityChanged: (value) {
                  setState(() {
                    ///store value in city variable
                    cityValue = value;
                  });
                },
              ),
              const SizedBox(
                height: 10,
              ),
             _isSaved ?  const CircularProgressIndicator(strokeWidth:5,) : const Text(".")

            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var connectivityResult =
          await Connectivity().checkConnectivity();
          if (connectivityResult != ConnectivityResult.mobile &&
              connectivityResult != ConnectivityResult.wifi) {
            Fluttertoast.showToast(msg : "TNo internet connectivity", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
            return;
          }


          if (_custName.text.isEmpty) {
            showSnackBar('Please provide a valid Farmer name');
            return;
          }

          if (_custAddress.text.isEmpty) {
            showSnackBar('Please provide a valid Farmer address');
            return;
          }

          if (_custMobile.text.isEmpty) {
            showSnackBar('Please provide a valid Farmer mobile');
            return;
          }

          if (stateValue=="*State") {
            showSnackBar('Please provide a valid State');
            return;
          }

          if (cityValue=="*City") {
            showSnackBar('Please provide a valid City');
            return;
          }

          try {

            var uriResponse = await http.post(
               Uri.parse('http://117.240.18.180:3002/api/AreaCustomer'),
                headers: {"Content-type": "application/json"},
                body: jsonEncode({
                  "custName": _custName.text,
                  "custAddress": _custAddress.text,
                  "custPhone": _custMobile.text,
                  "state": stateValue,
                  "city": cityValue,
                  "pan": _custPAN.text,
                  "aadhar": _custAADHAR.text,
                  "gstin": _custGST.text,
                  "areaCode": AreaCode,
                  "area": AreaName,
                  "userName": UserName,
                  "entryDate": DateTime.now().toIso8601String()
                }));
            print( jsonDecode(uriResponse.body));
            print("2");


            Fluttertoast.showToast(msg : "Farmer Data Saved...", toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.CENTER);
            setState(() {
              _isSaved = true;
            });
            Navigator.pop(context);
          }
          catch(e){
            print(e.toString());
          }
          finally {

          }
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
