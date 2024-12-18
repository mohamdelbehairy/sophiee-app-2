import 'package:app/constants.dart';
import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/story/story_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/story_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatItemTop extends StatelessWidget {
  const ChatItemTop({super.key, required this.user});
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;
    Color color;
    var isStory =
        context.read<StoryCubit>().checkIsStory(friendId: user.userID);
    navigatorPush() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => StoryViewPage(user: user)));
    }

    return BlocBuilder<GetUserDataCubit, GetUserDataStates>(
      builder: (context, state) {
        if (state is GetUserDataSuccess && state.userModel.isNotEmpty) {
          final currentUser = user.userID;
          final data = state.userModel
              .firstWhere((element) => element.userID == currentUser);

          int differenceInMinutes =
              Timestamp.now().toDate().difference(data.onlineStatue).inMinutes;
          if (differenceInMinutes < 1) {
            color = kPrimaryColor;
          } else {
            color = Colors.grey;
          }
          return Column(
            children: [
              InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () async {
                    if (await isStory) {
                      navigatorPush();
                    }
                  },
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: size.height * .034,
                        backgroundColor:
                            data.isStory ? kPrimaryColor : Colors.transparent,
                        child: CircleAvatar(
                          radius: size.height * .033,
                          backgroundColor:
                              data.isStory ? Colors.white : Colors.transparent,
                          child: CircleAvatar(
                            radius: size.height * .031,
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(size.height * .035),
                                child: FancyShimmerImage(
                                    boxFit: BoxFit.cover,
                                    shimmerBaseColor: isDark
                                        ? Colors.white12
                                        : Colors.grey.shade300,
                                    shimmerHighlightColor: isDark
                                        ? Colors.white24
                                        : Colors.grey.shade100,
                                    imageUrl: data.profileImage)),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.only(
                            bottom: size.width * .012, end: size.width * .0015),
                        child: CircleAvatar(
                          radius: size.width * .022,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            backgroundColor: color,
                            radius: size.width * .017,
                          ),
                        ),
                      )
                    ],
                  )),
              SizedBox(height: size.width * .01),
              Container(
                width: size.width * .16,
                child: Center(
                  child: Text(
                    data.userName.split(' ')[0],
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black),
                  ),
                ),
              )
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
