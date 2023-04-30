


import 'package:flutter/material.dart';

import 'navigation.dart';

Map<String, WidgetBuilder> routes = {
  "/": (_) => const Navigation(),
  // "/login": (_) => const Login(),
  // "/notification": (_) => const Notifications(),
  // "/PremiumPlans": (_) => const PremiumPlans(),
  // "/PaymentMethod": (_) => const PaymentMethod(),
  // "/recommendedNutrition": (_) => RecommendedProgramNutritionInfo(),
  // "/NutritionHome": (_) => const NutritionHome(),
  // "/infoDetails": (_) => const InformationDetails(),
  // "/exerciseDetails": (_) => const ExerciseDetails(),
  // "/foodSelection": (_) => ChooseFood(),
  // "/foodDetails": (_) => const FoodDetails(),
};
// Route<dynamic> generateRoutes(RouteSettings setting){
//   switch(setting?.name){
//     case "/navigation":
//       return HomeAnimation();
//     case "/notification":
//       return NotificationAnimation(page: const Notifications());
//     case "/":
//       return HomeAnimation();
//     case "/login":
//       return HomeAnimation();
//     case "/profile":
//       return HomeAnimation();
//     case "/PremiumPlans":
//       return PremiumAnimation();
//     case "/PaymentMethod":
//       return PremiumAnimation();
//     case "/gymBefore":
//       return HomeAnimation();
//     case "/gymAfter":
//       return HomeAnimation();
//     case "/NutritionBefore":
//       return HomeAnimation();
//     case "/NutritionHome":
//       return HomeAnimation();
//     case "/NutritionAfter":
//       return HomeAnimation();
//     default:
//       return MaterialPageRoute(builder: (context) => const Login());
//   }
// }