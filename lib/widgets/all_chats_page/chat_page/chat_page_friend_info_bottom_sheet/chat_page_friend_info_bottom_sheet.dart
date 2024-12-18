import 'package:app/cubit/auth/login/login_cubit.dart';
import 'package:app/cubit/connectivity/connectivity_cubit.dart';
import 'package:app/cubit/get_followers/get_followers_cubit.dart';
import 'package:app/cubit/get_following/get_following_cubit.dart';
import 'package:app/models/users_model.dart';
import 'package:app/pages/my_friend_page.dart';
import 'package:app/utils/shimmer/home/all_chats/chat_page/chat_page_friend_info_shimmer.dart';
import 'package:app/widgets/all_chats_page/chat_page/chat_page_friend_info_bottom_sheet/chat_page_friend_info_bottom_sheet_body.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getnav;

class ChatPageFriendInfoBottomSheet extends StatefulWidget {
  const ChatPageFriendInfoBottomSheet({super.key, required this.user});
  final UserModel user;

  @override
  State<ChatPageFriendInfoBottomSheet> createState() =>
      _ChatPageFriendInfoBottomSheetState();
}

class _ChatPageFriendInfoBottomSheetState
    extends State<ChatPageFriendInfoBottomSheet> {
  @override
  void initState() {
    super.initState();
    context.read<GetFollowersCubit>().getFollowers(userID: widget.user.userID);
    context.read<GetFollowingCubit>().getFollowing(userID: widget.user.userID);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isDark = context.read<LoginCubit>().isDark;

    return GestureDetector(
      onVerticalDragUpdate: (details) {
        getnav.Get.to(() => MyFriendPage(user: widget.user),
            transition: getnav.Transition.downToUp);
      },
      child: Container(
        height: size.height * .4,
        width: size.width,
        decoration: BoxDecoration(
          color: isDark ? Color(0xff2b2c33) : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(size.width * .04),
            topRight: Radius.circular(size.width * .04),
          ),
        ),
        child: BlocBuilder<ConnectivityCubit, ConnectivityResult>(
          builder: (context, state) {
            if (state == ConnectivityResult.wifi ||
                state == ConnectivityResult.mobile ||
                state == ConnectivityResult.vpn) {
              return ChatPageFriendInfoBottomSheetBody(
                  size: size, user: widget.user);
            } else {
              return ChatPageFriendInfoShimmer(size: size);
            }
          },
        ),
      ),
    );
  }
}
