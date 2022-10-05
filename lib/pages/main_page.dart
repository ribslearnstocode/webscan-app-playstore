import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'package:web_scan/bloc/bloc.dart';
import 'newpage.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  bool isshow = false;
  WebSocketChannel? channel;
  @override
  void initState() {
    super.initState();
    socketBloc.initboolIsDisplay();
    channel = WebSocketChannel.connect(
      // Uri.parse('wss://echo.websocket.events'),
      Uri.parse('wss://final-app-rewasoft.herokuapp.com'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          

          body: Container(
            decoration: const BoxDecoration(image: DecorationImage(image: AssetImage("animations/hacking3.jpg"),fit: BoxFit.cover)),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Don\'t use http:// or https://'),
                  const SizedBox(
                    height: 258,
                  ),
                  Form(
                    child: TextFormField(
                      style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                      controller: _controller,
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        focusedBorder:  UnderlineInputBorder(
                            borderSide:  BorderSide(color: Colors.white)),
                        
                       
                        hintText: 'Enter website\'s name',
                        hintStyle:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20) ,
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                        prefixIcon: Icon(
                          Icons.enhanced_encryption,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  const Text('Usage: ',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
                  const SizedBox(height: 5,),
                  const Text('www.<website>.com for port scan only',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),
                  const Text('<website>.com for both port and subdomain scan',style:  TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 17),),

                  const SizedBox(height: 24),
                  Center(
                    child: ElevatedButton(onPressed: _sendMessage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green
                    ),
                    // color: Colors.white,
                    child: const Text('Scan Website'),

                    ),
                  ),
                  StreamBuilder(
                    stream: channel!.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        socketBloc.updateIsDisplay(false);
                        WidgetsBinding.instance.addPostFrameCallback((_) =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    NewPage(message: snapshot.data))));
                        
                      }
                      return Container();
                    },
                  )
                ],
              ),
            ),
          ),
           // This trailing comma makes auto-formatting nicer for build methods.
        ),
        StreamBuilder<bool?>(
            stream: socketBloc.isDisplay,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!) {
                  return Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey.withOpacity(0.5),
                    child: const Center(child:  CircularProgressIndicator()),
                  );
                }
              }
              return Container();
            })

        // isshow
        //     ?
        //     : Container()
      ],
    );
  }

  void _sendMessage() {
    socketBloc.updateIsDisplay(true);
    if (_controller.text.isNotEmpty) {
      channel!.sink.add("start ${Uri.parse(_controller.text)}");
    }
  }

  @override
  void dispose() {
    channel!.sink.close();
    _controller.dispose();
    super.dispose();
  }
}
