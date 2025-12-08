import 'package:flutter/material.dart';
import 'package:rentverse/features/chat/presentation/pages/chat_list_page.dart';

class TenantChatPage extends StatelessWidget {
  const TenantChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ChatListPage(isLandlord: false);
  }
}
