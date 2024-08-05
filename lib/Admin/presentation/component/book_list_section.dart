import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/controller/app_state.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/images_path.dart';
import '../../../core/router.dart';
import '../../../user/presentation/controller/app_cubit.dart';
import '../controller/admin_cubit.dart';
import '../controller/admin_state.dart';

class BookListSection extends StatelessWidget {
  int numberOfElement;
  bool allowPhysics;

  BookListSection(
      {super.key, required this.numberOfElement, required this.allowPhysics});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppState>(builder: (context, state) {
      return FutureBuilder(
          future: BlocProvider.of<AppCubit>(context).getAllBooksFuture(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Books',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(Routers.allAdminBook);
                          },
                          child: const Text("View all book")),
                    ],
                  ),
                  SizedBox(height: 3.h),
                  BlocListener<AdminCubit, AdminState>(
                    listener: (context, state) {
                      if (state is LoadingDeleteState) {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          // Prevent dismissing the dialog
                          builder: (BuildContext context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                      } else if (state is LoadedDeleteState) {
                        Navigator.of(context).pop();
                        AwesomeDialog(
                            context: context,
                            dialogType: DialogType.success,
                            animType: AnimType.topSlide,
                            title: "Success",
                            desc: "Book Added successfully",
                            btnOkOnPress: () {
                              Navigator.of(context).pop();
                            }).show();
                      }
                      // else {
                      //   Navigator.of(context).pop();
                      //   AwesomeDialog(
                      //           context: context,
                      //           dialogType: DialogType.error,
                      //           animType: AnimType.topSlide,
                      //           title: "Error",
                      //           desc: "Book not Added, there is a problem",
                      //           btnCancelOnPress: () {})
                      //       .show();
                      // }
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: allowPhysics == false
                          ? const NeverScrollableScrollPhysics()
                          : const ScrollPhysics(),
                      itemCount: numberOfElement,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(top:2.w,bottom: 2.w),
                          child: ListTile(
                            tileColor: ColorManager.white,
                            shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 4.w, vertical: 2.h),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                BlocProvider.of<AppCubit>(context)
                                    .allBook[index]
                                    .urlImage,
                                height: 15.h,
                                width: 7.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                            title: Text(
                              BlocProvider.of<AppCubit>(context)
                                  .allBook[index]
                                  .title,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              BlocProvider.of<AppCubit>(context)
                                  .allBook[index]
                                  .author,
                              // Assuming there's an author field
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            trailing: PopupMenuButton<String>(
                              onSelected: (String result) {
                                switch (result) {
                                  case 'View Book':
                                    // Handle view book
                                    break;
                                  case 'Update':
                                    // Handle update book
                                    break;
                                  case 'Delete':
                                    // Handle delete book
                                    break;
                                }
                              },
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'View Book',
                                  onTap: () {
                                    Navigator.pushNamed(context, Routers.bookDescription);
                                    BlocProvider.of<AppCubit>(context).bookName.bookName = BlocProvider.of<AppCubit>(context)
                                        .allBook[index].title;
                                    BlocProvider.of<AppCubit>(context)
                                        .catName
                                        .categoryName = BlocProvider.of<AppCubit>(context)
                                        .allBook[index].category;
                                    BlocProvider.of<AppCubit>(context)
                                        .getSimilarbook(BlocProvider.of<AppCubit>(context).catName);
                                  },
                                  child: const Text('View Book'),
                                ),
                                PopupMenuItem<String>(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(Routers.updateBook);
                                    BlocProvider.of<AdminCubit>(context).id =
                                        BlocProvider.of<AppCubit>(context)
                                            .allBook[index]
                                            .id
                                            .toString();
                                    print("i am here");
                                    print(BlocProvider.of<AdminCubit>(context)
                                        .id!);
                                  },
                                  value: 'Update',
                                  child: const Text('Update'),
                                ),
                                PopupMenuItem<String>(
                                  onTap: () {
                                    BlocProvider.of<AdminCubit>(context)
                                        .deleteBook();
                                    BlocProvider.of<AdminCubit>(context).id =
                                        BlocProvider.of<AppCubit>(context)
                                            .allBook[index]
                                            .id
                                            .toString();
                                  },
                                  value: 'Delete',
                                  child: const Text('Delete'),
                                ),
                              ],
                              icon: Image.asset(ImagePathManager.editIcon),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: Text("Error"),
              );
            }
          });

      return const Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
