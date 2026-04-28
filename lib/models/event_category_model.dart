import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/gen/assets.gen.dart';

class EventCategoryModel {
  final String id;
  final String name;
  final String lightImage;
  final String darkImage;
  final SvgGenImage icon;
  EventCategoryModel({
    required this.id,
    required this.name,
    required this.lightImage,
    required this.darkImage,
    required this.icon,
  });
static List<EventCategoryModel> getCategories(AppLocalizations appLocal){
  return[
    EventCategoryModel(
      id: 'sport',
      name: appLocal.sport,
      lightImage: Assets.images.sportLight.path,
      darkImage: Assets.images.sportDark.path,
      icon: Assets.icons.sportLight,
    ),
    EventCategoryModel(
      id: 'birthday',
      name: appLocal.birthday,
      lightImage: Assets.images.birthdayLight.path,
      darkImage: Assets.images.birthdayDark.path,
      icon: Assets.icons.birthdayCakeLight,
    ),
    EventCategoryModel(
      id: 'book_club',
      name: appLocal.bookClub,
      lightImage: Assets.images.bookclubLight.path,
      darkImage: Assets.images.bookclubDark.path,
      icon: Assets.icons.bookLight,
    ),
  ];
}
}
