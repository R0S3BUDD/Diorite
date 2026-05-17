import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// Message shown when a character is successfully saved
  ///
  /// In en, this message translates to:
  /// **'Card saved!'**
  String get cardSaved;

  /// Message shown when a character is deleted by the user
  ///
  /// In en, this message translates to:
  /// **'Card deleted'**
  String get cardDeleted;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'Oops... Something went wrong.'**
  String get genericError;

  /// Message shown when character creation or editing is cancelled
  ///
  /// In en, this message translates to:
  /// **'Character not saved'**
  String get operationCancelled;

  /// Error shown when an image fails to load
  ///
  /// In en, this message translates to:
  /// **'Error loading image'**
  String get imageLoadingError;

  /// Text for adding an image to the character
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get addPhoto;

  /// Character name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get defaultInfoName;

  /// Character age field
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get defaultInfoAge;

  /// Character nationality field
  ///
  /// In en, this message translates to:
  /// **'Nationality'**
  String get defaultInfoNationality;

  /// Character personality field
  ///
  /// In en, this message translates to:
  /// **'Personality'**
  String get defaultInfoPersonality;

  /// Character backstory or lore field
  ///
  /// In en, this message translates to:
  /// **'Backstory'**
  String get defaultInfoLore;

  /// Text showing the character's current age
  ///
  /// In en, this message translates to:
  /// **'Age: {age}'**
  String characterAge(int age);

  /// Button to retry a failed operation
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Message shown while characters are loading
  ///
  /// In en, this message translates to:
  /// **'Loading your cards'**
  String get homeLoadingCards;

  /// Message shown when an error occurs loading characters
  ///
  /// In en, this message translates to:
  /// **'Error loading cards'**
  String get homeCardsLoadingError;

  /// Message shown when there are no saved characters
  ///
  /// In en, this message translates to:
  /// **'No characters'**
  String get homeNoCharacters;

  /// Message shown on an empty list to guide the user to create a character
  ///
  /// In en, this message translates to:
  /// **'Press the + button to add a character'**
  String get homeTapToAddCharacter;

  /// Screen title for editing an existing character
  ///
  /// In en, this message translates to:
  /// **'Edit character'**
  String get newCardEditingTitle;

  /// Screen title for creating a character
  ///
  /// In en, this message translates to:
  /// **'Create character'**
  String get newCardCreatingTitle;

  /// Button to save changes to an existing character
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get newCardSaveChanges;

  /// Button to save a new character
  ///
  /// In en, this message translates to:
  /// **'Save character'**
  String get newCardSaveCharacter;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
