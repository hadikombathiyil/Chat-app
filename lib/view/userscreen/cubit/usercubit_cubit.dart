import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'usercubit_state.dart';

class UsercubitCubit extends Cubit<UsercubitState> {
  UsercubitCubit() : super(UsercubitInitial());
}
