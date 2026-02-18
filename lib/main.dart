import 'package:flutter/material.dart';

void main() {
  runApp(StudifyAI());
}

class StudifyAI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Studify AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {

  TextEditingController controller = TextEditingController();

  List<Map<String, String>> messages = [];

  void sendMessage() {

    String text = controller.text;

    if(text.isEmpty) return;

    setState(() {
      messages.add({"role": "user", "text": text});

      messages.add({
        "role": "ai",
        "text": "Hello! Tumne bola: $text"
      });
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("Studify AI"),
        centerTitle: true,
      ),

      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {

                bool isUser =
                    messages[index]["role"] == "user";

                return Container(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,

                  padding: EdgeInsets.all(10),

                  child: Container(
                    padding: EdgeInsets.all(12),

                    decoration: BoxDecoration(
                      color: isUser
                          ? Colors.blue
                          : Colors.grey[800],

                      borderRadius:
                          BorderRadius.circular(12),
                    ),

                    child: Text(
                      messages[index]["text"]!,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
            ),
          ),

          Row(
            children: [

              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "Message...",
                    contentPadding:
                        EdgeInsets.all(10),
                  ),
                ),
              ),

              IconButton(
                icon: Icon(Icons.send),
                onPressed: sendMessage,
              )

            ],
          )

        ],
      ),

    );
  }
}
