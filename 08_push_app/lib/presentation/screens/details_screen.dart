import 'package:flutter/material.dart';
import 'package:push_app/domain/entities/push_message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:push_app/presentation/blocs/notifications/notifications_bloc.dart';

class DetailsScreen extends StatelessWidget {
  final String pushMessageId;

  const DetailsScreen({super.key, required this.pushMessageId});

  @override
  Widget build(BuildContext context) {
    final PushMessage? notification =
        context.watch<NotificationsBloc>().getMessageById(pushMessageId);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles push'),
      ),
      body: notification != null
          ? _DetatilsView(
              notification: notification,
            )
          : const Text("F no hay"),
    );
  }
}

class _DetatilsView extends StatelessWidget {
  final PushMessage notification;

  const _DetatilsView({required this.notification});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          if (notification.imageUrl != null)
            Image.network(notification.imageUrl!),
          const SizedBox(
            height: 30,
          ),
          Text(
            notification.title,
            style: textTheme.titleMedium,
          ),
          Text(notification.body),
          const Divider(),
          Text(notification.data.toString())
        ],
      ),
    );
  }
}
