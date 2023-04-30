import '../shared/styles/images.dart';

//Special Offer class
class SpecialOffer{
  String title, offer, image;

  SpecialOffer({required this.title, required this.offer, required this.image});

  static List<SpecialOffer> offers(){
    List<SpecialOffer> data = [];
    data.add(SpecialOffer(title: 'Special Offers 1', offer: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard.', image: FoodImages.emptyNutrition));
    data.add(SpecialOffer(title: 'Special Offers 2', offer: 'dummy text of the printing and typesetting industry. Lorem Ipsum is simply Lorem Ipsum has been the industry\'s standard.', image: GymImages.runBg));
    data.add(SpecialOffer(title: 'Special Offers 3', offer: 'typesetting industry.Lorem Ipsum is simply dummy text of the printing and  Lorem Ipsum has been the industry\'s standard.', image: MainImages.yoga));
    return data;
  }
}

Map<String, List<String>> premiumPlansContent = {
  "Silver" : ["Silver Plan", "30.00", "3"],
  "Gold" : ["Gold Plan", "50.00", "5"],
};