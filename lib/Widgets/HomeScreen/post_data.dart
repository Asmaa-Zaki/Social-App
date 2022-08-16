import 'package:flutter/material.dart';
import 'package:social_app/Models/PostModel/post_model.dart';

import '../SharedWidgets/ShowImage/show_image.dart';


class PostData extends StatelessWidget {
  final List<PostModel> list;
  final int index;

  const PostData({Key? key, required this.list, required this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: 8.0, right: 8.0, top: 8.0),
          child: Text(
            list[index].text!,
            style: const TextStyle(
                fontWeight: FontWeight.bold, height: 1.5),
          ),
        ),
        if(list[index].postImage != null)
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(
                  builder: (context)=> ShowImage(list[index].postImage!)
              ));
            },
            child: Container(
              margin:
              const EdgeInsets.only(left: 8, right: 8, top: 10),
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                  borderRadius:
                  const BorderRadius.all(Radius.circular(5)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(list[index].postImage!))),
            ),
          ),
      ],
    );
  }
}
