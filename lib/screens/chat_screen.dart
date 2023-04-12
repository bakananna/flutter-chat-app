import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: Row(
                  children: const <Widget>[
                    Icon(Icons.exit_to_app),
                    Text('Logout'),
                  ],
                ),
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(5),
        child: Column(children: const <Widget>[
          Expanded(child: Messages()), // List View
          NewMessage(),
        ]),
      ),

      // StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/gCN7gcJB69pOQwCZ28ui/messages')
      //       .snapshots(),
      //   builder: (ctx, streamSnapshot) {
      //     final documents = streamSnapshot.data!.docs;
      //     return streamSnapshot.connectionState == ConnectionState.waiting
      //         ? CircularProgressIndicator()
      //         : ListView.builder(
      //             itemCount: documents.length,
      //             itemBuilder: (ctx, index) => Container(
      //               padding: EdgeInsets.all(8),
      //               child: Text(documents[index]['text']),
      //             ),
      //           );
      //   },
      // ),

      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/gCN7gcJB69pOQwCZ28ui/messages')
      //         .add({'text': 'This was added by clicking a button!'});
      //   },
      // ),
    );
  }
}
