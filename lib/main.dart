import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart' as flc;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videalpha/Approute/Approuting.dart';
import 'package:videalpha/auth_cubit/cubit/auth_cubit_cubit.dart';
import 'package:videalpha/firebaseAuthRepository/FireaseauthRepository.dart';
import 'package:videalpha/firebaseAuthRepository/profile_repository.dart';
import 'package:videalpha/mangae_profile_cubit/mangae_profile_cubit_cubit.dart';
import 'package:videalpha/setupgetIt/setup_getIt.dart';

import 'Profile_Cubit/profile_cubit_cubit.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseApp app = await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  print('Initialized default app $app');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
            create: (context) => FireaseauthRepository(
                auth: FirebaseAuth.instance, context: context)),
        RepositoryProvider(
          create: (context) =>
              ProfileRepository(firebaseFirestore: FirebaseFirestore.instance),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthCubitCubit>(
              create: (context) => AuthCubitCubit(
                  fireaseauthRepository: context.read<FireaseauthRepository>(),
                  context: context)),
          BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(
                profileRepository: context.read<ProfileRepository>()),
            child: Container(),
          ),
          BlocProvider<MangaeProfileCubitCubit>(
              create: (context) => MangaeProfileCubitCubit(
                  profileRepository: context.read<ProfileRepository>(),
                  context: context)),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          supportedLocales: flc.supportedLocales.map((e) => Locale(e)),
          localizationsDelegates: const [
            // Package's localization delegate.
            flc.CountryLocalizations.delegate,
          ],
          onGenerateRoute: ApppRoute,
        ),
      ),
    );
  }
}
