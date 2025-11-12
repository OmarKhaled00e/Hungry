import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hungry/core/network/api_error.dart';
import 'package:hungry/features/auth/data/auth_repo.dart';
import 'package:hungry/features/auth/data/user_model.dart';
import 'package:hungry/features/home/data/model/product_model.dart';
import 'package:hungry/features/home/data/repo/product_repo.dart';
import 'package:hungry/features/home/widgets/card_Item.dart';
import 'package:hungry/features/home/widgets/food_catgory.dart';
import 'package:hungry/features/home/widgets/search_field.dart';
import 'package:hungry/features/home/widgets/user_header.dart';
import 'package:hungry/features/product/view/product_details_view.dart';
import 'package:hungry/shared/custom_snack.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List category = ['All', 'Combo', 'Sliders', 'Classic'];
  int selectedIndex = 0;
  final TextEditingController controller = TextEditingController();
  List<ProductModel?> products = [];
  List<ProductModel?> allProducts = [];

  ProductRepo productRepo = ProductRepo();
  Future<void> getProducts() async {
    final response = await productRepo.getProduct();
    setState(() {
      allProducts = response;
      products = response;
    });
  }

  AuthRepo authRepo = AuthRepo();
  UserModel? userModel;

  /// get profile
  Future<void> getProfileData() async {
    try {
      final user = await authRepo.getProfileData();
      setState(() {
        userModel = user;
      });
    } catch (e) {
      String errorMsg = 'Error in Profile';
      if (e is ApiError) {
        errorMsg = e.message;
      }
      ScaffoldMessenger.of(context).showSnackBar(customSnack(errorMsg));
    }
  }

  @override
  void initState() {
    getProfileData();
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Skeletonizer(
        enabled: products == null,
        child: Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                elevation: 0,
                scrolledUnderElevation: 0,
                pinned: true,
                floating: false,
                backgroundColor: Colors.white,
                toolbarHeight: 200,
                automaticallyImplyLeading: false,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.only(right: 20, left: 20, top: 38),
                  child: Column(
                    children: [
                      UserHeader(
                        userName: userModel?.name ?? 'kunckels',
                        userImage:
                            userModel?.image ??
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTktoi2qNZ6Vesj_zN2ooj4h2Oq2S58CzfVJQ&s',
                      ),
                      Gap(20),
                      SearchField(
                        controller: controller,
                        onChanged: (value) {
                          final query = value.toLowerCase();
                          setState(() {
                            products = allProducts
                                .where((p) => p!.name.toLowerCase().startsWith(query))
                                .toList();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              //category
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 5,
                  ),
                  child: FoodCategory(
                    selectedIndex: selectedIndex,
                    category: category,
                  ),
                ),
              ),
              //GridView
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate(
                    childCount: products.length,
                    (context, index) {
                      final product = products[index];
                      if (product == null) {
                        return CupertinoActivityIndicator();
                      }
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return ProductDetailsView(
                                  productImage: product.image,
                                  productId: product.id,
                                  productPrice: product.price,
                                );
                              },
                            ),
                          );
                        },
                        child: CardItem(
                          image: product!.image,
                          text: product.name,
                          description: product.desc,
                          rate: product.rate,
                        ),
                      );
                    },
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.65,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
