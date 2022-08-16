import 'package:flutter/material.dart';

class FriendMessage extends StatelessWidget {
  final String message;
  final String time;
  const FriendMessage(this.message, this.time, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
            decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadiusDirectional.only(
                  topStart: Radius.circular(10),
                  bottomStart: Radius.circular(10),
                  topEnd: Radius.circular(10),
                )),
            child: Padding( 
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicWidth(
                child: Column(
                  children: [
                    Text(
                      message,
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                     Container(
                      alignment: Alignment.bottomRight,
                      child:  Text(
                        time,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[350],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}
