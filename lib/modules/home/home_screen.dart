// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors_in_immutables
import 'package:buybuddy/cubit/app/app_cubit.dart';
import 'package:buybuddy/cubit/app/app_states.dart';
import 'package:buybuddy/models/home_model.dart';
import 'package:buybuddy/shared/styles/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final CarouselController _carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(
                  condition: AppCubit.get(context).homeModel != null,
                  builder: (context) => SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Offers",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            banners(
                                banners: AppCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .banners,
                                context: context),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 1,
                              width: double.infinity,
                              color: indigoDye,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Products",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            products(
                                products: AppCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .products),
                          ],
                        ),
                      ),
                  fallback: (context) => Center(
                        child: CircularProgressIndicator(),
                      ))),
        );
      },
    );
  }

  Widget banners({
    required List<BannerModel> banners,
    required BuildContext context,
  }) =>
      Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: CarouselSlider(
              carouselController: _carouselController,
              items: banners
                  .map(
                    (e) => CachedNetworkImage(
                      imageUrl: e.image!,
                      placeholder: (context, url) => Image.network(url),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                height: 220.0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 5),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  AppCubit.get(context).changeSliderIndex(index);
                },
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          DotsIndicator(
            dotsCount: banners.length,
            position: AppCubit.get(context).currentCarouselPage.toInt(),
            decorator: DotsDecorator(
              color: alabster,
              activeColor: prussianBlue,
              spacing: EdgeInsets.all(6.0),
              activeSize: Size(9.5, 9.5),
              size: Size(7.0, 7.0),
            ),
          ),
        ],
      );

  Widget products({
    required List<ProductModel> products,
  }) =>
      GridView.count(
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        children: List.generate(
          products.length,
          (index) => Column(
            children: [
              product(products[index]),
            ],
          ),
        ),
      );

  Widget product(model) => Column(
        children: [
          Image.network(
            model.image,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ],
      );
}
