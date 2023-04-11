import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Chat')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chats/gCN7gcJB69pOQwCZ28ui/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          final documents = streamSnapshot.data!.docs;
          return streamSnapshot.connectionState == ConnectionState.waiting
              ? CircularProgressIndicator()
              : ListView.builder(
                  itemCount: documents.length,
                  itemBuilder: (ctx, index) => Container(
                    padding: EdgeInsets.all(8),
                    child: Text(documents[index]['text']),
                  ),
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/gCN7gcJB69pOQwCZ28ui/messages')
              .add({'text': 'This was added by clicking a button!'});
        },
      ),
    );
  }
}
