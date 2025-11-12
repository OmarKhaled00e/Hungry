import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/constants/app_colors.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/cart/data/cart_model.dart';
import 'package:hungry/features/cart/data/cart_repo.dart';
import 'package:hungry/features/home/data/model/topping_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/product/widgets/spicy_slider.dart';
import 'package:hungry/features/product/widgets/topping_card.dart';
import 'package:hungry/shared/custom_button.dart';
import 'package:hungry/shared/custom_text.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ProductDetailsView extends StatefulWidget {
  const ProductDetailsView({
    super.key,
    required this.productImage,
    required this.productId, required this.productPrice,
  });
  final String productImage;
  final int productId;
  final String productPrice;

  @override
  State<ProductDetailsView> createState() => _ProductDetailsViewState();
}

class _ProductDetailsViewState extends State<ProductDetailsView> {
  double value = 0.5;
  List<int> selectedTopping = [];
  List<int> selectedOption = [];
  bool isLoading = false;

  List<ToppingModel?>? toppings;
  List<ToppingModel?>? options;

  ProductRepo productRepo = ProductRepo();
  Future<void> getToppings() async {
    final response = await productRepo.getTopping();
    setState(() {
      toppings = response;
    });
  }

  Future<void> getOptions() async {
    final res = await productRepo.getOptions();
    setState(() {
      options = res;
    });
  }

  // cart function
  CartRepo cartRepo = CartRepo();

  @override
  void initState() {
    getToppings();
    getOptions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: widget.productImage.isEmpty,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
          toolbarHeight: 18,
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_circle_left_outlined,
              size: 20,
              color: AppColors.primary,
            ),
          ),
        ),

        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpicySlider(
                  value: value,
                  img: widget.productImage,
                  onChanged: (v) => setState(() => value = v),
                ),

                const Gap(40),
                const CustomText(text: 'Toppings', size: 18),
                const Gap(10),

                // ======= Toppings Section =======
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (toppings ?? []).map((topping) {
                      final id = topping!.id ?? 1;
                      final isSelected = selectedTopping.contains(id);

                      return Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.green.withOpacity(0.2)
                              : AppColors.primary.withOpacity(0.1),
                          title: topping!.name,
                          imageUrl: topping!.image,
                          onAdd: () {
                            setState(() {
                              if (isSelected) {
                                selectedTopping.remove(id);
                              } else {
                                selectedTopping.add(id);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const Gap(25),
                const CustomText(text: 'Side Options', size: 18),
                const Gap(10),

                // ======= Side Options Section =======
                SingleChildScrollView(
                  clipBehavior: Clip.none,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: (options ?? []).map((option) {
                      final id = option!.id ?? 1;
                      final isSelected = selectedOption.contains(id);

                      return Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: ToppingCard(
                          color: isSelected
                              ? Colors.green.withOpacity(0.2)
                              : AppColors.primary.withOpacity(0.1),
                          imageUrl: option.image,
                          title: option.name,
                          onAdd: () {
                            setState(() {
                              if (isSelected) {
                                selectedOption.remove(id);
                              } else {
                                selectedOption.add(id);
                              }
                            });
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ),

                const Gap(200),
              ],
            ),
          ),
        ),

        bottomSheet: Container(
          height: 150,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.primary.withOpacity(0.7),
                AppColors.primary,
                AppColors.primary,
                AppColors.primary,
                AppColors.primary,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(30),
          ),

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Burger Price :',
                      size: 15,
                      color: Colors.white,
                    ),
                    CustomText(
                      text: '\$ ${widget.productPrice}' ?? '0.0',
                      size: 20,
                      color: Colors.white,
                      weight: FontWeight.w700,
                    ),
                  ],
                ),

                CustomButton(
                  widget: isLoading
                      ? CupertinoActivityIndicator(color: AppColors.primary)
                      : Icon(CupertinoIcons.cart_badge_plus),
                  gap: 10,
                  height: 48,
                  color: Colors.white,
                  textColor: AppColors.primary,
                  text: 'Add To Cart',
                  onTap: () async {
                    try {
                      setState(() => isLoading = true);
                      final cartItem = CartModel(
                        productId: widget.productId,
                        quantity: 1,
                        spicy: value,
                        toppings: selectedTopping,
                        options: selectedOption,
                      );
                      await cartRepo.addToCart(
                        CartRequestModel(items: [cartItem]),
                      );
                      setState(() => isLoading = false);

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added to cart successfully')),
                      );
                    } catch (e) {
                      setState(() => isLoading = false);

                      throw ApiError(message: e.toString());
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
