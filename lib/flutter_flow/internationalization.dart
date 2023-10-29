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
    'r9rlwmpr': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    '5fy8e6jx': {
      'de':
          'Es ist soweit! Für den Weihnachtsbasar der DSA sind wieder Helfer gesucht! Auch dieses Jahr gibt es wieder zahlreiche Stände die sich um Essen, Trinken, Basteln, Warenverkauf und vieles mehr kümmern!\n\nInteresse zu helfen? Dann melde dich jetzt unter dem folgenden Link an!',
      'el':
          'Ήρθε πάλι η ώρα! Χρειάζονται και πάλι βοηθοί για το χριστουγεννιάτικο παζάρι της ΓΣΑ! Και φέτος θα υπάρχουν πολυάριθμοι πάγκοι που θα πωλούν φαγητά, ποτά, χειροτεχνήματα, αγαθά και πολλά άλλα!\n\nΕνδιαφέρεστε να βοηθήσετε; Τότε εγγραφείτε τώρα στην παρακάτω ιστοσελίδα!',
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
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
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
    '96cg34yl': {
      'de': 'Kerzen',
      'el': 'Κεριά',
    },
    '7m00vh5o': {
      'de': 'Kerzen',
      'el': 'Κεριά',
    },
    'kf9wamyt': {
      'de': 'CD-DVD',
      'el': 'CD-DVD',
    },
    'qzumisl2': {
      'de': 'Handarbeiten',
      'el': '',
    },
    'a3yk2f1j': {
      'de': 'Marmeladen',
      'el': 'Μαρμελάδες',
    },
    'hor0wyzf': {
      'de': 'Bücher',
      'el': 'Βιβλία',
    },
    '4glapv9u': {
      'de': 'Weihnachtsartikel',
      'el': '',
    },
    'kgj8c5jw': {
      'de': 'Adventskränze',
      'el': '',
    },
    '3kvbjdbr': {
      'de': 'Tannengrün',
      'el': '',
    },
    'a2lgef6r': {
      'de': 'Süßwaren',
      'el': 'Γλυκά',
    },
    'aqoc00in': {
      'de': 'Second-Hand Kleidung',
      'el': '',
    },
    'aovsqii3': {
      'de': 'Second-Hand Spielzeug',
      'el': '',
    },
    'x8gb2uoa': {
      'de': 'Delikatessen',
      'el': '',
    },
    '9hiexof8': {
      'de': 'Flohmarkt',
      'el': '',
    },
    'nv54q1al': {
      'de': 'Kaffee&amp;Kuchen',
      'el': '',
    },
    '2fmfgw7s': {
      'de': 'Kasse',
      'el': '',
    },
    'adz5znfi': {
      'de': 'Glühwein',
      'el': '',
    },
    '9r11s3v0': {
      'de': 'Kürbissuppe',
      'el': '',
    },
    'kg18o72x': {
      'de': 'Waffeln',
      'el': '',
    },
    'c34rm8eq': {
      'de': 'Deutsche Spezialitäten',
      'el': '',
    },
    'dmh6j2co': {
      'de': 'Brezeln',
      'el': '',
    },
    'b0ckzsw5': {
      'de': 'Limonade',
      'el': '',
    },
    'muncc8ke': {
      'de': 'Bier',
      'el': '',
    },
    '7fwrgy8e': {
      'de': 'Socken',
      'el': '',
    },
    'qa5hiwfv': {
      'de': 'SOS-Kinderdorf',
      'el': '',
    },
    'qgq1boak': {
      'de': 'Losverkauf',
      'el': '',
    },
    '0xlbcbke': {
      'de': 'Orangensaft u. Mandeln',
      'el': '',
    },
    '2jl3ms5t': {
      'de': 'Kunsthandwerk',
      'el': '',
    },
    'tzv19ckb': {
      'de': 'Kinderbasteln',
      'el': '',
    },
    'uknozt60': {
      'de': 'Please select...',
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
    '0waiphkf': {
      'de': 'Freitag 16:30-19:30: Aufbau',
      'el': 'Παρασκευή 16:30-19:30: Εγκατάσταση',
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
    'h33oyca5': {
      'de': 'Please select...',
      'el': '',
    },
    'yeqaj2iy': {
      'de': 'Search for an item...',
      'el': '',
    },
    '80mfaiho': {
      'de': 'Anmelden',
      'el': 'Εγγραφή',
    },
    '74k2a1ys': {
      'de': 'Field is required',
      'el': '',
    },
    'v0uwdtxi': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    '4w3kwoio': {
      'de': 'Field is required',
      'el': '',
    },
    'ehltt8c6': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'bso5ygus': {
      'de': 'Field is required',
      'el': '',
    },
    'x1upp3d7': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'rihisduh': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    'qtsym7xh': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // Thankyouforregistering
  {
    'm14vbi9m': {
      'de': 'Vielen Dank für Ihre Anmeldung!',
      'el': 'Σας ευχαριστούμε για την εγγραφή σας!',
    },
    'wbrhec20': {
      'de':
          'Sie werden in den nächsten Tagen vom Stand-verantwortlichen kontaktiert.\n\nSollten Sie Ihre Anmeldung zurückziehen wollen, dann sprechen Sie das bitte mit dem Standverantwortlichen ab.',
      'el':
          'Ο υπεύθυνος του πάγκου θα επικοινωνήσει μαζί σας τις επόμενες ημέρες.\n\nΕάν επιθυμείτε να αποσύρετε την εγγραφή σας, παρακαλούμε να ενημερώσετε τον υπεύθυνο.',
    },
    'vb43gegd': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
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
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
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
    '4np4ew3t': {
      'de': 'Field is required',
      'el': '',
    },
    'tdwbxwkn': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'k5znaf64': {
      'de': 'Field is required',
      'el': '',
    },
    '0j4xr68c': {
      'de': 'Please choose an option from the dropdown',
      'el': '',
    },
    'f45lrdnq': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
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
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    'xzm91rv9': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // StandCard
  {
    '9zqlime7': {
      'de': 'Standname',
      'el': 'Πάγκος',
    },
  },
  // StandCardEntry
  {
    'qpj5sxzr': {
      'de': 'Max Mustermann',
      'el': 'Max Mustermann',
    },
    'un2uw99e': {
      'de': 'max.mustermann@gmail.com',
      'el': 'max.mustermann@gmail.com',
    },
    '65tmle7n': {
      'de': '+49 000 00000000',
      'el': '+49 000 00000000',
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
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'l83f5r22': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
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
