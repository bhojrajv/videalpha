import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:videalpha/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:videalpha/firebaseAuthRepository/FireaseauthRepository.dart';

import '../AuthProvider/Auth_provider.dart';
import '../setupgetIt/setup_getIt.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  String? phone_number;
  String? password;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  var countrycode = "+91";

  @override
  void initState() {
    // TODO: implement initState
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
    getIntanitateCountrypicker();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  FlCountryCodePicker getIntanitateCountrypicker() {
    final countryPicker = const FlCountryCodePicker(
      localize: true,
      showDialCode: true,
    );
    final countryPickerWithParams = const FlCountryCodePicker(
        localize: true,
        showDialCode: true,
        showFavoritesIcon: true,
        showSearchBar: true,
        favorites: ['+91'],
        filteredCountries: ["+91"],
        title: Text("+91"));
    return countryPicker;
  }

  _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = form_key.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print(
        "email,password:${countrycode + (phone_number ?? "")}/${countrycode}");

    debugPrint("code:${getIt<AuthProvider>().getcodesent}");
    getroute(countrycode + (phone_number ?? ""));
  }

  void getroute(String mobile_number) {
    FireaseauthRepository(context: context, auth: FirebaseAuth.instance);
    context
        .read<AuthCubitCubit>()
        .Authverification(phonenumber: mobile_number, context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubitCubit, AuthcubitState>(
      builder: (context, state) {
        debugPrint("status:${state.autthstatus}");
        return Scaffold(
          appBar: AppBar(
            title: const Text("Login page"),
          ),
          body: _connectionStatus == ConnectivityResult.none
              ? Center(child: Text("Please Check Netwrok Connection"))
              : Center(
                  child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Form(
                          child: ListView(
                            reverse: true,
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      // Show the country code picker when tapped.
                                      final code =
                                          await getIntanitateCountrypicker()
                                              .showPicker(context: context);
                                      setState(() {
                                        countrycode = code?.dialCode ?? "";
                                        phone_number =
                                            countrycode + (phone_number ?? "");
                                      });
                                      // Null check
                                      //if (code != null) print(code.dialCode);
                                    },
                                    child: Text(
                                      "${countrycode ?? "+91"}",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      keyboardType: TextInputType.number,
                                      autocorrect: false,
                                      decoration: InputDecoration(
                                          label: Text("Phone Number"),
                                          prefixIcon: Icon(Icons.phone),
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0))),
                                          filled: true),
                                      validator: (String? value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return "phone number is required";
                                        }

                                        return null;
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          phone_number = value;
                                        });
                                      },
                                      onSaved: (String? value) {
                                        phone_number = value;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              FractionallySizedBox(
                                widthFactor: .8,
                                child: Container(
                                  height: 40,
                                  color: Colors.blue,
                                  child: TextButton(
                                    onPressed: _submit,
                                    child: Text(
                                      state.autthstatus == Autthstatus.loading
                                          ? "please wait...."
                                          : "Sign In",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                            ].reversed.toList(),
                          ),
                          autovalidateMode: autovalidateMode,
                          key: form_key))),
        );
      },
    );
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      debugPrint('Couldn\'t check connectivity status::$e');
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }
}
