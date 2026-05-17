// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get cardSaved => '¡Carta guardada!';

  @override
  String get cardDeleted => 'Carta Borrada';

  @override
  String get genericError => 'Ups... Algo salió mal.';

  @override
  String get operationCancelled => 'Personaje no guardado';

  @override
  String get imageLoadingError => 'Error al cargar imagen';

  @override
  String get addPhoto => 'Añade una foto';

  @override
  String get defaultInfoName => 'Nombre';

  @override
  String get defaultInfoAge => 'Edad';

  @override
  String get defaultInfoNationality => 'Nacionalidad';

  @override
  String get defaultInfoPersonality => 'Personalidad';

  @override
  String get defaultInfoLore => 'Historia';

  @override
  String characterAge(int age) {
    return 'Edad: $age';
  }

  @override
  String get retry => 'Reintentar';

  @override
  String get homeLoadingCards => 'Cargando tus cartas';

  @override
  String get homeCardsLoadingError => 'Error al cargar las cartas';

  @override
  String get homeNoCharacters => 'No hay personajes';

  @override
  String get homeTapToAddCharacter =>
      'Presiona el botón + para añadir un personaje';

  @override
  String get newCardEditingTitle => 'Editar personaje';

  @override
  String get newCardCreatingTitle => 'Crear personaje';

  @override
  String get newCardSaveChanges => 'Guardar cambios';

  @override
  String get newCardSaveCharacter => 'Guardar personaje';
}
