//Venkata Saileenath Reddy Jampala
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: const MyApp(),
    ),
  );
}

class Counter with ChangeNotifier {
  int value = 0;

  void increment() {
    if (value < 99) {
      value += 1;
      notifyListeners();
    }
  }

  void decrement() {
    if (value > 0) {
      value -= 1;
      notifyListeners();
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Age Milestone Counter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var counter = context.watch<Counter>();
    
    Map<String, dynamic> getMilestone(int age) {
      if (age <= 12) {
        return {'message': "You're a child!", 'color': Colors.lightBlue};
      } else if (age <= 19) {
        return {'message': "Teenager time!", 'color': Colors.lightGreen};
      } else if (age <= 30) {
        return {'message': "You're a young adult!", 'color': Colors.yellow.shade200};
      } else if (age <= 50) {
        return {'message': "You're an adult now!", 'color': Colors.orange};
      } else {
        return {'message': "Golden years!", 'color': Colors.grey.shade300};
      }
    }

    var milestone = getMilestone(counter.value);

    return Scaffold(
      backgroundColor: milestone['color'],
      appBar: AppBar(title: const Text('Age Milestone Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Your Age:', style: TextStyle(backgroundColor: Color(0xFFE3F2FD))),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(milestone['message'], style: const TextStyle(fontSize: 20)),
            Slider(
              value: counter.value.toDouble(),
              min: 0,
              max: 99,
              divisions: 99,
              label: counter.value.toString(),
              onChanged: (double newValue) {
                counter.value = newValue.toInt();
                counter.increment();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: LinearProgressIndicator(
                value: counter.value / 99,
                color: counter.value <= 33
                    ? Colors.green
                    : counter.value <= 67
                        ? Colors.yellow
                        : Colors.red,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: counter.decrement,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
