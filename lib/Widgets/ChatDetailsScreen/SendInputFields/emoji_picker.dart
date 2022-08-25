import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_persistent_keyboard_height/flutter_persistent_keyboard_height.dart';
import 'package:social_app/ViewModels/Bloc/ChatCubit/chat_cubit.dart';
import 'package:social_app/ViewModels/Bloc/ChatCubit/chat_states.dart';

class EmojiPickerWidget extends StatelessWidget {
  const EmojiPickerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ChatCubit, ChatStates>(
        builder: (context, state) {
          return SizedBox(
            height: PersistentKeyboardHeight.of(context).keyboardHeight,
            child: EmojiPicker(
                textEditingController: ChatCubit.get(context).messageController,
                onEmojiSelected: (Category category, Emoji emoji) {
                  ChatCubit.get(context).changeMessageIcon();
                },
                onBackspacePressed: () {
                  ChatCubit.get(context).changeMessageIcon();
                },
                config: const Config(
                    columns: 9,
                    verticalSpacing: 5,
                    horizontalSpacing: 3,
                    initCategory: Category.RECENT,
                    bgColor: Colors.black87,
                    indicatorColor: Colors.white,
                    iconColorSelected: Colors.white,
                    progressIndicatorColor: Colors.blue,
                    backspaceColor: Colors.white,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    showRecentsTab: true,
                    recentsLimit: 28,
                    replaceEmojiOnLimitExceed: false,
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    buttonMode: ButtonMode.MATERIAL)),
          );
        },
        listener: (context, state) {});
  }
}
