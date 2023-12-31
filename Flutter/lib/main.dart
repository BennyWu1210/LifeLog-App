import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

const bgcolor = Color.fromRGBO(255, 247, 219, 1);
const medgreen = Color.fromRGBO(144, 176, 91, 1);
const dark = Color.fromRGBO(62, 62, 62, 1);
const darkgreen = Color.fromRGBO(74, 129, 18, 1);

const TextStyle header = TextStyle(
  fontWeight: FontWeight.w500,
  fontSize: 24,
  color: dark
);

const TextStyle submenuHeader = TextStyle(
    fontWeight: FontWeight.w400,
    color: darkgreen,
    fontSize: 22
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromRGBO(134, 177, 9, 1),
            brightness: Brightness.light
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: bgcolor,
        fontFamily: GoogleFonts.jost().fontFamily
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}


/*
  ----------------------- Homepage ----------------------------
 */

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgcolor,
        centerTitle: true,
        title: Image.asset(
          'assets/images/lp_logo_l.png',
          scale: 4,
        )
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                const SizedBox(height: 0,),
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$_counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),

            Positioned(
              bottom: 30.0,  // Adjust this value to move the buttons upwards
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Friends',
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: const Icon(Icons.group, color: dark, size: 30.0,)
                  ),
                  const SizedBox(width: 40,),
                  FloatingActionButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const CreatePostPage()),
                        );
                      },
                      tooltip: 'Increment',
                      backgroundColor: medgreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: const Icon(Icons.add, color: Colors.white, size: 35.0,)
                  ),
                  const SizedBox(width: 40,),
                  FloatingActionButton(
                      onPressed: _incrementCounter,
                      tooltip: 'Settings',
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      child: const Icon(Icons.settings, color: dark, size: 30.0,)
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButton:
    );
  }
}


/*
  ----------------------- Post Page ----------------------------
 */

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({Key? key}) : super(key: key);

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {

  // final journalTitleController = TextEditingController();
  // final journalTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'New Journal',
          style: header
        ),
        backgroundColor: bgcolor,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                  labelText: "Journal Title",
                  border: InputBorder.none,
              ),
              style: submenuHeader,
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pop(context); // placeholder
        },
        tooltip: "Post",
        backgroundColor: medgreen,
          child: const Icon(Icons.send, color: Colors.white, size: 26.0,)
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

