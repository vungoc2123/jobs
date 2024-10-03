import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phu_tho_mobile/domain/models/response/profile.dart';
import 'package:phu_tho_mobile/presentation/screens/candidate/list_candidate/bloc/list_candidate_state.dart';

class ListCandidateCubit extends Cubit<ListCandidateState> {
  ListCandidateCubit() : super(const ListCandidateState());

  Future<void> getProfiles() async {
    final String response =
        await rootBundle.loadString('assets/json/profile.json');
    List<dynamic> data = await json.decode(response);
    List<ProfileModel> list = data
        .map((e) => ProfileModel.fromJson(e as Map<String, dynamic>))
        .toList();
    emit(state.copyWith(profiles: list));
  }
}
