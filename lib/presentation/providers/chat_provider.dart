import 'package:flutter/material.dart';
import 'package:yes_no_app/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_app/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messageList = [
    // Message(text: 'Hola mor!', fromWho: FromWho.me),
    // Message(text: 'Ya regresaste del trabajo?', fromWho: FromWho.hers)
  ];

  Future<void> sendMessage(String text) async {
    // check if text is empty
    if (text.isEmpty) return;

    // Create new Message
    final newMessage = Message(text: text, fromWho: FromWho.me);
    // add it to our message list
    messageList.add(newMessage);

    if (text.endsWith('?')) {
      herReply();
    }

    // notify all listeners
    notifyListeners();
    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }

  Future<void> herReply() async {
    final herMessage = await getYesNoAnswer.getAnswer();
    messageList.add(herMessage);
    notifyListeners();
    moveScrollToBottom();
  }
}
