import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';


part 'payment_states.dart';

class PaymentCubitCubit extends Cubit<PaymentStates> {
  PaymentCubitCubit() : super(PaymentCubitInitial());
}
