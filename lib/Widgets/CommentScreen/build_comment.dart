import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:social_app/Models/CommentModel/comment_model.dart';
import 'package:social_app/Models/UserModel/user_model.dart';
import 'package:social_app/ViewModels/Bloc/UserCubit/user_cubit.dart';
import 'package:social_app/ViewModels/Components/components.dart';
import 'package:social_app/ViewModels/Constants/constants.dart';
import 'package:social_app/Widgets/SharedWidgets/ShowImage/show_image.dart';
import 'package:timeago/timeago.dart' as timeago;

class BuildComment extends StatelessWidget {
  final CommentModel commentModel;

  const BuildComment({Key? key, required this.commentModel}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool rtl = intl.Bidi.detectRtlDirectionality(commentModel.comment ?? '');
    UserModel commentOwner =
        UserCubit.get(context).getUserWithId(commentModel.commentOwner)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15),
      child: IntrinsicWidth(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(commentOwner.image)),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 5, bottom: 5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: firstDefaultColor.withOpacity(.3),
                    ),
                    child: Column(
                      crossAxisAlignment: rtl
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            commentOwner.name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        if (commentModel.comment != null)
                          Text(
                            commentModel.comment!,
                            textDirection:
                                rtl ? TextDirection.rtl : TextDirection.ltr,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.color
                                    ?.withOpacity(.8)),
                          ),
                        if (commentModel.image != null)
                          const SizedBox(
                            height: 5,
                          ),
                        if (commentModel.image != null)
                          InkWell(
                              onTap: () {
                                buildPush(
                                    context, ShowImage(commentModel.image!));
                              },
                              child: Image(
                                image: NetworkImage(commentModel.image!),
                              ))
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 3, right: 10, top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          timeago.format(DateTime.parse(commentModel.dateTime)),
                          style: const TextStyle(fontSize: 11),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
