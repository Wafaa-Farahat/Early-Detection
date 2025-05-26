import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class useApp extends StatefulWidget {
  @override
  State<useApp> createState() => _useAppState();
}

class _useAppState extends State<useApp> {
  final VideoPlayerController _controller = VideoPlayerController.asset('images/videos/test.mp4');

  @override
  void initState() {
    super.initState();
    _controller.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized
      setState(() {});
    });
  }
  //27, 38, 44
//15, 76, 117
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(border: Border.all(color: Color.fromRGBO(
              15, 76, 117, 1),width: 10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      Expanded(child: Text("Welcome to Early Detection App, we will give you a hand to navigate through our app",
                        style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromRGBO(15, 76, 117, 1),fontSize: 20),))
                    ],
                  ),
                ),
              ),
              Divider(thickness: 3),
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        textnumber("Firstly :"),
                        text("On the onset, you can find a splash screen followed by Onboarding one "),
                        textnumber("secondly :"),
                        text("In case you have an account, you simply can login, if not you may create one through the sign up button "
                            "by following quick steps."),
                        textnumber("Thirdly :"),
                        text("Here, you can fill some info up relating to the role you are taking "
                            "on the application. "),
                        textnumber("Fourthly:"),
                        Row(
                          children: [
                            text("Regarding doctors :"),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            subtext("* You can find their patients, follow their status. and write reports about their health."
                                " \n\n * Furthermore, you can run tests on their patients and check them."
                                "\n\n * 100 % control over your profile"),
                          ],
                        ),

                        textnumber("Fifthly:"),
                        Row(
                          children: [
                            text("Regarding patients :"),
                          ],
                        ),
                        Column(

                          children: [
                            subtext("* The app provides a prompt access to your doctors in addition to a further feature"
                                "to follow them "
                                "\n\n * Also, you are able to find previous tests and run new ones."
                                " \n\n * 100% control over your profile"),
                          ],),
                        textnumber("Finally:"),
                        text("For more info about the app, please watch the attached video."),
                        SizedBox(height: 20,),
                        Center(
                          child: _controller.value.isInitialized
                              ? GestureDetector(
                            onTap: () {
                              setState(() {
                                _controller.value.isPlaying ? _controller.pause() : _controller.play();
                              });
                            },
                            child: SizedBox(
                              height: 300,
                              width: 200,
                              child: AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                child: Stack(
                                  alignment: Alignment.bottomCenter,
                                  children: [
                                    VideoPlayer(_controller),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.play_arrow),
                                          onPressed: () {
                                            setState(() {
                                              _controller.play();
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.pause),
                                          onPressed: () {
                                            setState(() {
                                              _controller.pause();
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                    VideoProgressIndicator(
                                      _controller,
                                      allowScrubbing: true,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          )
                              : CircularProgressIndicator(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

}

class textnumber extends StatelessWidget {
  String newMainText = "";


  textnumber(this.newMainText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text("$newMainText",style: TextStyle(fontSize: 20,color: Color.fromRGBO(
              50, 130, 184, 1.0),fontWeight: FontWeight.bold,),)
        ],
      ),
    );
  }
}

class text extends StatelessWidget {
  String newText = "";


  text(this.newText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text("$newText ",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
        ],
      ),
    );
  }
}
class subtext extends StatelessWidget {
  String newText = "";


  subtext(this.newText);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Text("$newText",style: TextStyle(fontSize: 15,color: Colors.black,fontWeight: FontWeight.bold),),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}
