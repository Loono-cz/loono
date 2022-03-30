part of '../test_cases/points/loon_464_view_points_and_leaderboard.dart';

// ignore: non_constant_identifier_names
final _testDataLeaderboard = createLeaderboardObject(
  top: [
    createLeaderboardUserObject(name: 'Martin', points: 2650, isThisMe: false),
    createLeaderboardUserObject(name: 'Petr', points: 1000, isThisMe: false),
    createLeaderboardUserObject(name: 'Matěj', points: 750, isThisMe: false),
  ],
  peers: [
    createLeaderboardUserObject(
      name: defaultMaleAccount.nickname,
      points: defaultMaleAccount.points,
      isThisMe: true,
    ),
    createLeaderboardUserObject(name: 'Daniel', points: 100, isThisMe: false),
    createLeaderboardUserObject(name: 'Ema', points: 50, isThisMe: false),
  ],
  myOrder: 22,
);
