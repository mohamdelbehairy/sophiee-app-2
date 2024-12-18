import 'package:app/cubit/delete_messages/delete_chat_message_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_cubit.dart';
import 'package:app/cubit/user_date/get_user_data/get_user_data_state.dart';
import 'package:app/cubit/message/message_cubit.dart';
import 'package:app/cubit/message/message_state.dart';
import 'package:app/cubit/upload/upload_audio/upload_audio_cubit.dart';
import 'package:app/models/message_model.dart';
import 'package:app/models/users_model.dart';
import 'package:app/utils/widget/replay_to_message/replay_audio_message.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_chat_page_text_field_item.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_message/custom_message_list_view.dart';
import 'package:app/widgets/all_chats_page/chat_page/custom_chat_send_text_and_record_item.dart';
import 'package:app/utils/widget/replay_to_message/replay_contact_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_file_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_image_message.dart';
import 'package:app/utils/widget/replay_to_message/replay_text_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class ChatPageBodyDetails extends StatefulWidget {
  const ChatPageBodyDetails(
      {super.key, required this.user, required this.size});
  final UserModel user;
  final Size size;

  @override
  State<ChatPageBodyDetails> createState() => _ChatPageBodyDetailsState();
}

class _ChatPageBodyDetailsState extends State<ChatPageBodyDetails> {
  final scrollController = ScrollController();
  late TextEditingController textEditingController;
  bool isShowSendButton = false;
  bool isSwip = false;

  MessageModel? messageModel;
  UserModel? userData;
  late FocusNode focusNode;

  @override
  void initState() {
    context.read<MessageCubit>().getMessage(receiverID: widget.user.userID);
    super.initState();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    textEditingController.dispose();
    focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var messages = context.read<MessageCubit>();
    var uploadAudio = context.read<UploadAudioCubit>();
    // var deleteAllMediaFiles = context.read<DeleteChatMessageCubit>();

    return BlocListener<DeleteChatMessageCubit, DeleteChatMessageState>(
      listener: (context, stateDelete) async {
        if (stateDelete is DeleteChatMessageSuccess) {
          if (await messages.isChatsEmpty(friendID: widget.user.userID)) {
            messages.deleteChat(
                friendID: widget.user.lastMessage?['lastUserID']);
            // await deleteAllMediaFiles.deleteChatAllMediaFiles(
            //     friendID: widget.user.lastMessage?['lastUserID']);
          }
        }
      },
      child: BlocConsumer<MessageCubit, MessageState>(
        listener: (context, state) async {
          // if (state is DeleteMessageSuccess) {
          //   if (await messages.isChatsEmpty(friendID: widget.user.userID)) {
          //     messages.deleteChat(
          //         friendID: widget.user.lastMessage?['lastUserID']);
          //   }
          // }
          if (state is SendMessageSuccess || state is GetMessageSuccess) {
            setState(() {
              isSwip = false;
              // isShowSendButton = textEditingController.text.trim().isNotEmpty;
              // focusNode.requestFocus();
            });
          }
        },
        builder: (context, state) {
          // if(state is MessageLoading) {
          //   return MessagePageShimmer();
          // }
          return Stack(
            children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: scrollController,
                      physics: const BouncingScrollPhysics(),
                      itemCount: messages.messages.length,
                      itemBuilder: (context, index) {
                        var message =
                            context.read<MessageCubit>().messages[index];
                        if (!message.isSeen &&
                            message.senderID !=
                                FirebaseAuth.instance.currentUser!.uid) {
                          messages.updateChatMessageSeen(
                              receiverID: widget.user.userID,
                              messageID: message.messageID);
                        }
                        return SwipeTo(
                          onLeftSwipe: (details) {
                            setState(() {
                              isSwip = !isSwip;
                              messageModel = message;
                              focusNode.requestFocus();
                            });
                          },
                          key: Key(message.messageID),
                          child: CustomMessageListView(
                              user: widget.user,
                              message: message,
                              size: widget.size),
                        );
                      },
                    ),
                  ),
                  if (isSwip) SizedBox(height: widget.size.height * .01),
                  Column(
                    children: [
                      if (isSwip)
                        if (messageModel!.messageText != '' &&
                            messageModel!.messageImage == null &&
                            messageModel!.messageFileName == null)
                          ReplayTextMessage(
                              user: widget.user,
                              messageModel: messageModel!,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip)
                        if (messageModel!.messageImage != null &&
                            messageModel!.messageText == '')
                          ReplayImageMessage(
                              messageModel: messageModel!,
                              user: widget.user,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip)
                        if (messageModel!.messageImage != null &&
                            messageModel!.messageText != '')
                          ReplayImageMessage(
                              messageModel: messageModel!,
                              user: widget.user,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip)
                        if (messageModel!.messageFile != null)
                          ReplayFileMessage(
                            messageModel: messageModel!,
                            user: widget.user,
                            onTap: () {
                              setState(() {
                                isSwip = false;
                              });
                            },
                          ),
                      if (isSwip)
                        if (messageModel!.phoneContactNumber != null)
                          ReplayContactMessage(
                              messageModel: messageModel!,
                              user: widget.user,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip)
                        if (messageModel!.messageSound != null)
                          ReplayAudioMessage(
                              messageModel: messageModel!,
                              user: widget.user,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip)
                        if (messageModel!.messageRecord != null)
                          ReplayAudioMessage(
                              messageModel: messageModel!,
                              user: widget.user,
                              onTap: () {
                                setState(() {
                                  isSwip = false;
                                });
                              }),
                      if (isSwip) SizedBox(height: widget.size.height * .003),
                      BlocBuilder<GetUserDataCubit, GetUserDataStates>(
                        builder: (context, state) {
                          if (state is GetUserDataSuccess &&
                              state.userModel.isNotEmpty) {
                            if (isSwip) {
                              final currentUser = messageModel!.senderID;
                              userData = state.userModel.firstWhere(
                                  (element) => element.userID == currentUser);
                            }
                          }
                          return CustomChatPageTextFieldItem(
                              onChanged: (value) {
                                setState(() {
                                  isShowSendButton = value.trim().isNotEmpty;
                                });
                                print(value.length);
                              },
                              widget: widget,
                              textEditingController: textEditingController,
                              scrollController: scrollController,
                              focusNode: focusNode,
                              isSwip: isSwip,
                              messageModel: messageModel,
                              userData: userData);
                        },
                      ),
                    ],
                  ),
                ],
              ),
              CustomChatSendTextAndRecordItem(
                  stopRecording: (value) {
                    setState(() {
                      isSwip = false;
                    });
                  },
                  isShowSendButton: isShowSendButton,
                  scrollController: scrollController,
                  messages: messages,
                  widget: widget,
                  textEditingController: textEditingController,
                  isSwip: isSwip,
                  messageModel: messageModel,
                  userData: userData,
                  uploadAudio: uploadAudio)
            ],
          );
        },
      ),
    );
  }
}
