import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_state.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/component/custom_text_form_field.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/functions.dart';
import '../../../core/global_resources/images_path.dart';
import '../../../core/router.dart';
import '../../../user/presentation/component/dialogs_component.dart';
import '../../../user/presentation/component/search_book.dart';
import '../../../user/presentation/controller/app_cubit.dart';
import '../../../user/presentation/controller/app_state.dart';
import '../controller/admin_cubit.dart';

class AllBookData extends StatefulWidget {
  final int numberOfElement;
  final bool allowPhysics;
  final bool editing;

  AllBookData(
      {Key? key,
      required this.numberOfElement,
      required this.allowPhysics,
      required this.editing})
      : super(key: key);

  @override
  _AllBookDataState createState() => _AllBookDataState();
}

class _AllBookDataState extends State<AllBookData> {
  final ScrollController _scrollController = ScrollController();
  List<dynamic> _loadedBooks = [];
  int _currentMax = 10;

  @override
  void initState() {
    super.initState();
    _loadMoreBooks();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreBooks();
      }
    });
  }

  void _loadMoreBooks() {
    if (_currentMax >= widget.numberOfElement) return;
    setState(() {
      _currentMax = (_currentMax + 10) > widget.numberOfElement
          ? widget.numberOfElement
          : _currentMax + 10;
      _loadedBooks =
          BlocProvider.of<AppCubit>(context).allBook.sublist(0, _currentMax);
    });
  }

  void _removeBook(String bookId) {
    setState(() {
      _loadedBooks.removeWhere((book) => book.id == bookId);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // EdgeInsets edgeInsetsBig = EdgeInsets.only(left: 2.w,right: 2.w ,top: 1.w,bottom: 1.w);
  // EdgeInsets edgeInsetsSmall = EdgeInsets.only(left: 3.w,right: 3.w ,top: 2.w,bottom: 2.w);
  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit,AppState>(
      listener: (context , state) {
        if(state is ConnectivityLoading){
          Dialogs.loadingAwesomeDialog(context);
        }else if (state is ConnectivityFailure){
          Dialogs.errorAwesomeDialog(context, state.message.toString());
        }else if(state is ConnectivitySuccess){
          Dialogs.successAwesomeDialog(context);
        }
      },
      child: FutureBuilder(
          future: BlocProvider.of<AppCubit>(context).getAllBooksFuture(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                color: ColorManager.backgroundAdmin,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //const CustomTextFormField(),
                    Padding(
                      padding: EdgeInsets.all(0.w),
                      child: Container(
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(4.0.w),
                              child: const Text(
                                'All Books',
                                style: TextStyle(
                                    fontSize: 22, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                    icon: const Icon(Icons.search),
                                    onPressed: () {
                                      showSearch(
                                          context: context,
                                          delegate: CustomBookSearch());
                                    }),
                                !(widget.editing)
                                    ? const SizedBox()
                                    : IconButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushNamed(Routers.manageBook);
                                        },
                                        icon: const Icon(Icons.add)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 1.h),
                    Expanded(
                      child: BlocConsumer<AdminCubit, AdminState>(
                        listener: (context, state) {
                          if (state is LoadingDeleteState) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return Functions.loadingLottie();
                              },
                            );
                          } else if (state is LoadedDeleteState) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              Navigator.of(context).pop();
                              _removeBook(
                                  state.bookId); // Remove the book from the list
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.topSlide,
                                title: "Success",
                                desc: "Book Deleted successfully",
                                btnOkOnPress: () {
                                  Navigator.of(context).pop();
                                },
                              ).show();
                            });
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                            });
                          }
                        },
                        builder: (context, state) {
                          return ListView.builder(
                            controller: _scrollController,
                            physics: widget.allowPhysics
                                ? const AlwaysScrollableScrollPhysics()
                                : const NeverScrollableScrollPhysics(),
                            itemCount: _loadedBooks.length,
                            itemBuilder: (context, index) {
                              return AnimatedPadding(
                                duration: const Duration(seconds: 1),
                                padding: EdgeInsets.only(
                                    top: 2.w, bottom: 2.w, right: 3.w, left: 3.w),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(color: Colors.black),
                                  ),
                                  child: ListTile(
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 4.w, vertical: 2.h),
                                    leading: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        _loadedBooks[index].urlImage,
                                        height: 15.h,
                                        width: 7.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    title: Text(
                                      _loadedBooks[index].title,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    subtitle: Text(
                                      _loadedBooks[index].author,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    trailing: !(widget.editing)
                                        ? IconButton(
                                            icon: const Icon(Icons.book),
                                            onPressed: () {},
                                          )
                                        : PopupMenuButton<String>(
                                            onSelected: (String result) {
                                              switch (result) {
                                                case 'View Book':
                                                  Navigator.pushNamed(context,
                                                      Routers.bookDescription);
                                                  BlocProvider.of<AppCubit>(
                                                              context)
                                                          .bookName
                                                          .bookName =
                                                      BlocProvider.of<AppCubit>(
                                                              context)
                                                          .allBook[index]
                                                          .title;
                                                  BlocProvider.of<AppCubit>(
                                                              context)
                                                          .catName
                                                          .categoryName =
                                                      BlocProvider.of<AppCubit>(
                                                              context)
                                                          .allBook[index]
                                                          .category;
                                                  BlocProvider.of<AppCubit>(
                                                          context)
                                                      .getSimilarbook(BlocProvider
                                                              .of<AppCubit>(
                                                                  context)
                                                          .catName);

                                                  break;
                                                case 'Update':
                                                  Navigator.of(context).pushNamed(
                                                      Routers.updateBook);
                                                  BlocProvider.of<AdminCubit>(
                                                              context)
                                                          .id =
                                                      BlocProvider.of<AppCubit>(
                                                              context)
                                                          .allBook[index]
                                                          .id
                                                          .toString();
                                                  break;
                                                case 'Delete':
                                                  BlocProvider.of<AdminCubit>(
                                                              context)
                                                          .id =
                                                      BlocProvider.of<AppCubit>(
                                                              context)
                                                          .allBook[index]
                                                          .id
                                                          .toString();
                                                  BlocProvider.of<AdminCubit>(
                                                          context)
                                                      .deleteBook();
                                                  break;
                                              }
                                            },
                                            itemBuilder: (BuildContext context) =>
                                                <PopupMenuEntry<String>>[
                                              const PopupMenuItem<String>(
                                                value: 'View Book',
                                                child: Text('View Book'),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Update',
                                                child: Text('Update'),
                                              ),
                                              const PopupMenuItem<String>(
                                                value: 'Delete',
                                                child: Text('Delete'),
                                              ),
                                            ],
                                            icon: Image.asset(
                                                ImagePathManager.editIcon),
                                          ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Lottie.asset(ImagePathManager.lottieBooks));
            }
          }),
    );
  }
}
