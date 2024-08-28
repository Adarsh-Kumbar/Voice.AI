import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voice_ai/feature_box.dart';
import 'package:voice_ai/openai_service.dart';
import 'package:voice_ai/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final speechToText = SpeechToText();

  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;

  @override
  void initState() {
    super.initState();
    initSpeechToText();

  }



  Future<void> initSpeechToText() async {
    try {
      await speechToText.initialize();
      setState(() {});
    } catch (e) {
      print("Error initializing speech to text: $e");
    }
  }

  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      if (result.finalResult) {
        //as finalResult return true when the entire sentence has been completed.
        openAIService.isArtPromptAPI(lastWords);
      }
    });
  }

  Future<void> systemSpeak(String content) async {

  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 244, 236, 236),
      
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.amber,
          statusBarColor: Colors.amberAccent,
        ),
        title: const Text('Voice.AI'),
        leading: const Icon(Icons.menu),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Stack(
            children: [
              Center(
                child: Container(
                  height: 120,
                  width: 120,
                  margin: const EdgeInsets.only(top: 4),
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 183, 142, 218),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Container(
                height: 135,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image:
                            AssetImage('assets/images/roboAssistant.png'))),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
              top: 30,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(255, 200, 200, 200),
                ),
                borderRadius: BorderRadius.circular(20).copyWith(
                  topLeft: Radius.zero,
                )),
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Text(
                'Hello, Good Morning What can I do for you?',
                style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Color.fromARGB(255, 50, 46, 57),
                  fontSize: 25,
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              top: 10,
              left: 22,
            ),
            child: const Text(
              'Here are our latest features',
              style: TextStyle(
                fontFamily: 'Cera Pro',
                color: Color.fromARGB(255, 95, 19, 71),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Column(
            children: [
              FeatureBox(
                color: Color.fromARGB(255, 206, 244, 165),
                headerText: 'ChatGPT',
                descriptionText:
                    'A smarter way to stay organised and infromed with ChatGPT',
              ),
              FeatureBox(
                color: Color.fromARGB(255, 235, 169, 157),
                headerText: 'Dall-E',
                descriptionText:
                    'Get inspired and stay creative with your personal assistant powered by Dall-E',
              ),
              FeatureBox(
                color: Color.fromARGB(255, 186, 162, 239),
                headerText: 'Smart Voice Assistant',
                descriptionText:
                    'Get the best of both worlds with a voice assistant powered by Dall-E and ChatGPT',
              ),
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 86, 205, 235),
        onPressed: () async {
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            // API Call
            final speech = await openAIService.isArtPromptAPI(lastWords);
            if(speech.contains('https')){
              generatedImageUrl = speech;
              generatedContent = null;
            }
            else{
              generatedImageUrl = null;
              generatedContent = speech;
            }
            await systemSpeak(speech);
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
