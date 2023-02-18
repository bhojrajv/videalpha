import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videalpha/Approute/Approuting.dart';
import 'package:videalpha/auth_cubit/cubit/auth_cubit_cubit.dart';

import '../Profile_Cubit/profile_cubit_cubit.dart';
import '../Profile_Cubit/profile_cubit_state.dart';
import '../constant/error_dialoge.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  String uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getprofile();
  }

  void _getprofile() {
    setState(() {
      uid = FirebaseAuth.instance.currentUser!.uid;
      print("userid:$uid");
    });

    context.read<ProfileCubit>().getprofile2(uid: uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        listener: (context, state) {
          // TODO: implement listener
          if (state.profilestatus == Profilestatus.error) {
            ErrorDialog(context, state.customError);
          }
        },
        builder: (context, state) {
          if (state.profilestatus == Profilestatus.initial) {
            return Container();
          }
          if (state.profilestatus == Profilestatus.loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.profilestatus == Profilestatus.error) {
            return Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.dangerous_sharp,
                      size: 30,
                      color: Colors.red,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, Nameroute.manageprofile);
                      },
                      child: Text(
                        "Opps Try Again",
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.0),
                      ),
                    )
                  ]),
            );
          }
          return Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 20.0,
                ),
                // Image.network(
                //   state.user.profileimage,
                //   height: 100,
                //   fit: BoxFit.cover,
                // ),
                // SizedBox(
                //   height: 10.0,
                // ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, Nameroute.manageprofile);
                  },
                  child: Row(
                    children: [
                      Text("Name: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15.0)),
                      Text(
                        "${state.user.name}",
                        style: TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text("email: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text(
                      "${state.user.email}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text("Contact: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text(
                      "${state.user.contact}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text("DOB: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text(
                      "${state.user.dob}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Text("id: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15.0)),
                    Text(
                      "${state.user.id}",
                      style: TextStyle(fontWeight: FontWeight.w500),
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
