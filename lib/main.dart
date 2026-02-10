import 'package:flutter/material.dart';

void main() {
  runApp(const SmartGestureApp());
}

class SmartGestureApp extends StatelessWidget {
  const SmartGestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Gesture App',
      home: const MainNavigation(),
    );
  }
}

/* =========================
   MAIN NAVIGATION (MEMBER 1)
   ========================= */
class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    HomeScreen(),
    GestureLibraryScreen(),
    LiveConversationScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pan_tool), label: "Gestures"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat), label: "Chat"),
        ],
      ),
    );
  }
}

/* =========================
   HOME SCREEN (MEMBER 1)
   ========================= */
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Smart Gesture App")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Breaking Communication Barriers",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Smart Gesture App helps convert communication into Indian Sign Language (ISL) gestures to support hearing and speech impaired individuals.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "Current Modules:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("• Gesture Learning Library"),
            Text("• Live Conversation (Text → Gesture Demo)"),
          ],
        ),
      ),
    );
  }
}

/* =========================
   GESTURE LIBRARY (MEMBER 3)
   ========================= */
class GestureLibraryScreen extends StatelessWidget {
  const GestureLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gestures = [
      "Hello",
      "Thank You",
      "Yes",
      "No",
      "Help",
      "Stop",
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Gesture Library")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: gestures.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.pan_tool,
                      size: 50, color: Colors.blue),
                  const SizedBox(height: 10),
                  Text(
                    gestures[index],
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/* =========================
   LIVE CONVERSATION (MEMBER 3 – UPDATED)
   ========================= */
class LiveConversationScreen extends StatefulWidget {
  const LiveConversationScreen({super.key});

  @override
  State<LiveConversationScreen> createState() =>
      _LiveConversationScreenState();
}

class _LiveConversationScreenState extends State<LiveConversationScreen> {
  final TextEditingController controller = TextEditingController();
  String gestureResult = "";

  void convertTextToGesture() {
    String input = controller.text.toLowerCase().trim();

    if (input.contains("hi") || input.contains("hello")) {
      gestureResult = "👋 Hello Gesture";
    } else if (input.contains("thank")) {
      gestureResult = "🙏 Thank You Gesture";
    } else if (input.contains("yes")) {
      gestureResult = "👍 Yes Gesture";
    } else if (input.contains("no")) {
      gestureResult = "✋ No Gesture";
    } else if (input.contains("help")) {
      gestureResult = "🆘 Help Gesture";
    } else if (input.contains("stop")) {
      gestureResult = "✋ Stop Gesture";
    } else {
      gestureResult = "❓ Gesture not found";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Conversation")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: controller,
              decoration: const InputDecoration(
                labelText: "Enter text (hi, hello, thanks, yes...)",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  convertTextToGesture();
                });
              },
              child: const Text("Convert"),
            ),
            const SizedBox(height: 30),
            if (gestureResult.isNotEmpty)
              Column(
                children: [
                  const Text(
                    "Output Gesture:",
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 120,
                    width: 200,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      gestureResult,
                      style: const TextStyle(fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}



