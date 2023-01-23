import 'dart:async';
import 'package:flutter/src/gestures/scale.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_detector/flutter_swipe_detector.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quote_app/Screens/home_notifier.dart';
import 'package:quote_app/Screens/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> implements HomeNotifier {
  HomeProvider? _provider;

  StreamController<Map?> dataStreamController = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    _provider = HomeProvider(this);
    _provider?.getQuote();
  }

  @override
  void onNewQuote(Map? map) {
    dataStreamController.add(map);
  }

  @override
  void dispose() {
    dataStreamController.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quote Of The Day ! '),
        backgroundColor: Colors.deepPurple,
      ),
      body: GestureDetector(
        onScaleStart: (ScaleStartDetails details) {
          if (details.pointerCount == 2) {
            dataStreamController.add(null);
            _provider?.getQuote();
            print('Two finger swipe detected');
          }
        },
        child: RefreshIndicator(
          color: Colors.white,
          backgroundColor: Colors.deepPurple,
          onRefresh: (){
            _provider?.getQuote();
            return dataStreamController.stream.first;
          },
          child: SingleChildScrollView(
            child: Container(
              //height: double.infinity,
              //width: double.infinity,
              constraints: BoxConstraints.expand(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
              child: StreamBuilder(
                stream: dataStreamController.stream,
                builder: ((context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.deepPurple,
                        color: Colors.white,
                      ),
                    );
                  }
                  Map? mapResponse = snapshot.data;
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          SelectableText(
                            mapResponse!["content"].toString(),
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Author - ${mapResponse["author"]}",
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Type - ${mapResponse['tags'][0]}",
                            style: GoogleFonts.lato(
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
