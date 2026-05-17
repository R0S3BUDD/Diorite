// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get cardSaved => 'Card saved!';

  @override
  String get cardDeleted => 'Card deleted';

  @override
  String get genericError => 'Oops... Something went wrong.';

  @override
  String get operationCancelled => 'Character not saved';

  @override
  String get imageLoadingError => 'Error loading image';

  @override
  String get addPhoto => 'Add a photo';

  @override
  String get defaultInfoName => 'Name';

  @override
  String get defaultInfoAge => 'Age';

  @override
  String get defaultInfoNationality => 'Nationality';

  @override
  String get defaultInfoPersonality => 'Personality';

  @override
  String get defaultInfoLore => 'Backstory';

  @override
  String characterAge(int age) {
    return 'Age: $age';
  }

  @override
  String get retry => 'Retry';

  @override
  String get homeLoadingCards => 'Loading your cards';

  @override
  String get homeCardsLoadingError => 'Error loading cards';

  @override
  String get homeNoCharacters => 'No characters';

  @override
  String get homeTapToAddCharacter => 'Press the + button to add a character';

  @override
  String get newCardEditingTitle => 'Edit character';

  @override
  String get newCardCreatingTitle => 'Create character';

  @override
  String get newCardSaveChanges => 'Save changes';

  @override
  String get newCardSaveCharacter => 'Save character';
}
