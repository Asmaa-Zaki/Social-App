import 'package:flutter/material.dart';

class CurrentUserMessage extends StatelessWidget {
  final String message;
  final String time;
  const CurrentUserMessage(this.message, this.time, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: const BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomEnd: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    Text(
                      message,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      child:  Text(
                        time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
