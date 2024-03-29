import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatGPTScreen extends StatefulWidget {
  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();

  void onSendMessage() async {
    Message message = Message(text: _textEditingController.text, isMe: true);

    _textEditingController.clear();

    setState(() {
      _messages.insert(0, message);
    });

    try {
      String response = await sendMessageToChatGpt(message.text);

      if (response != null) {
        Message chatGpt = Message(text: response, isMe: false);

        setState(() {
          _messages.insert(0, chatGpt);
        });
      } else {
        // Handle the case where there's no valid response
      }
    } catch (e) {
      // Handle network or other errors
      print("Error: $e");
    }
  }

  Future<String> sendMessageToChatGpt(String message) async {


    if (apiKey.isEmpty) {
      return "API key missing or invalid";
    }

    // final modelEndpoint =
    //     "https://api.openai.com/v1/completions"; // Check the correct endpoint

    Uri uri = Uri.parse(modelEndpoint);

    Map<String, dynamic> body = {
      "prompt": message,
      "max_tokens": 100,
    };

    try {
      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $apiKey",
        },
        body: json.encode(body),
      );

      if (response.statusCode == 200) {
        final parsedResponse = json.decode(response.body);

        if (parsedResponse.containsKey('choices') &&
            parsedResponse['choices'].isNotEmpty) {
          String reply = parsedResponse['choices'][0]['text'];
          return reply;
        } else {
          // Handle the case where there's no valid response in the choices
          return "No valid response";
        }
      } else {
        // Handle other HTTP response errors
        return "HTTP Error: ${response.statusCode}";
      }
    } catch (e) {
      // Handle network or other errors
      print("Error: $e");
      return "Error occurred: $e";
    }
  }

  Widget _buildMessage(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          crossAxisAlignment:
              message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              message.isMe ? 'You' : 'BOT',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              message.text,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('ChatBOT'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return _buildMessage(_messages[index]);
              },
            ),
          ),
          const Divider(height: 1.0),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(10.0),
                      hintText: 'Type a message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: onSendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});
}
