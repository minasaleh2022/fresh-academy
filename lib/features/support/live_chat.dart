import 'package:flutter/material.dart';
import '../../data/repo_provider.dart';
import '../../data/models.dart';
import '../../data/models.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});
  @override
  State<LiveChat> createState() => _LiveChatState();
}
class _LiveChatState extends State<LiveChat> {
  final _text = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final msgs = RepoProvider.RepoProvider.repo.getChatHistory().map((e)=> {'from': e['from'], 'text': e['text'], 'at': DateTime.fromMillisecondsSinceEpoch(e['at'] as int? ?? DateTime.now().millisecondsSinceEpoch)}).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('دردشة مباشرة مع الفني')),
      body: Column(
        children: [
          Expanded(child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: msgs.length,
            itemBuilder: (_, i){
              final m = msgs[i];
              final isMe = m.from=='me';
              return Align(
                alignment: isMe? Alignment.centerRight: Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  constraints: const BoxConstraints(maxWidth: 320),
                  decoration: BoxDecoration(
                    color: isMe? Colors.red.shade50: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(m.text),
                    const SizedBox(height: 4),
                    Text('${m.at.hour}:${m.at.minute.toString().padLeft(2,'0')}', style: const TextStyle(fontSize: 11, color: Colors.grey)),
                  ]),
                ),
              );
            },
          )),
          SafeArea(child: Row(children: [
            IconButton(onPressed: (){}, icon: const Icon(Icons.attach_file)),
            Expanded(child: TextField(controller: _text, decoration: const InputDecoration(hintText: 'اكتب رسالتك...'))),
            IconButton(onPressed: (){
              if(_text.text.trim().isEmpty) return;
              RepoProvider.RepoProvider.repo.addChat({'from':'me','text':_text.text.trim(),'at': DateTime.now().millisecondsSinceEpoch});
              setState((){}); _text.clear();
            }, icon: const Icon(Icons.send)),
          ])),
        ],
      ),
    );
  }
}
