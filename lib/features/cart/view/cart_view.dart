import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';
import 'package:hungry/features/cart/widgets/cart_item.dart';
import 'package:hungry/features/checkout/view/checkout_view.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';

class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  late List<int> quantities;
  bool isLoading = false;
  bool isLoadingRemove = false;
  bool isGuest = false;
  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;
  Future<void> autoLogin() async {
    final user = await authRepo.autoLogin();
    setState(() => isGuest = authRepo.isGuest);
    if (user != null) setState(() => userModel = user);
  }

  CartRepo cartRepo = CartRepo();
  GetCartResponse? cartResponse;
  Future<void> getCartData() async {
    try {
      setState(() => isLoading = true);
      final response = await cartRepo.getCartData();
      final itemCount = response?.cartData.items.length ?? 0;
      setState(() {
        cartResponse = response;
        quantities = List.generate(itemCount, (_) => 1);
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = true);
      print(e.toString());
    }
  }

  Future<void> removeCartItem(int id) async {
    try {
      setState(() => isLoadingRemove = true);
      await cartRepo.removeCardItem(id);
      getCartData();
      setState(() => isLoadingRemove = false);
    } catch (e) {
      setState(() => isLoadingRemove = false);
      print(e.toString());
    }
  }

  @override
  void initState() {
    getCartData();
    autoLogin();
    super.initState();
  }

  void onAdd(int index) {
    setState(() {
      quantities[index]++;
    });
  }

  void onMin(int index) {
    setState(() {
      if (quantities[index] > 1) {
        quantities[index]--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (!isGuest) {
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: 30,
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          elevation: 0,
          leading: SizedBox.shrink(),
          centerTitle: true,
          title: CustomText(
            text: 'My Cart',
            color: Colors.black87,
            weight: FontWeight.w600,
            size: 20,
          ),
        ),
        body: isLoading
            ? Center(child: CupertinoActivityIndicator())
            : Stack(
                clipBehavior: Clip.none,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListView.builder(
                      clipBehavior: Clip.none,
                      padding: const EdgeInsets.only(bottom: 140, top: 10),
                      itemCount: cartResponse!.cartData.items.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        final item = cartResponse!.cartData.items[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 10,
                                  offset: const Offset(3, 3),
                                  color: Colors.black.withOpacity(0.2),
                                ),
                              ],
                            ),
                            child: CartItem(
                              image: item.image,
                              text: item.name,
                              desc: 'Spicy${item.spicy}',
                              number: quantities[index],
                              onAdd: () => onAdd(index),
                              onMin: () => onMin(index),
                              onRemove: () {
                                removeCartItem(item.itemId);
                              },
                              isLoading: isLoadingRemove,
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  // Floating total bar
                  Positioned(
                    right: -10,
                    left: -10,
                    bottom: -20,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.8),
                            AppColors.primary.withOpacity(0.8),
                            AppColors.primary,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(30),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.9),
                        //     blurRadius: 3,
                        //     offset: const Offset(2, 3),
                        //   ),
                        //   BoxShadow(
                        //     color: Colors.black.withOpacity(0.9),
                        //     blurRadius: 800,
                        //     offset: const Offset(300, 50),
                        //   ),
                        // ],
                      ),
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 20,
                      ),
                      child: Column(
                        children: [
                          Gap(8),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CheckoutView(
                                  totalPrice: cartResponse!.cartData.totalPrice,
                                ),
                              ),
                            ),
                            child: CustomButton(
                              height: 45,
                              text: 'Checkout',
                              gap: 80,
                              widget: CustomText(
                                text:
                                    '${cartResponse?.cartData.totalPrice}\$' ??
                                    '0.0',
                                size: 14,
                              ),
                              color: Colors.white,
                              width: double.infinity,
                              textColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      );
    } else if (isGuest) {
      return Center(child: CustomText(text: 'Please Login'));
    }
    return SizedBox.shrink();
  }
}
