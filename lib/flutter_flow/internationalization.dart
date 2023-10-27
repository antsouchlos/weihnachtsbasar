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
          'Es ist soweit! Für den Weihnachtsbasar der DSA sind wieder Helfer gesucht!\nAuch dieses Jahr gibt es wieder zahlreiche Stände die sich um Essen, Trinken,\nBasteln, Warenverkauf und vieles mehr kümmern!\n\nInteresse zu helfen? Dann melde dich jetzt unter dem folgenden Link an!',
      'el':
          'Ήρθε πάλι η ώρα! Χρειάζονται και πάλι βοηθοί για το χριστουγεννιάτικο\nπαζάρι της ΓΣΑ! Και φέτος θα υπάρχουν πολυάριθμοι πάγκοι που θα\nπωλούν φαγητά, ποτά, χειροτεχνήματα, αγαθά και πολλά άλλα!\n\nΕνδιαφέρεστε να βοηθήσετε; Τότε εγγραφείτε τώρα στην παρακάτω\nιστοσελίδα!',
    },
    'owosr0y7': {
      'de': 'Freitag, den 1.12     ',
      'el': 'Παρασκευή 1.12',
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
      'de': 'Samstag, den 2.12',
      'el': 'Σάββατο 2.12',
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
    'szuto2mt': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'kc9yvg6c': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    '57xyj3cp': {
      'de': 'Log In',
      'el': 'Σύνδεση',
    },
    'y1v5lz10': {
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
    '5c7pbjau': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    '5135oy1a': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'v4wygopm': {
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
          'Sie werden in den nächsten Tagen vom Standverantwortlichen kontaktiert.\n\nSollten Sie Ihre Anmeldung zurückziehen wollen, dann sprechen Sie das\nbitte mit dem Standverantwortlichen ab.',
      'el':
          'Ο υπεύθυνος του πάγκου θα επικοινωνήσει μαζί σας τις επόμενες ημέρες.\n\nΕάν επιθυμείτε να αποσύρετε την εγγραφή σας, παρακαλούμε να ενημερώσετε\nτον υπεύθυνο του πάγκου.',
    },
    'wfysgvja': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'o6bnk7nw': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'wjepdtpv': {
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
      'de': 'Bitte versuchen Sie es zu einem  späteren Zeitpunkt erneut.',
      'el': 'Παρακαλούμε προσπαθήστε ξανά αργότερα.',
    },
    'mbo5fcvr': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'g88nswud': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    '577br9z6': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    'uk5gw56w': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // RegistrationFancy
  {
    'kjlemzx9': {
      'de': 'Auswahl des Standes:',
      'el': '',
    },
    'pjq94one': {
      'de': 'Adventskränze',
      'el': '',
    },
    't70ky1tl': {
      'de': 'Verkauf von Adventskränzen',
      'el': '',
    },
    'ipt7q346': {
      'de': 'Kinderbasteln',
      'el': '',
    },
    'akq0yoge': {
      'de': 'Basteln von Lebkuchenhäusern mit Kindern',
      'el': '',
    },
    '3b8gxb9s': {
      'de': 'Deutsche Spezialitäten',
      'el': '',
    },
    '6soobrc4': {
      'de': 'Verkauf von typisch deutschem Essen',
      'el': '',
    },
    '9x4zx8re': {
      'de': 'Name',
      'el': '',
    },
    'f84hydz3': {
      'de': 'E-Mail',
      'el': '',
    },
    'z2zpde52': {
      'de': 'Telefonnummer',
      'el': '',
    },
    'zispwfjs': {
      'de': 'Zeitraum:',
      'el': '',
    },
    '2l4njseg': {
      'de': 'Freitag 16:30-19:30: Aufbau',
      'el': '',
    },
    'hz3iqdjh': {
      'de': 'Freitag 16:30-19:30: Aufbau',
      'el': '',
    },
    'qn7swleb': {
      'de': 'Samstag 08:00 - 10:00: Aufbau',
      'el': '',
    },
    'a5wtnec3': {
      'de': 'Samstag 10:00 - 13:00: Aufbau',
      'el': '',
    },
    '3kch3yj6': {
      'de': 'Samstag 13:00 - 16:00: Basar',
      'el': '',
    },
    'l2jq96oy': {
      'de': 'Samstag 16:00 - 19:00: Basar',
      'el': '',
    },
    'cfzal0lf': {
      'de': 'Samstag 19:00 - 21:00: Abbau',
      'el': '',
    },
    'szv2xdmr': {
      'de': 'Please select...',
      'el': '',
    },
    'xb7th9ih': {
      'de': 'Search for an item...',
      'el': '',
    },
    'uehx5dx2': {
      'de': 'Anmelden',
      'el': '',
    },
    '96l49whi': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    'qxecqeqf': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'nl55bmcg': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    '8ejrs0d8': {
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
    '33pi4xkn': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    '0pyqczx3': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'chbyr2tu': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    'wbjgcdct': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
    },
  },
  // RegisteredListTemplate
  {
    'e7smhw7q': {
      'de': 'Manage your team below.',
      'el': '',
    },
    '1nb5qm0f': {
      'de': 'Random Name',
      'el': '',
    },
    '8hxykyzr': {
      'de': 'user@randomname.com',
      'el': '',
    },
    '5ectvzyp': {
      'de': 'Random Name',
      'el': '',
    },
    'fk7vjejm': {
      'de': 'user@randomname.com',
      'el': '',
    },
    'hkl2h6jq': {
      'de': 'Random Name',
      'el': '',
    },
    '44cffc30': {
      'de': 'user@randomname.com',
      'el': '',
    },
    '71cojig1': {
      'de': 'Random Name',
      'el': '',
    },
    '09qzlqt2': {
      'de': 'user@randomname.com',
      'el': '',
    },
    'pb0lstf2': {
      'de': 'Random Name',
      'el': '',
    },
    'f8bq6kcg': {
      'de': 'user@randomname.com',
      'el': '',
    },
    'bn9s9cnf': {
      'de': 'My Team',
      'el': '',
    },
    'y9wqlc4s': {
      'de': 'Home',
      'el': '',
    },
  },
  // RegisteredList
  {
    'r9h2p79o': {
      'de': 'Kontakt: weihnachtsbasar.athen@gmail.com',
      'el': 'Επικοινωνία: weihnachtsbasar.athen@gmail.com',
    },
    '7qlg6pgl': {
      'de': 'Weihnachtsbasar 2023',
      'el': 'Χριστουγεννιάτικο παζάρι 2023',
    },
    'zvzspvsq': {
      'de': 'DSA Weihnachtsbasar',
      'el': 'Χριστουγεννιάτικο παζάρι της ΓΣΑ',
    },
    'xzm91rv9': {
      'de': 'Home',
      'el': 'Αρχική σελίδα',
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
