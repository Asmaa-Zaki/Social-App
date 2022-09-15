import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_cubit.dart';
import 'package:social_app/ViewModels/Bloc/PostCubit/post_states.dart';
import 'package:social_app/ViewModels/Components/components.dart';

class ShowImage extends StatelessWidget {
  final String url;
  const ShowImage(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 50,
                width: 50,
                child: BlocConsumer<PostCubit, PostStates>(
                  builder: (context, state) {
                    if (state is DownloadPostImageLoading) {
                      return Container(
                        padding: const EdgeInsets.all(15.0),
                        child: const CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.white,
                        ),
                      );
                    }
                    return TextButton(
                        onPressed: () {
                          PostCubit.get(context).downloadPostImage(url);
                        },
                        child: const Icon(
                          Icons.download_outlined,
                          color: Colors.white,
                        ));
                  },
                  listener: (BuildContext context, state) {
                    if (state is DownloadPostImageDone) {
                      showSnackBar(context, "Image downloaded successfully");
                    } else if (state is DownloadPostImageFailed) {
                      showSnackBar(context, "Error happened, Try again!");
                    }
                  },
                ),
              ),
            ),
            Center(child: Image.network(url)),
            Container()
          ],
        ),
      ),
    );
  }
}
