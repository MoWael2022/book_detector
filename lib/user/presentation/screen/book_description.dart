import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/core/service_locator.dart';
import 'package:khaltabita/user/data/data_source/base_remote_data_source.dart';
import 'package:khaltabita/user/data/data_source/remote_data_source.dart';
import 'package:khaltabita/user/data/repository/user_repository.dart';
import 'package:khaltabita/user/domin/entites/category_name_entites.dart';
import 'package:khaltabita/user/domin/entites/lnaguage_translation_entites.dart';
import 'package:khaltabita/user/domin/repository/base_user_repository.dart';
import 'package:khaltabita/user/domin/usecase/Language_Translation_usecase.dart';
import 'package:khaltabita/user/domin/usecase/base_user_usecase.dart';
import 'package:khaltabita/user/domin/usecase/get_book_categories.dart';
import 'package:khaltabita/user/domin/usecase/get_specific_book_usecase.dart';
import 'package:khaltabita/user/presentation/component/category_component.dart';
import 'package:khaltabita/user/presentation/component/custom_text.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:sizer/sizer.dart';
import 'package:get_it/get_it.dart';

import '../../../core/error/category_exceptions.dart';
import '../../../core/global_resources/constants.dart';
import '../../../core/global_resources/functions.dart';
import '../../../core/router.dart';
import '../../data/model/categories_model.dart';
import '../../data/model/language_translation_input_model.dart';
import '../component/book_component.dart';
import '../component/dialogs_component.dart';
import '../component/drawer_component_selected.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../controller/app_state.dart';

class BookDescription extends StatefulWidget {
  const BookDescription({super.key});

  @override
  State<BookDescription> createState() => _BookDescriptionState();
}

class _BookDescriptionState extends State<BookDescription> {
  String? translatedDescription; // Variable to hold translated description

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AppCubit>(context)
        .fetchSpecificBook(BlocProvider.of<AppCubit>(context).bookName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.backgroundColor,
      body: PopScope(
        onPopInvoked: (didPop) async {
          if (didPop) {
            BlocProvider.of<AppCubit>(context).fetchBookInCategory(
                BlocProvider.of<AppCubit>(context).catName);
          }
        },
        child: BlocConsumer<AppCubit, AppState>(
          listener: (context, state) {
            if(state is ConnectivityLoading){
              Dialogs.loadingAwesomeDialog(context);
            }else if (state is ConnectivityFailure){
              Dialogs.errorAwesomeDialog(context, state.message.toString());
            }else if(state is ConnectivitySuccess){
              Dialogs.successAwesomeDialog(context);
            }
            if (state is TranslationStateError) {
              AwesomeDialog(
                context: context,
                dialogType: DialogType.error,
                animType: AnimType.topSlide,
                title: "Error",
                desc: "The translation failed.",
                btnCancelOnPress: () {},
              ).show();
            }
          },
          builder: (context, state) {
            if (state is LoadingBookState) {
              return Functions.loadingLottie();
            } else if (state is LoadedBookState) {
              BlocProvider.of<AppCubit>(context).description =
                  state.data.description;

              return CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 30.h,
                    flexibleSpace: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(25),
                              bottomLeft: Radius.circular(25),
                            ),
                            image: DecorationImage(
                              image: NetworkImage(state.data.urlImage),
                              fit: BoxFit.cover,
                              opacity: .9,
                            ),
                          ),
                        ),
                        Positioned(
                          child: BookImage(imagePath: state.data.urlImage),
                        ),
                      ],
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 5.w, top: .5.h),
                          child: ListView(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    width: 55.w,
                                    child: CustomText(
                                      textName: state.data.title,
                                      fontSize: 10.w,
                                      textColor: ColorManager
                                          .bookTitleDescriptionColor,
                                    ),
                                  ),
                                  Text(
                                    "⭐${state.data.averageRating}",
                                    style: TextStyle(fontSize: 5.w),
                                  ),
                                ],
                              ),
                              CustomText(
                                textName: state.data.author,
                                fontSize: 7.w,
                                textColor:
                                ColorManager.authorDescriptionColor,
                              ),
                              const Divider(
                                  color:
                                  ColorManager.authorDescriptionColor),
                              Stack(
                                children: [
                                  Positioned(
                                    right: 0.w,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      width: 40.w,
                                      height: 5.h,
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            height: 7.w,
                                            width: 7.w,
                                            child: Image.asset(
                                                ImagePathManager
                                                    .translateIcon),
                                          ),
                                          TextButton(
                                            onPressed: () async {
                                              BlocProvider.of<AppCubit>(
                                                  context)
                                                  .translationLanguage(
                                                  state.data.description);
                                              // Perform translation action here
                                              setState(() {
                                                translatedDescription = BlocProvider.of<AppCubit>(
                                                    context).description;// Set translated description here;
                                              });
                                              //print(translatedDescription);

                                              print(BlocProvider.of<AppCubit>(
                                                  context)
                                                  .description);
                                            },
                                            child: SizedBox(
                                              height: 7.h,
                                              child: const Text(
                                                "see translation?",
                                                maxLines: 2,
                                                style: TextStyle(
                                                    color: ColorManager
                                                        .translationText),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CustomText(
                                    textName: "Description",
                                    fontSize: 7.w,
                                    textColor: ColorManager
                                        .bookTitleDescriptionColor,
                                  ),
                                ],
                              ),
                              CustomText(
                                textName: translatedDescription ??
                                    BlocProvider.of<AppCubit>(context)!
                                        .description!,
                                fontSize: 4.w,
                                textColor:
                                ColorManager.authorDescriptionColor,
                              ),
                              SizedBox(height: 2.5.h),
                              CustomText(
                                textName: "Language",
                                fontSize: 7.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              CustomText(
                                textName: "eng",
                                fontSize: 5.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              SizedBox(height: 2.5.h),
                              CustomText(
                                textName: "Category",
                                fontSize: 7.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              CustomText(
                                textName: state.data.category,
                                fontSize: 5.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              SizedBox(height: 2.5.h),
                              CustomText(
                                textName: "PublicDate",
                                fontSize: 7.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              CustomText(
                                textName: state.data.publishedYear,
                                fontSize: 5.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              SizedBox(height: 2.5.h),
                              CustomText(
                                textName: "Number of Page",
                                fontSize: 7.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              CustomText(
                                textName: state.data.numPage,
                                fontSize: 5.w,
                                textColor: ColorManager
                                    .bookTitleDescriptionColor,
                              ),
                              const Divider(
                                  color:
                                  ColorManager.authorDescriptionColor),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomText(
                                    textName: "Similar Book",
                                    fontSize: 5.w,
                                    textColor: ColorManager
                                        .similarDescriptionColor,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, Routers.booksCategory);
                                      BlocProvider.of<AppCubit>(context)
                                          .catName
                                          .categoryName = state.data.category;
                                    },
                                    child: const CircleAvatar(
                                      backgroundColor: ColorManager
                                          .circularDescriptionColor,
                                      child: Icon(
                                          Icons.arrow_forward_outlined,
                                          color: ColorManager.white),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              ListView(
                                physics:
                                const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                children: [
                                  SizedBox(
                                    height: 27.h,
                                    width: 45.w,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: BlocProvider.of<AppCubit>(
                                          context)
                                          .saveBook
                                          .length,
                                      itemBuilder: (context, i) {
                                        return BookComponent(
                                          bookName: BlocProvider.of<AppCubit>(
                                              context)
                                              .saveBook[i]
                                              .title,
                                          rate: BlocProvider.of<AppCubit>(
                                              context)
                                              .saveBook[i]
                                              .averageRating,
                                          imagePath: BlocProvider.of<AppCubit>(
                                              context)
                                              .saveBook[i]
                                              .urlImage,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            } else if (state is ErrorCategoryDataState) {
              return Text(state.failure.messageError);
            } else {
              print(state);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}