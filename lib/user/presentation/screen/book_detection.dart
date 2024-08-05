import 'dart:io';
import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sizer/sizer.dart';
import 'package:khaltabita/user/presentation/controller/app_cubit.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import '../../../core/router.dart';
import '../component/dialogs_component.dart';

class BookDetection extends StatefulWidget {
  @override
  State<BookDetection> createState() => _BookDetectionState();
}

class _BookDetectionState extends State<BookDetection> {
  bool loading = false;
  File? _image;
  final ImagePicker imagePicker = ImagePicker();
  final Dio _dio = Dio();

  Future<void> _pickImageFromGallery() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _pickImageFromCamera() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _processImageFile(context) async {
    if (_image == null) return;

    setState(() {
      loading = true;
    });

    try {
      String fileName = _image!.path.split('/').last;
      FormData formData = FormData.fromMap({
        "file": await MultipartFile.fromFile(_image!.path, filename: fileName),
      });

      Response response = await _dio.post(
          'http://192.168.235.129:5000/process_image',
          data: formData
      );

      if (response.statusCode == 200) {
        String detectedText = response.data['detected_text'];
        BlocProvider.of<AppCubit>(context).getSimilarBook(detectedText);
        int similarBookCount = BlocProvider.of<AppCubit>(context).similarBooks.length;

        if (similarBookCount > 0) {
          Dialogs.showResultDialog(similarBookCount,context);
        } else {
          Dialogs.showNoResultDialog(context);
        }
      } else {
        Dialogs.showErrorDialog('Failed to process image',context);
      }
    } catch (e) {
      Dialogs.showErrorDialog('Error: $e',context);
    } finally {
      setState(() {
        loading = false;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: GestureDetector(
              onTap: () async {
                await _pickImageFromCamera();
              },
              child: Container(
                height: 35.h,
                width: 50.w,
                color: Colors.lightBlueAccent,
                child: _image == null
                    ? Image.asset(
                  'assets/images/auth_image/books.jpg',
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  _image!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await _processImageFile(context);
            },
            child: loading ? CircularProgressIndicator() : Text("Detect Book"),
          ),
          SizedBox(
            width: 50.w,
            height: 7.h,
            child: ElevatedButton(
              onPressed: () async {
                await _pickImageFromGallery();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    ColorManager.buttonDetectionColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
              child: Text(
                "Upload Image",
                style: TextStyle(color: ColorManager.white, fontSize: 5.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
