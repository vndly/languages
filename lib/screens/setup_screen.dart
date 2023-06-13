import 'package:dafluta/dafluta.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:languages/api/get_categories.dart';
import 'package:languages/dialogs/dialogs.dart';
import 'package:languages/json/json_profile.dart';
import 'package:languages/models/language.dart';
import 'package:languages/screens/splash_screen.dart';
import 'package:languages/storage/categories_storage.dart';
import 'package:languages/storage/profile_storage.dart';

class SetupScreen extends StatelessWidget {
  const SetupScreen();

  static PageRouteBuilder<SetupScreen> instance() =>
      FadeRoute<SetupScreen>(const SetupScreen());

  @override
  Widget build(BuildContext context) {
    return const LightStatusBar(
      child: Scaffold(
        body: SafeArea(
          child: Content(),
        ),
      ),
    );
  }
}

class Content extends StatefulWidget {
  const Content();

  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {
  final List<Language> languages = [];
  final TextEditingController controller = TextEditingController();
  Language? origin;
  Language? target;
  String? url;

  @override
  void initState() {
    super.initState();
    Delayed.post(_init);
  }

  Future _init() async {
    final List<Language> list = await Language.availableLanguages();

    setState(() {
      languages.addAll(list);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const VBox(40),
            Text(
              'Setup'.toUpperCase(),
              style: const TextStyle(fontSize: 30),
            ),
            const VBox(40),
            DropdownSearch<Language>(
              //mode: Mode.MENU,
              selectedItem: origin,
              items: languages,
              //label: 'From',
              //hint: 'Select language',
              itemAsString: (l) => l.name,
              onChanged: _onFrom,
            ),
            const VBox(20),
            DropdownSearch<Language>(
              //mode: Mode.MENU,
              selectedItem: target,
              items: languages,
              //label: 'To',
              //hint: 'Select language',
              itemAsString: (l) => l.name,
              onChanged: _onTo,
            ),
            const VBox(20),
            TextField(
              controller: controller,
              keyboardType: TextInputType.url,
              decoration: InputDecoration(
                hintText: 'URL',
                labelText: 'URL',
                hintStyle: TextStyle(color: Colors.grey[600]),
                border: const OutlineInputBorder(),
              ),
              onChanged: (text) => setState(() {
                url = text;
              }),
            ),
            const VBox(20),
            ButtonTheme(
              height: 50,
              minWidth: double.infinity,
              child: ElevatedButton(
                onPressed: isFormValid ? _onFinish : null,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Finish'.toUpperCase(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool get isFormValid =>
      (origin != null) &&
      (target != null) &&
      (url != null) &&
      (url!.isNotEmpty);

  void _onFrom(Language? language) {
    setState(() {
      origin = language;

      if (target?.code == origin?.code) {
        target = null;
      }
    });
  }

  void _onTo(Language? language) {
    setState(() {
      target = language;

      if (origin?.code == target?.code) {
        origin = null;
      }
    });
  }

  Future _onFinish() async {
    final dialog =
        await Dialogs.showLoadingDialog(context, 'Downloading data...');

    final JsonProfile profile = JsonProfile(
      origin: origin!.code,
      target: target!.code,
      url: url!,
    );
    await ProfileStorage.save(profile);

    final result = await GetCategories()();

    Navigator.of(dialog).pop();

    if (result.success) {
      CategoriesStorage.save(result.data);
      Navigator.of(context).pushReplacement(SplashScreen.instance());
    } else {
      ProfileStorage.clear();
      Dialogs.showErrorDialog(context, 'Error downloading data');
    }
  }
}
