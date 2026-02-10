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
    VoiceGestureScreen(),
    GestureLibraryScreen(),
    LiveConversationScreen(),
    SosScreen(), // MEMBER 4
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
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mic), label: "Voice"),
          BottomNavigationBarItem(icon: Icon(Icons.pan_tool), label: "Gestures"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.warning, color: Colors.red), label: "SOS"),
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
            Text("• Voice → Gesture"),
            Text("• Gesture Learning Library"),
            Text("• Live Conversation"),
            Text("• Emergency SOS"),
          ],
        ),
      ),
    );
  }
}

/* =========================
   VOICE → GESTURE (MEMBER 2)
   ========================= */
class VoiceGestureScreen extends StatefulWidget {
  const VoiceGestureScreen({super.key});

  @override
  State<VoiceGestureScreen> createState() => _VoiceGestureScreenState();
}

class _VoiceGestureScreenState extends State<VoiceGestureScreen> {
  String spokenText = "";
  String gestureResult = "";

  void onMicPressed() {
    setState(() {
      spokenText = "Hello";
      gestureResult = "👋 Hello Gesture";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Voice → Gesture")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.mic, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: onMicPressed,
              child: const Text("Tap to Speak"),
            ),
            const SizedBox(height: 30),
            if (spokenText.isNotEmpty)
              Column(
                children: [
                  const Text(
                    "Recognized Speech:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(spokenText, style: const TextStyle(fontSize: 20)),
                  const SizedBox(height: 20),
                  const Text(
                    "Detected Gesture:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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

/* =========================
   GESTURE LIBRARY (MEMBER 3)
   ========================= */
class GestureLibraryScreen extends StatefulWidget {
  const GestureLibraryScreen({super.key});

  @override
  State<GestureLibraryScreen> createState() => _GestureLibraryScreenState();
}

class _GestureLibraryScreenState extends State<GestureLibraryScreen> {
  final TextEditingController searchController = TextEditingController();

  final List<Map<String, dynamic>> allGestures = [
    {"name": "Hello", "icon": Icons.waving_hand},
    {"name": "Thank You", "icon": Icons.favorite},
    {"name": "Yes", "icon": Icons.thumb_up},
    {"name": "No", "icon": Icons.thumb_down},
    {"name": "Help", "icon": Icons.help},
    {"name": "Stop", "icon": Icons.stop},
    {"name": "Water", "icon": Icons.water_drop},
    {"name": "Food", "icon": Icons.restaurant},
    {"name": "Doctor", "icon": Icons.local_hospital},
    {"name": "Emergency", "icon": Icons.warning},
  ];

  List<Map<String, dynamic>> filteredGestures = [];

  @override
  void initState() {
    super.initState();
    filteredGestures = allGestures;
  }

  void searchGesture(String query) {
    setState(() {
      filteredGestures = allGestures
          .where((g) =>
          g["name"].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Gesture Library")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: searchController,
              onChanged: searchGesture,
              decoration: const InputDecoration(
                hintText: "Search gesture",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: filteredGestures.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
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
                        Icon(
                          filteredGestures[index]["icon"],
                          size: 50,
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          filteredGestures[index]["name"],
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   LIVE CONVERSATION (MEMBER 3)
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

    if (input.contains("hello")) {
      gestureResult = "👋 Hello Gesture";
    } else if (input.contains("thank")) {
      gestureResult = "🙏 Thank You Gesture";
    } else if (input.contains("help")) {
      gestureResult = "🆘 Help Gesture";
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
                labelText: "Enter text",
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
              Text(
                gestureResult,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}

/* =========================
   SOS SCREEN (MEMBER 4)
   ========================= */
class SosScreen extends StatelessWidget {
  const SosScreen({super.key});

  void showSosAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("🚨 Emergency Alert"),
        content: const Text(
            "SOS activated.\nEmergency contacts will be notified."),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Emergency SOS"),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Emergency Assistance",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.red),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => showSosAlert(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding:
                const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
              ),
              child: const Text(
                "SOS",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
