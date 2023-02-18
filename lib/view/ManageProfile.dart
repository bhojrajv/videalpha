import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validators/validators.dart';
import 'package:videalpha/mangae_profile_cubit/mangae_profile_cubit_cubit.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({super.key});

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  TextEditingController passwrodController = new TextEditingController();
  String? email;
  String? contact;
  String? name;
  String? dob;

  _submit() {
    setState(() {
      autovalidateMode = AutovalidateMode.always;
    });
    final form = form_key.currentState;
    if (form == null || !form.validate()) return;
    form.save();
    print("email,password:${email}/${dob}");
    context.read<MangaeProfileCubitCubit>().mangeprofile(
        name: name ?? "",
        email: email ?? "",
        age: "",
        dob: dob ?? "",
        contact: contact ?? "",
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MangaeProfileCubitCubit, ManageProfileCubit>(
      builder: (context, state) {
        debugPrint("status****${state.manageProfilestatus}");
        return Scaffold(
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
                child: ListView(
                  reverse: true,
                  children: [
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text("Name"),
                          prefixIcon: Icon(Icons.person),
                          border: OutlineInputBorder(),
                          filled: true),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Name is required";
                        }

                        return null;
                      },
                      onSaved: (String? value) {
                        name = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      decoration: InputDecoration(
                          label: Text("Email"),
                          prefixIcon: Icon(Icons.email),
                          border: OutlineInputBorder(),
                          filled: true),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Email is required";
                        }
                        if (!isEmail(value.trim())) {
                          return "Enter valid email";
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        email = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      controller: passwrodController,
                      autocorrect: false,
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("Contact"),
                          prefixIcon: Icon(Icons.phone),
                          border: OutlineInputBorder(),
                          filled: true),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "contact is required";
                        }
                        if (value.trim().length < 10) {
                          return "contact must be at least 6 characters";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        contact = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      autocorrect: false,
                      obscureText: false,
                      decoration: InputDecoration(
                          label: Text("DOB"),
                          prefixIcon: Icon(Icons.calendar_month),
                          border: OutlineInputBorder(),
                          filled: true),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return "dob  is required";
                        }

                        return null;
                      },
                      onSaved: (String? value) {
                        dob = value;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    ElevatedButton(
                      onPressed: _submit,
                      child: Text(state.manageProfilestatus ==
                              ManageProfilestatus.submitting
                          ? "Please wait"
                          : "Submit"),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ].reversed.toList(),
                ),
                autovalidateMode: autovalidateMode,
                key: form_key),
          ),
        );
      },
    );
    ;
  }
}
