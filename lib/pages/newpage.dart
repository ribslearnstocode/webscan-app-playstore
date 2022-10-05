import 'package:flutter/material.dart';

class NewPage extends StatelessWidget {
  dynamic message;
  NewPage({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        
        
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 70,),
              Text(
                message.toString(), 
                
                style: const TextStyle(
                color: Colors.green,
                fontSize: 25,
                fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
