import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:khaltabita/core/global_resources/color_manager.dart';
import 'package:khaltabita/core/global_resources/images_path.dart';
import 'package:khaltabita/user/presentation/component/custom_page.dart';
import 'package:lottie/lottie.dart';
import 'package:sizer/sizer.dart';

import '../component/dialogs_component.dart';
import '../controller/app_cubit.dart';
import '../controller/app_state.dart';

class GeminiChat extends StatefulWidget {
  const GeminiChat({super.key});

  @override
  State<GeminiChat> createState() => _GeminiChatState();
}

class _GeminiChatState extends State<GeminiChat> {
  Gemini gemini = Gemini.instance;
  ChatUser currentUser = ChatUser(id: "0", firstName: "user");
  ChatUser geminiUser = ChatUser(
    id: "1",
    profileImage: 'https://www.shutterstock.com/image-vector/gemini-logo-vector-editorial-white-260nw-2413972659.jpg',
  );

  List<ChatMessage> messages = [];
  bool _isLoading = false; // Loading state flag

  @override
  Widget build(BuildContext context) {
    return CustomPage(
      page: Padding(
        padding: EdgeInsets.only(left: 2.0.w, right: 2.w, bottom: 3.h),
        child: Container(
          decoration: BoxDecoration(
            image: const DecorationImage(
              opacity: .4,
              fit: BoxFit.fill,
              image: AssetImage(ImagePathManager.geminiCover),
            ),
            border: Border.all(
              color: Colors.amberAccent,
              strokeAlign: 0,
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              DashChat(
                inputOptions: InputOptions(trailing: [
                  IconButton(
                    onPressed: () {
                      _sendMediaMessage();
                    },
                    icon: const Icon(Icons.image),
                  ),
                ]),
                currentUser: currentUser,
                messages: messages,
                onSend: _sengMessage,
              ),
              if (_isLoading)
                Positioned(
                  left: 2.w,
                  bottom: 3.5.h,
                  child: Lottie.asset(

                    ImagePathManager.loadingChat, // Path to your Lottie file
                    width: 100,
                    height: 100,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _sengMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
      _isLoading = true; // Show loading animation
    });

    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [File(chatMessage.medias!.first.url).readAsBytesSync()];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        String response = event.content?.parts?.fold(
            "", (previous, current) => "$previous ${current.text}") ??
            "";

        setState(() {
          _isLoading = false; // Hide loading animation
          ChatMessage message;
          if (messages.firstOrNull?.user == geminiUser) {
            ChatMessage lastMessage = messages.removeAt(0);
            lastMessage.text += response;
            message = lastMessage;
          } else {
            message = ChatMessage(
              user: geminiUser,
              createdAt: DateTime.now(),
              text: response,
            );
          }
          messages = [message, ...messages];
        });
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false; // Hide loading animation in case of error
      });
    }
  }

  void _sendMediaMessage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe everything about this book",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          ),
        ],
      );
      _sengMessage(chatMessage);
    }
  }
}
