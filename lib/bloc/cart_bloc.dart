import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:foodmarket/models/models.dart';
import 'package:foodmarket/services/services.dart';
part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartBlocState> {
  CartBloc() : super(CartInitial());

  @override
  Stream<CartBlocState> mapEventToState(
    CartEvent event,
  ) async* {
    if (event is AddToCart) {
      try {
        bool cekUser = await CartServices.cekCurrentfood(event.productCart);
        if (cekUser == false) {
          ApiReturnValue<List<CartModel>> result =
              await CartServices.submitCart(event.productCart);
          yield CartLoaded(result.value);
        } else {
          yield CartLoadingFailed('gagal data tos aya');
        }
      } catch (e) {
        print(e);
      }

      //   ApiReturnValue<List<CartModel>> result =
      //       await CartServices.submitCart(event.productCart);
      //   if (result.value != null) {
      //     yield CartLoaded(result.value);
      //   }
      // } else if (event is RemoveCart) {
      //   yield* _mapAddEventToRemoveState(event);
      // }
    } else if (event is GetCart) {
      ApiReturnValue<List<CartModel>> result = await CartServices.getCart();

      if (result.value != null) {
        yield CartLoaded(result.value);
      } else {
        yield CartLoadingFailed(result.message);
      }
    }

    // Stream<CartState> _mapAddEventToAddState(event) async* {
    //   // yield GetProductLoading();

    //   String cekCurrentFood =
    //       await CartServices.cekCurrentfood(event.productCart);
    //   if (cekCurrentFood == "tidak") {
    //     ApiReturnValue<List<CartModel>> result =
    //         await CartServices.submitCart(event.productCart);
    //     if (result.value != null) {
    //       yield CartLoaded(result.value);
    //     }
    //     yield CartLoaded(result.value);
    //   } else {
    //     yield CartLoadingFailed('Product sudah ada di keranjang');
    //   }
    // }
    // int index = cartProduct.indexWhere((i) => i.id == event.productCart.id);
    // if (index != -1) {
    //   updateProduct(event.productCart, event.productCart.qty + 1);
// }

// Stream<CartState> _mapAddEventToRemoveState(event) async* {
//   yield GetProductLoading();
//   // await Future.delayed(Duration(seconds: 1));
//   // int index = cartProduct.indexWhere((i) => i.id == event.productCart.id);
//   // if (index >= 1) {
//   //   updateProduct(event.productCart, event.productCart.qty - 1);
//   // } else {
//   //   removeProduct(event.productCart);
//   // }
//   // yield ProductLoaded(cartProduct);
  }
}
