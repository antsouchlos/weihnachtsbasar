import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kLocaleStorageKey = '__locale_key__';

class FFLocalizations {
  FFLocalizations(this.locale);

  final Locale locale;

  static FFLocalizations of(BuildContext context) =>
      Localizations.of<FFLocalizations>(context, FFLocalizations)!;

  static List<String> languages() => ['de', 'el'];

  static late SharedPreferences _prefs;
  static Future initialize() async =>
      _prefs = await SharedPreferences.getInstance();
  static Future storeLocale(String locale) =>
      _prefs.setString(_kLocaleStorageKey, locale);
  static Locale? getStoredLocale() {
    final locale = _prefs.getString(_kLocaleStorageKey);
    return locale != null && locale.isNotEmpty ? createLocale(locale) : null;
  }

  String get languageCode => locale.toString();
  String? get languageShortCode =>
      _languagesWithShortCode.contains(locale.toString())
          ? '${locale.toString()}_short'
          : null;
  int get languageIndex => languages().contains(languageCode)
      ? languages().indexOf(languageCode)
      : 0;

  String getText(String key) =>
      (kTranslationsMap[key] ?? {})[locale.toString()] ?? '';

  String getVariableText({
    String? deText = '',
    String? elText = '',
  }) =>
      [deText, elText][languageIndex] ?? '';

  static const Set<String> _languagesWithShortCode = {
    'ar',
    'az',
    'ca',
    'cs',
    'da',
    'de',
    'dv',
    'en',
    'es',
    'et',
    'fi',
    'fr',
    'gr',
    'he',
    'hi',
    'hu',
    'it',
    'km',
    'ku',
    'mn',
    'ms',
    'no',
    'pt',
    'ro',
    'ru',
    'rw',
    'sv',
    'th',
    'uk',
    'vi',
  };
}

class FFLocalizationsDelegate extends LocalizationsDelegate<FFLocalizations> {
  const FFLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    final language = locale.toString();
    return FFLocalizations.languages().contains(
      language.endsWith('_')
          ? language.substring(0, language.length - 1)
          : language,
    );
  }

  @override
  Future<FFLocalizations> load(Locale locale) =>
      SynchronousFuture<FFLocalizations>(FFLocalizations(locale));

  @override
  bool shouldReload(FFLocalizationsDelegate old) => false;
}

Locale createLocale(String language) => language.contains('_')
    ? Locale.fromSubtags(
        languageCode: language.split('_').first,
        scriptCode: language.split('_').last,
      )
    : Locale(language);

final kTranslationsMap = <Map<String, Map<String, String>>>[
  // HomePage
  {
    'g7ulganq': {
      'de': 'Deutsch',
      'el': 'Deutsch',
    },
    '99194fzg': {
      'de': 'Ελληνικά',
      'el': 'Ελληνικά',
    },
    'm78as9qk': {
      'de': 'Deutsch',
      'el': '',
    },
    'r9rlwmpr': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'apmghflv': {
      'de':
          'am Samstag, den 2.12.2023\nin den Räumen der DSA – Deutschen Schule Athen\n\nFür das Gelingen unseres Basars freuen wir uns über jede Mithilfe! Wählen Sie Ihren Stand und Ihre Schicht aus und melden Sie sich an!\n\nWir melden uns dann bei Ihnen! Vielen Dank!',
      'el':
          'το Σάββατο 2/12/2023\nστους χώρους της ΓΣΑ - Γερμανικής Σχολής Αθηνών\n\nΧαιρόμαστε για κάθε βοήθεια για την επιτυχία του παζαριού μας! Επιλέξτε το περίπτερο και τη βάρδια σας και δηλώστε συμμετοχή!\n\nΣτη συνέχεια θα επικοινωνήσουμε μαζί σας! Σας ευχαριστούμε πολύ!',
    },
    'owosr0y7': {
      'de': 'Freitag, 1.12',
      'el': 'Παρασκευή, 1.12',
    },
    'sd9g4s1y': {
      'de': '16:30 - 19:30',
      'el': '16:30 - 19:30',
    },
    '7tizqs0a': {
      'de': 'Aufbau',
      'el': 'Εγκατάσταση',
    },
    '4a31zyop': {
      'de': 'Samstag, 2.12',
      'el': 'Σάββατο, 2.12',
    },
    'anr6fipy': {
      'de': '08:00 - 10:00',
      'el': '08:00 - 10:00',
    },
    '9vxnwty8': {
      'de': 'Aufbau',
      'el': 'Εγκατάσταση',
    },
    'po8enmi0': {
      'de': '10:00 - 19:00',
      'el': '10:00 - 19:00',
    },
    'sjrsn6dw': {
      'de': 'Basar',
      'el': 'Παζάρι',
    },
    'chlressg': {
      'de': '19:00 - 21:00',
      'el': '19:00 - 21:00',
    },
    'nh33btgd': {
      'de': 'Abbau',
      'el': 'Καθάρισμα',
    },
    'wxp0hk0b': {
      'de': 'Weiter zur Anmeldung',
      'el': 'Συνέχεια στην εγγραφή',
    },
    'okbr1ofr': {
      'de': 'Log in',
      'el': 'Log in',
    },
    'ct3bjngc': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    '4wxylc10': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // Registration
  {
    'wfmh6qda': {
      'de': 'Anmeldung',
      'el': 'Εγγραφή',
    },
    'cppf38cf': {
      'de': 'Name',
      'el': 'Όνομα',
    },
    'f3fy446j': {
      'de': 'Label here...',
      'el': '',
    },
    'xacoi8z5': {
      'de': 'E-Mail',
      'el': 'E-Mail',
    },
    'hcuaa80p': {
      'de': 'Telefonnummer',
      'el': 'Τηλέφωνο',
    },
    'p9yimtpu': {
      'de': 'Stand:',
      'el': 'Πάγκος ',
    },
    'hrfsj93x': {
      'de': '',
      'el': '',
    },
    'kre8u85u': {
      'de': 'Search for an item...',
      'el': '',
    },
    'ynko1xaq': {
      'de': 'Zeitraum:',
      'el': 'Ώρα:',
    },
    'niv0okrx': {
      'de': 'Freitag 16:30-19:30: Aufbau',
      'el': 'Παρασκευή 16:30-19:30: Εγκατάσταση',
    },
    'b6e2k6c2': {
      'de': 'Samstag 08:00 - 10:00: Aufbau',
      'el': 'Σάββατο 08:00 - 10:00: Εγκατάσταση',
    },
    'whec0b3p': {
      'de': 'Samstag 10:00 - 13:00: Aufbau',
      'el': 'Σάββατο 10:00 - 13:00: Εγκατάσταση',
    },
    'ns3hbl0w': {
      'de': 'Samstag 13:00 - 16:00: Basar',
      'el': 'Σάββατο 13:00 - 16:00: Παζάρι',
    },
    '8td2cmc4': {
      'de': 'Samstag 16:00 - 19:00: Basar',
      'el': 'Σάββατο 16:00 - 19:00: Παζάρι',
    },
    'dzqycfmz': {
      'de': 'Samstag 19:00 - 21:00: Abbau',
      'el': 'Σάββατο 19:00 - 21:00: Καθάρισμα',
    },
    'yeqaj2iy': {
      'de': 'Search for an item...',
      'el': '',
    },
    '80mfaiho': {
      'de': 'Anmelden',
      'el': 'Εγγραφή',
    },
    'cymx9cck': {
      'de': 'Field is required',
      'el': '',
    },
    '79l2j75j': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    '99niuziz': {
      'de': 'Field is required',
      'el': '',
    },
    'ogmrh17a': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    's4g8lots': {
      'de': 'Field is required',
      'el': '',
    },
    'cm154zd0': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'rihisduh': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'qtsym7xh': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // Thankyouforregistering
  {
    'm14vbi9m': {
      'de': 'Vielen Dank für Ihre Bereitschaft, mitzuhelfen!',
      'el': 'Σας ευχαριστούμε για την εγγραφή σας!',
    },
    'wbrhec20': {
      'de':
          'Sie werden in den nächsten Tagen vom Standverantwortlichen kontaktiert.\n\nSollten Sie Ihre Anmeldung zurückziehen wollen, dann sprechen Sie das bitte mit dem Standverantwortlichen ab.',
      'el':
          'Ο υπεύθυνος του πάγκου θα επικοινωνήσει μαζί σας τις επόμενες ημέρες.\n\nΕάν επιθυμείτε να αποσύρετε την εγγραφή σας, παρακαλούμε να ενημερώσετε τον υπεύθυνο.',
    },
    'vb43gegd': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'eyvcsvp8': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // Registrationfailed
  {
    'lcejympj': {
      'de': 'Anmeldung fehlgeschlagen!',
      'el': 'Η εγγραφή απέτυχε!',
    },
    'qkt23lob': {
      'de': 'Bitte versuchen Sie es zu einem späteren Zeitpunkt erneut.',
      'el': 'Παρακαλούμε προσπαθήστε ξανά αργότερα.',
    },
    '4qfdgjw1': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'uk5gw56w': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // LogIn
  {
    '6wjeje1b': {
      'de': 'Anmeldung für Standverantwortliche',
      'el': 'Σύνδεση για υπεύθυνους',
    },
    'b08e8pzu': {
      'de': 'Username',
      'el': 'Username',
    },
    'yxh9xf6w': {
      'de': 'Password',
      'el': 'Password',
    },
    'q79eoyym': {
      'de': 'Anmelden',
      'el': 'Σύνδεση',
    },
    '0ajsp9sc': {
      'de': 'Field is required',
      'el': '',
    },
    'e9vv2oyw': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'fnwg5uqz': {
      'de': 'Field is required',
      'el': '',
    },
    'xngm36xc': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'f45lrdnq': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'wbjgcdct': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // RegisteredList
  {
    'jjhi72sy': {
      'de': 'Übersicht',
      'el': 'Σύνοψη',
    },
    '5lql6w6o': {
      'de': 'Als Excel herunterladen',
      'el': 'Λήψη ως Excel',
    },
    'r5ch4jyg': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'xzm91rv9': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // AdminPage
  {
    '1wcu26mr': {
      'de': 'Stands',
      'el': 'Stands',
    },
    'qmki8b2q': {
      'de': 'Stand name DE',
      'el': 'Stand name DE',
    },
    'hi7i7euc': {
      'de': 'Stand name GR',
      'el': 'Stand name GR',
    },
    '7ua3kj9e': {
      'de': 'Users',
      'el': 'Users',
    },
    'kx40ykd5': {
      'de': 'Stand',
      'el': '',
    },
    'c5zh8m6t': {
      'de': 'Name',
      'el': '',
    },
    'gd93p3te': {
      'de': 'Email',
      'el': '',
    },
    '9kahqugq': {
      'de': 'Phone',
      'el': '',
    },
    'ux4tcchw': {
      'de': 'Name',
      'el': '',
    },
    'itpzx6ip': {
      'de': 'Email',
      'el': 'Email',
    },
    '7iessj1z': {
      'de': 'Phone',
      'el': 'Phone',
    },
    '9at5jy8y': {
      'de': 'Password',
      'el': 'Password',
    },
    'b1n8g80v': {
      'de': 'Option 1',
      'el': '',
    },
    'y10r2661': {
      'de': 'Search for an item...',
      'el': '',
    },
    'v57fpinr': {
      'de': 'Field is required',
      'el': '',
    },
    '5geh6e4v': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'ieivauvc': {
      'de': 'Field is required',
      'el': '',
    },
    'qkq1nyyi': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'ian8ggsx': {
      'de': 'Field is required',
      'el': '',
    },
    'vfzc7fw6': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'en1eqln8': {
      'de': 'Field is required',
      'el': '',
    },
    'z5y4z57e': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    '4h0wfoe6': {
      'de': 'Shifts',
      'el': 'Shifts',
    },
    'nb0jt2ed': {
      'de': 'Text DE',
      'el': 'Text DE',
    },
    'v7of0ds5': {
      'de': 'Text GR',
      'el': 'Text GR',
    },
    'de94tqxz': {
      'de': 'Registrations',
      'el': 'Registrations',
    },
    'qb6lanw3': {
      'de': 'Download as Excel',
      'el': '',
    },
    'bzhamcvv': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
    'jmmt5z4o': {
      'de': 'Home',
      'el': '',
    },
  },
  // StandCardShift
  {
    'ddmyfj1h': {
      'de': 'Freitag 16:30-19:30: Aufbau',
      'el': 'Παρασκευή 16:30-19:30: Εγκατάσταση',
    },
  },
  // Footer
  {
    'qll42bzk': {
      'de': 'weihnachtsbasar.athen@gmail.com',
      'el': 'weihnachtsbasar.athen@gmail.com',
    },
    'l83f5r22': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι',
    },
  },
  // FooterLoggedIn
  {
    '8v0ftksh': {
      'de': 'weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'nwf84z7d': {
      'de': 'Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
  },
  // AdminStandCard
  {
    'g3femt44': {
      'de': 'User: ',
      'el': '',
    },
  },
  // Miscellaneous
  {
    'miyfhtq9': {
      'de': '',
      'el': '',
    },
    'k0a684ew': {
      'de': '',
      'el': '',
    },
    '1571j58k': {
      'de': '',
      'el': '',
    },
    'o3sqlqzt': {
      'de': '',
      'el': '',
    },
    'kiteu6j4': {
      'de': '',
      'el': '',
    },
    'lo279e0z': {
      'de': '',
      'el': '',
    },
    '5f79ceah': {
      'de': '',
      'el': '',
    },
    'khd9e5vc': {
      'de': '',
      'el': '',
    },
    'unx5t7sx': {
      'de': '',
      'el': '',
    },
    'lew38dk6': {
      'de': '',
      'el': '',
    },
    'j9cy9qmf': {
      'de': '',
      'el': '',
    },
    '7x0k7jus': {
      'de': '',
      'el': '',
    },
    'gryzhr9g': {
      'de': '',
      'el': '',
    },
    '21nw0drx': {
      'de': '',
      'el': '',
    },
    'phcwjw6a': {
      'de': '',
      'el': '',
    },
    'upbgbqja': {
      'de': '',
      'el': '',
    },
    'em8czbwh': {
      'de': '',
      'el': '',
    },
    '9b3yq1j6': {
      'de': '',
      'el': '',
    },
    '57pq0k1o': {
      'de': '',
      'el': '',
    },
    'hc1z3qia': {
      'de': '',
      'el': '',
    },
    'jdallf2m': {
      'de': '',
      'el': '',
    },
    'jfjkw4qm': {
      'de': '',
      'el': '',
    },
    'jev9jsmx': {
      'de': '',
      'el': '',
    },
  },
].reduce((a, b) => a..addAll(b));
