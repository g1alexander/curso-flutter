import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yesnoapp/domain/entities/message.dart';
import 'package:yesnoapp/presentation/providers/chat_provider.dart';
import 'package:yesnoapp/presentation/widgets/chat/her_message_bubble.dart';
import 'package:yesnoapp/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yesnoapp/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(4.0),
          child: CircleAvatar(
            backgroundImage: NetworkImage(
                "https://www.instyle.com/thmb/AOl4dn9Az3wVU-RGwFvNvWANveM=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc()/GettyImages-1492700483-a36ac6d0cb074f44883475569c5005ad.jpg"),
          ),
        ),
        title: const Text("Mi amor"),
      ),
      body: _ChatView(),
    );
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              controller: chatProvider.chatScrollController,
              itemCount: chatProvider.messageList.length,
              itemBuilder: (context, index) {
                final message = chatProvider.messageList[index];

                return (message.fromWho == FromWho.her)
                    ? HerMessageBubble(message: message)
                    : MyMessageBubble(message: message);
              },
            )),

            const SizedBox(
              height: 5,
            ),
            // box text
            MessageFieldBox(
              onValue: (value) => chatProvider.sendMessage(value),
            ),

            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
