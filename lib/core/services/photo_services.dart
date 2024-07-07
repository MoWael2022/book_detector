import 'dart:convert';
import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:khaltabita/core/global_resources/constants.dart';
import 'package:url_launcher/url_launcher.dart';


class PhotoServices {
  final List<String> _scopes = [
    'https://www.googleapis.com/auth/photoslibrary'
  ];

  Future<AuthClient> getHttpClient() async {
    AuthClient authClient =
    await clientViaUserConsent(ClientId(AppConstants.photoId), _scopes, _userPrompt).catchError((e) => print(e));
    return authClient;
  }
  upload(File file) async {
    AuthClient client = await getHttpClient();

    var tokenResult = await client.post(
      Uri.parse('https://photoslibrary.googleapis.com/v1/uploads'),
      headers: {
        'Content-type': 'application/octet-stream',
        'X-Goog-Upload-Content-Type': 'image/png',
        'X-Goog-Upload-Protocol': 'raw'
      },
      body: file.readAsBytesSync(),
    );
    print(tokenResult);
    var res = await client.post(
      Uri.parse(
          'https://photoslibrary.googleapis.com/v1/mediaItems:batchCreate'),
      headers: {'Content-type':'application/json' },
      body: jsonEncode({
        "newMediaItems": [
          {
            "description": "item-description",
            "simpleMediaItem": {
              "fileName": "khaltabita",
              "uploadToken": tokenResult.body,
            }
          }
        ]
      }),
    );

    print(res.body);
  }
  _userPrompt(String url) {
    print(url);
    launch(url);
  }
}