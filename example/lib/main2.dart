import 'package:flutter/material.dart';
import 'package:textfield_tags/textfield_tags.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late double _distanceToField;
  late TextfieldTagsController<String> _textfieldTagsController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _distanceToField = MediaQuery.of(context).size.width;
  }

  @override
  void dispose() {
    super.dispose();
    _textfieldTagsController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _textfieldTagsController = TextfieldTagsController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Welcome",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 74, 137, 92),
          centerTitle: true,
          title: const Text('Enter a tag...'),
        ),
        body: Column(
          children: [
            TextFieldTags<String>(
              textfieldTagsController: _textfieldTagsController,
              initialTags: const [
                'pick',
                'your',
                'favorite',
                'programming',
                'language'
              ],
              textSeparators: const [' ', ','],
              letterCase: LetterCase.normal,
              validator: (String tag) {
                if (tag == 'php') {
                  return 'No, please just no';
                } else if (_textfieldTagsController.getTags!.contains(tag)) {
                  return 'you already entered that';
                }
                return null;
              },
              inputFieldBuilder: (context, inputFieldValues) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    controller: inputFieldValues.textEditingController,
                    focusNode: inputFieldValues.focusNode,
                    decoration: InputDecoration(
                      isDense: true,
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92),
                          width: 3.0,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color.fromARGB(255, 74, 137, 92),
                          width: 3.0,
                        ),
                      ),
                      helperText: 'Enter language...',
                      helperStyle: const TextStyle(
                        color: Color.fromARGB(255, 74, 137, 92),
                      ),
                      hintText: inputFieldValues.tags.isNotEmpty
                          ? ''
                          : "Enter tag...",
                      errorText: inputFieldValues.error,
                      prefixIconConstraints:
                          BoxConstraints(maxWidth: _distanceToField * 0.85),
                      prefixIcon: inputFieldValues.tags.isNotEmpty
                          ? SingleChildScrollView(
                              controller: inputFieldValues.tagScrollController,
                              scrollDirection: Axis.vertical,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Wrap(
                                  runSpacing: 7.0,
                                  children:
                                      inputFieldValues.tags.map((String tag) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20.0),
                                        ),
                                        color: Color.fromARGB(255, 74, 137, 92),
                                      ),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5.0),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0, vertical: 5.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          InkWell(
                                            child: Text(
                                              '#$tag',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onTap: () {
                                              //print("$tag selected");
                                            },
                                          ),
                                          const SizedBox(width: 4.0),
                                          InkWell(
                                            child: const Icon(
                                              Icons.cancel,
                                              size: 14.0,
                                              color: Color.fromARGB(
                                                  255, 233, 233, 233),
                                            ),
                                            onTap: () {
                                              inputFieldValues.onTagDelete(tag);
                                            },
                                          )
                                        ],
                                      ),
                                    );
                                  }).toList()),
                            )
                          : null,
                    ),
                    onChanged: inputFieldValues.onChanged,
                    onSubmitted: inputFieldValues.onSubmitted,
                  ),
                );
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 74, 137, 92),
                ),
              ),
              onPressed: () {
                _textfieldTagsController.clearTags();
              },
              child: const Text('CLEAR TAGS'),
            ),
          ],
        ),
      ),
    );
  }
}