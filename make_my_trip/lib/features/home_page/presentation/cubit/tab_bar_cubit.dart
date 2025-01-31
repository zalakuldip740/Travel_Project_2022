import 'package:bloc/bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:meta/meta.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../user/domain/usecases/is_anonymous_user.dart';

class TabBarCubit extends Cubit<BaseState> {
  TabBarCubit({required this.isAnonymousUser}) : super(StateInitial()) {
    checkAnonymous(0);
  }

  final IsAnonymousUser isAnonymousUser;

  checkAnonymous(index) async {
    print(index);
    final res = await isAnonymousUser.call(NoParams());
    res.fold((failure) {
      print(failure);
    }, (success) {
      print(success);
      if (success) {
        print(index);
        if (index != 0) {
          emit(Unauthenticated());
        } else {
          emit(StateOnSuccess<int>(index));
        }
      } else {
        emit(StateOnSuccess<int>(index));
      }
    });

    return index;
  }
}
