import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'sqf_lite_state.dart';

class SqfLiteCubit extends Cubit<SqfLiteState> {
  SqfLiteCubit() : super(SqfLiteInitial());
}
