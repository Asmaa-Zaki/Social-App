import 'package:flutter/material.dart';

import '../../Views/CommentsScreen/comments_screen.dart';

void commentBottomSheet(BuildContext context) {
  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(15.0),
        ),
      ),
      builder: (_) {
        return const CommentsScreen();
      });
}
