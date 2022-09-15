import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/Widgets/HomeScreen/show_post_video.dart';

import '../SharedWidgets/ShowImage/show_image.dart';

class PostData extends StatelessWidget {
  final List<PostModel> list;
  final int index;

  const PostData({Key? key, required this.list, required this.index})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        if (list[index].text != null)
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                list[index].text!,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, height: 1.5),
              ),
            ),
          ),
        if (list[index].postImage != null)
          InkWell(
            onTap: () {
              buildPush(context, ShowImage(list[index].postImage!));
            },
            child: Container(
              margin: const EdgeInsets.only(left: 8, right: 8, top: 10),
              height: (list[index].imageHeight! * screenWidth) /
                  list[index].imageWidth!,
              width: screenWidth,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(list[index].postImage!))),
            ),
          ),
        if (list[index].postVideo != null)
          SizedBox(height: 300, child: DisplayVideo(list[index].postVideo!))
      ],
    );
  }
}
