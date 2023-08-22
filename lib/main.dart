import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';


/*
 *
 * Main function and app
 *
 */


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  final String title = 'Weihnachtsbasar';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: title),
      //home: StandOverviewPage(title: title),
      //home: RegistrationPage(title: title)
    );
  }
}


/*
 *
 * Helper functions and classes
 *
 */


/**
 * @brief Custom pair class allowing to easily store the data of the
 * registration entries on the home page
 */
class RegistrationEntryPair<T1, T2> {
  final T1 title;
  final T2 description;

  const RegistrationEntryPair(this.title, this.description);
}

/**
 * @brief Class describing a widget that can be used to access the registration
 * page
 */
class RegistrationEntry extends StatelessWidget {
  const RegistrationEntry({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: 400,
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ),
              ),
              SizedBox(height: 10),
              SizedBox(
                width: 400,
                child: Center(
                  child: Text(
                    description,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                )
              )
            ]
          ),
          SizedBox(width: 20),
          ElevatedButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StandOverviewPage(title: title)),
              );
            },
            child: const Text('Zur Anmeldung'),
          ),
        ]
      )
    );
  }
}

/**
 * @brief Card displaying the name of a stand with some basic info and a button
 * for moving to the registration page
 */
class StandRegCard extends StatelessWidget {
  final String title;
  final String description;

  StandRegCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text (
              title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Container(
              constraints: BoxConstraints(minWidth: 100, maxWidth: 500),
              child: Text(
                description,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegistrationPage(title: title)),
                );
              },
              child: Text('Zur Anmeldung')
            ),
          ]
        ),
      ),
    );
  }
}

// TODO: Move this to some proper place
const List<String> shiftList = <String>['Vormittags', 'Nachmittags', 'Abends'];

/**
 * @brief Drop down button allowing the seleciton of a shift
*/
class ShiftDropdownButton extends StatefulWidget{
  const ShiftDropdownButton({super.key});

  @override
  State<ShiftDropdownButton> createState() => _ShiftDropdownButtonState();
}

/**
* @brief State allowing for the selection of different values 
*/
class _ShiftDropdownButtonState extends State<ShiftDropdownButton> {
  String dropdownValue = shiftList.first;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: shiftList.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


/*
 *
 * Pages
 *
 */


/**
 * @brief Home page
 */
class MyHomePage extends StatelessWidget {
  final String title;

  final _entryList = [
    RegistrationEntryPair('Freitag, 4.09', 'Aufbau von ständen und sortieren von Material'),
    RegistrationEntryPair('Samstag, 5.09', 'Verkauf von Ware und Betreuung von Ständen'),
    RegistrationEntryPair('Sonntag, 6.09', 'Abbau von Ständen und Aufräumen von Restware'),
  ];


  MyHomePage({super.key, required this.title});

  _constructWidgetList() {
    var widgetList = <Widget>[];

    for (final entry in _entryList) {
        widgetList.add(RegistrationEntry(title: entry.title, description: entry.description));
        widgetList.add(SizedBox(height: 30));
    }

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: _constructWidgetList()
        ),
      ),
    );
  }
}

/**
 * @brief Stand overview page
 */
class StandOverviewPage extends StatelessWidget {
  final String title;

  final standCardList = [
    StandRegCard(title: 'Limonadenverkauf',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'Adventskranz',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'XYZ',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'ABC',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'DEF',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'GHI',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'JKL',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'MNO',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
    StandRegCard(title: 'PQR',
                 description: 'Lorem ipsum dolor sit amet, consectetur'
                              'adipiscing elit. Nulla augue nisi, imperdiet'
                              'et lorem sed, accumsan fermentum ipsum.'),
  ];

  StandOverviewPage({required this.title});

  _wrapCardForListView(StandRegCard card) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        card,
      ],
    );
  }

  _constructCardList() {
    var cardList = <Widget>[];

    for (final card in standCardList) {
      cardList.add(_wrapCardForListView(card));
    }

    return cardList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: ListView(
          children: _constructCardList()
        ),
      ),
    );
  }
}

/**
 * @brief Registration page
 */
class RegistrationPage extends StatelessWidget {
  final String title;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController controller = TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'DE');

  RegistrationPage({required this.title});

  String? _validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
  
    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 350,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                child: TextFormField(
                  validator: _validateEmail,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'E-Mail Addresse',
                  ),
                ),
              )
            ),
            SizedBox(height: 10),
            SizedBox(
              width: 350,
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {},
                selectorConfig: SelectorConfig(
                  selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                ),
                ignoreBlank: true,
                autoValidateMode: AutovalidateMode.always,
                selectorTextStyle: TextStyle(color: Colors.black),
                initialValue: number,
                textFieldController: controller,
                keyboardType:
                    TextInputType.numberWithOptions(signed: true, decimal: true),
                inputBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            SizedBox(
              width: 350,
              child: ShiftDropdownButton()
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: (){},
              child: Text('Anmelden'),
            ),
          ]
        )
      )
    );
  }
}
