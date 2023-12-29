class EndPoints {
  static const String baseUrl = 'http://ask.ak.toys/api/';
  static const String login = 'sanctum/login';
  static const String register = 'sanctum/register';
  static const String logOut = '/client/logout';
  static const String deleteAccount = '/client/delete';
  static const String profile = '/client/profile';
  static const String profileUpdate = '/client/update';
  static const String wallet = 'clients/wallet';
  static const String saveImage = '/client/saveImage';
  static const String allQuizzes = 'quizzes/all';
  static const String startGame = 'games/start';
  static const String replayGame = 'games/replay';
  static const String answerAQuestion = 'answers/question';
  static const String finishTheGame = 'games/finish';
  static const String allItems = 'items/all';
  static const String buyItems = 'items/buy';
  static const String featheredExams = 'quizzes/featured';
  static const String pastExams = 'games/finished';
  static const String pausedExams = 'games/paused';
  static const String payCoins = 'pay/coins';
  static const String recharge = 'balance/recharge';
  static const String withdraw = 'balance/withdraw';
  static const String exchangeCoins = '/coins/exchange';
  static const String startComparison = '/comparison/start';
  static const String allPuzzles = '/puzzles/all';
  static const String finshComparison = '/comparison/finish';

  static const String pausedPuzzel = '/comparison/paused';
  static const String featheredPuzzel = '/puzzles/featured';
  static const String replayPuzzel = '/comparison/replay';
}
