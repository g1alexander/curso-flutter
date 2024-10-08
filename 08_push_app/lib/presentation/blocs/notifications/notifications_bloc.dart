import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:push_app/config/local_notifications/local_notifications.dart';
import 'package:push_app/domain/entities/push_message.dart';

import 'package:push_app/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  //TODO: save in isar DB

  print("Handling a background message: ${message.messageId}");
}

typedef ShowLocalNotif = void Function(
    {required int id, String? title, String? body, String? data});

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  int pushNumberId = 0;

  final Future<void> Function()? requestLocalNotifPermission;
  final ShowLocalNotif? showLocalNotif;

  NotificationsBloc({this.requestLocalNotifPermission, this.showLocalNotif})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);
    on<NotificationReceived>(_onPushMessageReceived);

    _initialStatusCheck(); //check permission
    _onForegroundMessage(); //listener
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _onPushMessageReceived(
      NotificationReceived event, Emitter<NotificationsState> emit) {
    emit(state
        .copyWith(notifications: [event.notification, ...state.notifications]));
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));

    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    final notification = PushMessage(
        messageId:
            message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '',
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        sentDate: message.sentTime ?? DateTime.now(),
        data: message.data,
        imageUrl: Platform.isAndroid
            ? message.notification?.android?.imageUrl
            : message.notification?.apple?.imageUrl);

    // LocalNotifications.show(
    //     id: ++pushNumberId,
    //     title: notification.title,
    //     body: notification.body,
    //     data: notification.data.toString());

    if (showLocalNotif != null) {
      showLocalNotif!(
          id: ++pushNumberId,
          title: notification.title,
          body: notification.body,
          data:
              message.messageId?.replaceAll(':', '').replaceAll('%', '') ?? '');
    }

    add(NotificationReceived(notification));
  }

  void _onForegroundMessage() {
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    //TODO: Se puede implementar con permision_handler

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    // await LocalNotifications.requestPermission();

    if (requestLocalNotifPermission != null) {
      await requestLocalNotifPermission!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  PushMessage? getMessageById(String pushMessageId) {
    final exist =
        state.notifications.any((notif) => notif.messageId == pushMessageId);

    if (!exist) return null;

    return state.notifications
        .firstWhere((notif) => notif.messageId == pushMessageId);
  }
}
