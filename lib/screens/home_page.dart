import 'package:ecommerce_app/logic/product_cubit/cubit/product_cubit.dart';
import 'package:ecommerce_app/models/product_model.dart';
import 'package:ecommerce_app/widgets/catigories.dart';
import 'package:ecommerce_app/widgets/lastteststuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import '../consts/texts.dart';
import '../logic/themebloc/cubit/themechange_cubit.dart';

class Myhomepage extends StatefulWidget {
  const Myhomepage({super.key});

  @override
  State<Myhomepage> createState() => _MyhomepageState();
}

class _MyhomepageState extends State<Myhomepage> {
  late ProductCubit _productCubit;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _productCubit = BlocProvider.of<ProductCubit>(context);
    _productCubit.Myproduct();
  }

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   super.dispose();
  //   _productCubit.close();
  // }

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      'images/categories/mobiles.png',
      'images/categories/pc.png',
      'images/categories/watch.png',
      'images/categories/shoes.png',
      'images/categories/book_img.png',
      'images/categories/cosmetics.png',
      'images/categories/electronics.png',
      'images/categories/fashion.png'
    ];
    List titles = [
      'phones',
      'laptops',
      'watches',
      'shoes',
      'Accessories',
    ];
    List colors = [
      Colors.orange,
      Colors.cyan,
      Colors.blue,
      Colors.black,
      Colors.green,
      Colors.grey,
      Colors.red,
      Colors.white,
    ];
    List ads = ['images/banners/banner1.png', 'images/banners/banner2.png'];
    var size = MediaQuery.of(context).size;
    ThemechangeCubit theme =
        BlocProvider.of<ThemechangeCubit>(context, listen: true);

    return Scaffold(
        appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.purple,
            highlightColor: Colors.red,
            child: const texts(
              text: 'shoppy go',
              middle: true,
            ),
          ),
          leading: Image.asset("images/profile/shopping-cart.png"),
          backgroundColor:
              theme.isdark == false ? Colors.grey[800] : Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.25,
                child: Swiper(
                  autoplay: true,
                  autoplayDelay: 3000,
                  itemBuilder: (context, index) {
                    return ClipRRect(
                      child: Image.asset(
                        ads[index],
                        fit: BoxFit.fill,
                      ),
                    );
                  },
                  itemCount: ads.length,
                  pagination: const SwiperPagination(
                      builder: RectSwiperPaginationBuilder(
                          activeColor: Colors.blue)),
                  // control: const SwiperControl(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const texts(
                text: 'lastes arrivage',
                big: true,
              ),
              Expanded(
                  child: SizedBox(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 19,
                  itemBuilder: (context, index) {
                    return BlocBuilder<ProductCubit, ProductState>(
                      builder: (context, state) {
                        if (state is productmm) {
                          return LatestArrivalProductsWidget(
                            productModule: ProductModule(
                                productImage:
                                    state.productModule[index].productImage,
                                productQuantity: '',
                                productId: '',
                                productTitle:
                                    state.productModule[index].productTitle,
                                productPrice:
                                    state.productModule[index].productPrice,
                                productCategory: '',
                                productDescription: state
                                    .productModule[index].productDescription),
                          );
                        } else {
                          return CircularProgressIndicator();
                        }
                      },
                    );
                  },
                ),
              )),
              const texts(
                text: 'Catigories',
                big: true,
              ),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 0),
                  itemCount: titles.length,
                  itemBuilder: (context, index) {
                    return Catigories(
                      Function: () {
                        BlocProvider.of<ProductCubit>(context)
                            .filteredpro(titles[index]);
                        Navigator.pushNamed(context, '/search');
                      },
                      color: colors[index],
                      image: images[index],
                      title: titles[index],
                    );
                  },
                ),
              )
            ],
          ),
        ));
  }
}
