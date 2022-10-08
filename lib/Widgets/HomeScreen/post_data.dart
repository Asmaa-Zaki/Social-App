import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/Widgets/HomeScreen/show_post_video.dart';

import '../SharedWidgets/ShowImage/show_image.dart';

class PostData extends StatelessWidget {
  final PostModel postModel;

  const PostData({Key? key, required this.postModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool rtl = intl.Bidi.detectRtlDirectionality(postModel.text ?? '');
    double screenWidth = MediaQuery.of(context).size.width;
    double imageHeight = 0;
    if (postModel.imageHeight != null) {
      imageHeight =
          (postModel.imageHeight! * screenWidth) / postModel.imageWidth!;
      if (imageHeight > MediaQuery.of(context).size.height * 1 / 2) {
        imageHeight = MediaQuery.of(context).size.height * 1 / 2;
      }
    }
    return Column(
      children: [
        if (postModel.text != null)
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
            child: Align(
              alignment: rtl ? Alignment.centerRight : Alignment.centerLeft,
              child: Text(
                postModel.text!,
                textDirection: rtl ? TextDirection.rtl : TextDirection.ltr,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              ),
            ),
          ),
        if (postModel.postImage != null)
          InkWell(
            onTap: () {
              buildPush(context, ShowImage(postModel.postImage!));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
              height: imageHeight,
              width: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(postModel.postImage!))),
            ),
          ),
        if (postModel.postVideo != null)
          SizedBox(height: 300, child: DisplayVideo(postModel.postVideo!))
      ],
    );
  }
}
