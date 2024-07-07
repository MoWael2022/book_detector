import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:khaltabita/Admin/presentation/controller/admin_state.dart';
import 'package:sizer/sizer.dart';

import '../../../core/global_resources/images_path.dart';
import '../../../core/router.dart';
import '../../../user/presentation/controller/app_cubit.dart';
import '../controller/admin_cubit.dart';

class AllBookData extends StatefulWidget {
  final int numberOfElement;
  final bool allowPhysics;

  AllBookData(
      {Key? key, required this.numberOfElement, required this.allowPhysics})
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

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'All Books',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Routers.manageBook);
                },
                icon: const Icon(Icons.add)),
          ],
        ),
        SizedBox(height: 3.h),
        Expanded(
          child: BlocConsumer<AdminCubit, AdminState>(
            listener: (context, state) {
              if (state is LoadingDeleteState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
              } else if (state is LoadedDeleteState) {
                Navigator.of(context).pop();
                _removeBook(state.bookId); // Remove the book from the list
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.success,
                    animType: AnimType.topSlide,
                    title: "Success",
                    desc: "Book Deleted successfully",
                    btnOkOnPress: () {
                      Navigator.of(context).pop();
                    })
                    .show();
              } else {
                Navigator.of(context).pop();
                AwesomeDialog(
                    context: context,
                    dialogType: DialogType.error,
                    animType: AnimType.topSlide,
                    title: "Error",
                    desc: "Book not deleted, there is a problem",
                    btnCancelOnPress: () {})
                    .show();
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
                  return ListTile(
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
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
                    trailing: PopupMenuButton<String>(
                      onSelected: (String result) {
                        switch (result) {
                          case 'View Book':
                            Navigator.of(context).pushNamed(Routers.manageBook);
                            break;
                          case 'Update':
                            Navigator.of(context).pushNamed(Routers.updateBook);
                            BlocProvider.of<AdminCubit>(context).id =
                                BlocProvider.of<AppCubit>(context)
                                    .allBook[index]
                                    .id
                                    .toString();
                            break;
                          case 'Delete':
                            BlocProvider.of<AdminCubit>(context).id =
                                BlocProvider.of<AppCubit>(context)
                                    .allBook[index]
                                    .id
                                    .toString();
                            BlocProvider.of<AdminCubit>(context).deleteBook();
                            break;
                        }
                      },
                      itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: 'View Book',
                          child: const Text('View Book'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Update',
                          child: const Text('Update'),
                        ),
                        PopupMenuItem<String>(
                          value: 'Delete',
                          child: const Text('Delete'),
                        ),
                      ],
                      icon: Image.asset(ImagePathManager.editIcon),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
