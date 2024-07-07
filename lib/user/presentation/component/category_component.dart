import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/router.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/user/presentation/screen/books_category.dart';
import 'package:khaltabita/user/presentation/screen/Categories.dart';
import 'package:sizer/sizer.dart';

class CategoryComponent extends StatelessWidget {
  CategoryComponent(
      {super.key,
      required this.bookName,
      required this.rate,
      required this.imagePath});

  String bookName;
  String rate;
  String imagePath;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0.w),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, Routers.booksCategory);
          BlocProvider.of<AppCubit>(context).catName.categoryName = bookName;
          BlocProvider.of<AppCubit>(context)
              .getSimilarbook(BlocProvider.of<AppCubit>(context).catName);
        },
        child: Container(
          height: 26.h,
          width: 80.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image:
                DecorationImage(image: AssetImage(imagePath), fit: BoxFit.fill),
          ),
          child: Container(
            padding: EdgeInsets.only(bottom: 3.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [Color(0xff693712), Colors.transparent])),
            child: Container(
              alignment: Alignment.bottomCenter,
              width: 20.w,
              child: Text(
                bookName,
                style: TextStyle(
                  color: ColorManager.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 5.w,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final String fallbackAssetImage;

  const NetworkImageWithFallback({
    Key? key,
    required this.imageUrl,
    required this.fallbackAssetImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ImageProvider>(
      future: _loadNetworkImage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || !snapshot.hasData) {
            return Image.asset(fallbackAssetImage, fit: BoxFit.fill);
          } else {
            return Image(image: snapshot.data!, fit: BoxFit.fill);
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<ImageProvider> _loadNetworkImage() async {
    try {
      final networkImage = NetworkImage(imageUrl);
      final completer = Completer<ImageInfo>();
      final stream = networkImage.resolve(ImageConfiguration.empty);

      final listener = ImageStreamListener(
        (info, _) => completer.complete(info),
        onError: (error, _) => completer.completeError(error),
      );

      stream.addListener(listener);
      await completer.future.timeout(Duration(seconds: 10));
      stream.removeListener(listener);
      return networkImage;
    } catch (_) {
      return AssetImage(fallbackAssetImage);
    }
  }
}
