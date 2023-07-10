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
              padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
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
                              "What's New ?",
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListView.separated(
                              separatorBuilder: (context, index) => SizedBox(
                                height: 10,
                              ),
                              itemCount: AppCubit.get(context)
                                  .homeModel!
                                  .data!
                                  .products
                                  .length,
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => product(
                                AppCubit.get(context)
                                    .homeModel!
                                    .data!
                                    .products[index],
                                context,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
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

  Widget product(ProductModel model, context) => Container(
        decoration: BoxDecoration(
            border: Border.all(color: prussianBlue, width: 1),
            borderRadius: BorderRadius.circular(13)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Container(
            color: indigoDye,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(13),
                      bottomLeft: Radius.circular(13)),
                  child: Image.network(
                    model.image.toString(),
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Text(
                        model.name.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: ivory),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.55,
                      height: 1,
                      color: ivory,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.55,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "EGP  ${model.price.toString()}",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: ivory),
                          ),
                          if (model.discount != 0)
                            Text(
                              model.oldPrice.toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontSize: 12,
                                    color: ivory,
                                    decoration: TextDecoration.lineThrough,
                                    decorationThickness: 3,
                                    decorationColor: Colors.red[400],
                                  ),
                            ),
                          IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.favorite,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
}
