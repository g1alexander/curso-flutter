import 'package:flutter/material.dart';
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
              itemCount: 100,
              itemBuilder: (context, index) {
                return (index % 2 == 0)
                    ? const HerMessageBubble()
                    : const MyMessageBubble();
              },
            )),

            const SizedBox(
              height: 5,
            ),
            // box text
            const MessageFieldBox(),

            const SizedBox(
              height: 5,
            )
          ],
        ),
      ),
    );
  }
}
