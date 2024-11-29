import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 

void main() async {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();

  if(kIsWeb){
    await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: "AIzaSyDiSzdp1vNlFLYlj-chQdZo-B6RoIzg238",
    authDomain: "delhi-monuments-86cfb.firebaseapp.com",
    databaseURL: "https://delhi-monuments-86cfb-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "delhi-monuments-86cfb",
    storageBucket: "delhi-monuments-86cfb.firebasestorage.app",
    messagingSenderId: "878634850858",
    appId: "1:878634850858:web:78708f539fb8f2cbf0c153",
    measurementId: "G-Y3WL98GNCQ"));
  }else{
    Firebase.initializeApp();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historical Monuments of Delhi',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historical Monuments of Delhi'),
      ),
      body: ListView(
        children: [
          MonumentButton(
            title: 'Red Fort',
            description:
                'A UNESCO World Heritage Site and symbol of India\'s rich history.',
            color: Colors.redAccent,
          ),
          MonumentButton(
            title: 'Qutub Minar',
            description:
                'The tallest brick minaret in the world, standing at 73 meters.',
            color: Colors.greenAccent,
          ),
          MonumentButton(
            title: 'India Gate',
            description:
                'A war memorial honoring soldiers who died in World War I.',
            color: Colors.blueAccent,
          ),
          MonumentButton(
            title: 'Humayun\'s Tomb',
            description:
                'A beautiful garden tomb and UNESCO World Heritage Site.',
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

class MonumentButton extends StatelessWidget {
  final String title;
  final String description;
  final Color color;

  const MonumentButton({
    Key? key,
    required this.title,
    required this.description,
    required this.color,
  }) : super(key: key);

  Future<void> _incrementClickCount() async {
    final monumentRef =
        FirebaseFirestore.instance.collection('monuments').doc(title);
    
    await monumentRef.set({
      'clickCount': FieldValue.increment(1),
    }, SetOptions(merge: true)); // Increment click count in Firestore
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: () async {
          await _incrementClickCount(); // Increment click count in Firestore
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  MonumentDetailPage(title: title, description: description),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration:
              BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
          child:
              Row(children:[Expanded(child:
                  Text(title, style:
                  const TextStyle(fontSize:
                  20, color:
                  Colors.white)))],
              ),
        ),
      ),
    );
  }
}

class MonumentDetailPage extends StatelessWidget {
  final String title;
  final String description;

  const MonumentDetailPage({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(title),
      ),
      body:
          Padding(padding:
              const EdgeInsets.all(16.0), child:
              Column(crossAxisAlignment:
              CrossAxisAlignment.start, children:[
                const SizedBox(height:
                20),
                Text(title, style:
                const TextStyle(fontSize:
                24, fontWeight:
                FontWeight.bold)),
                const SizedBox(height:
                10),
                Text(description, style:
                const TextStyle(fontSize:
                16)),
                const SizedBox(height:
                20),
                ElevatedButton(onPressed:
                    () => Navigator.pop(context), child:
                    const Text('Back to Home'), style:
                    ElevatedButton.styleFrom(backgroundColor:
                    Colors.blue)), // Use backgroundColor instead of primary
              ],
              ),
              ),
              );
              }
}