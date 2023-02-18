import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:videalpha/Profile_Cubit/profile_cubit_state.dart';

import '../customerror.dart';
import '../firebaseAuthRepository/profile_repository.dart';
import '../model/user_model.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepository profileRepository;
  ProfileCubit({
    required this.profileRepository,
  }) : super(ProfileState.initial());

  Future<void> getprofile2({required String uid}) async {
    emit(state.copyWith(profilestatus: Profilestatus.loading));
    try {
      final User user = await profileRepository.getprofile(uid: uid);
      emit(state.copyWith(profilestatus: Profilestatus.loaded, user: user));
    } on CustomError catch (e) {
      emit(state.copyWith(customError: e, profilestatus: Profilestatus.error));
    }
  }
}
