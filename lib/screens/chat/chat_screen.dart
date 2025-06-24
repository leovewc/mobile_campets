import 'package:flutter/material.dart'; 

 

class ChatScreen extends StatelessWidget { 

  static String routeName = "/chat"; 

 

  const ChatScreen({super.key}); 

 

  @override 

  Widget build(BuildContext context) { 

    return SafeArea( 

      child: Column( 

        children: [ 

          Text( 

            "Messages", 

            style: Theme.of(context).textTheme.titleLarge, 

          ), 

          Expanded( 

            child: ListView( 

              padding: const EdgeInsets.all(16), 

              children: const [ 

                MessageCard( 

                  title: 'Notti Pet Food', 

                  content: 'Hello, your order has been shipped. Feel free to contact us anytime.', 

                  time: '09:30', 

                ), 

                SizedBox(height: 12), 

                MessageCard( 

                  title: 'Royal Canin Office Store', 

                  content: 'If you have any questions, you can contact me at any time~', 

                  time: 'Yesterday', 

                ), 

                SizedBox(height: 12), 

                MessageCard( 

                  title: 'Pedigree Office Store', 

                  content: 'There is a discount promotion in our store this week. Welcome to shop!', 

                  time: '2 days ago', 

                ), 

              ], 

            ), 

          ), 

        ], 

      ), 

    ); 

  } 

} 

 

class MessageCard extends StatelessWidget { 

  final String title; 

  final String content; 

  final String time; 

  const MessageCard({super.key, required this.title, required this.content, required this.time}); 

 

  @override 

  Widget build(BuildContext context) { 

    return Card( 

      color: Color.fromARGB(255, 255, 245, 230), 

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), 

      elevation: 2, 

      child: ListTile( 

        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)), 

        subtitle: Text(content), 

        trailing: Text(time, style: const TextStyle(color: Colors.grey, fontSize: 12)), 

      ), 

    ); 

  } 

} 