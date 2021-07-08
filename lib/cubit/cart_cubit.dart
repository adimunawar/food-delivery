import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodmarket/models/models.dart';
import 'package:foodmarket/services/services.dart';
part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  Future<void> addToCart(CartModel cartModel) async {
    bool cekUser = await CartServices.cekCurrentfood(cartModel);

    if (cekUser == false) {
      ApiReturnValue<List<CartModel>> result =
          await CartServices.submitCart(cartModel);
      emit(CartCubitLoaded(result.value));
    } else {
      emit(CartCubitLoadingFailed('sudah ada'));
    }
  }
}
