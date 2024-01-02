import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'journal.dart';
import 'style.dart';

void main() {
  runApp(const MyApp());
}

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

List<String> a = ['a', 'b', 'c'];

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
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 25),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 10,),
                  ListView.builder(
                    itemCount: journalList.length,
                    itemBuilder: (BuildContext context, int index){
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 0),
                        child: Card(
                          color: medgreen,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                            child: ListTile(
                              title: Text(journalList[index].title, style: whiteSubmenuHeader),
                              subtitle: Text(
                                journalList[index].content,
                                style: const TextStyle(color: Colors.white, fontSize: 12),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                              onTap: () {
                                // Navigate to the journal entry page
                              },
                            ),
                          ),
                        ),
                      );
                    },
                    shrinkWrap: true,
                  )
                ],
              ),
            ),


            /*
            The bottom navbar consisting of three FABs in a row
             */
            Positioned(
              bottom: 30.0,  // Adjust this value to move the buttons upwards
              left: 0.0,
              right: 0.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FloatingActionButton(
                      onPressed: null,
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
                      onPressed: null,
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
        padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 12),
              child: TextFormField(
                decoration: const InputDecoration(
                    labelText: "Journal Title",
                    border: InputBorder.none,
                    hintText: "What's going on in your life?",
                    hintStyle: hintText,
                    labelStyle: submenuHeader
                ),
                style: submenuHeader,
              ),
            ),

            Container(
              decoration: BoxDecoration(
                color: lightgreen,
                borderRadius: BorderRadius.circular(20.0),
              ),
              padding: const EdgeInsets.only(left: 20, top: 0, right: 20, bottom: 60),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: "How's it going?",
                  border: InputBorder.none,
                  labelStyle: hintText
                ),
                style: bodyText,
                maxLines: null,
              ),
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

