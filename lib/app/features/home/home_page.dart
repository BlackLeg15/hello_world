import 'package:flutter/material.dart';
import 'package:form/form.dart';
import 'package:hello_world/app/features/home/custom_inherited.dart';
import 'package:hello_world/app/features/home/pages/second_page.dart';
import 'package:poke_list/poke_list.dart';

import 'widgets/custom_stateful_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _counter = 0;

  var widgetList = <Widget>[
    const CustomStatefulWidget(color: Colors.red),
    const CustomStatefulWidget(color: Colors.blue),
  ];

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void changeOrder() {
    setState(() {
      final statefulWidget = widgetList.removeAt(0);
      widgetList.add(statefulWidget);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //children: widgetList,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.headline6,
            ),
            Semantics(
              liveRegion: true,
              child: Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            ExcludeSemantics(child: CustomInherited(child: const CustomCounter(), counterValue: _counter)),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SecondPage()));
              },
              child: const Text('Go to the second page'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const FormFeature()));
              },
              child: const Text('Go to the form'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => const PokeListFeature()));
              },
              child: const Text('Go to the poke list'),
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: changeOrder,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ),
      floatingActionButton: Semantics(
        button: true,
        label: 'Incrementar',
        child: ExcludeSemantics(
          child: FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class CustomCounter extends StatefulWidget {
  const CustomCounter({super.key});

  @override
  State<CustomCounter> createState() => _CustomCounterState();
}

class _CustomCounterState extends State<CustomCounter> {
  CustomInherited? inherited;
  var isLoading = false;
  var textController = TextEditingController();

  Future<void> httpRequest() {
    return Future.delayed(const Duration(seconds: 2));
  }

  void setLoading(bool value) {
    setState(() {
      isLoading = value;
    });
  }

  void init() {
    isLoading = true;
    httpRequest().then((value) {
      setLoading(false);
    });
  }

  @override
  void initState() {
    init();
    textController.addListener(textControllerListener);
    super.initState();
  }

  void textControllerListener() {
    debugPrint(textController.text);
  }

  @override
  void didChangeDependencies() {
    inherited = CustomInherited.of(context);
    super.didChangeDependencies();
  }

  @override
  void reassemble() {
    init();
    super.reassemble();
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  @override
  void activate() {
    // TODO: implement activate
    super.activate();
  }

  @override
  void dispose() {
    textController.removeListener(textControllerListener);
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final myValue = inherited?.counterValue ?? 0;
    return TextField(controller: textController);
    // return isLoading
    //     ? const CircularProgressIndicator()
    //     : Text(
    //         myValue.toString(),
    //         style: Theme.of(context).textTheme.headline4,
    //       );
  }
}
