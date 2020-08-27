class Constants {
  static const appVersion = '0.0.5';

  static const googleAPIKey = 'AIzaSyAviivTDt0XzleVXCCrY3TDqeHZkaEjB4U';

  static const splashAnimationDuration = Duration(milliseconds: 2700);

  static const services = {
    'Luxe': 'Luxe',
    'Standard': 'Standard',
    'Economique': 'Economique',
  };

  static const List<String> typedelieu = [
    '',
    'Immeuble',
    'Maison',
    'Garde-meubles',
    'Entrepôt',
    'Magasin',
  ];

  static const List<String> typedeacces = [
    '',
    'Plein pieds',
    'Ascenseur',
    'Escaliers',
  ];

  static const List<String> etages = [
    '',
    'RDC',
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
  ];
}

enum DocStatus {
  NONE,
  PENDING,
  CONFIRMED,
}

enum DocType {
  INSURANCE,
  TRANSPORT,
  KBIS,
  IDENTITY,
  BANK,
}
