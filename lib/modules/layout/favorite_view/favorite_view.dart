import 'package:evently/core/l10n/app_localizations.dart';
import 'package:evently/core/widgets/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import '../../../core/routes/pages_route_name.dart';
import '../../../core/widgets/event_card_widget.dart';
import '../../../gen/assets.gen.dart';
import '../../../models/event_data_model.dart';
import '../../../utils/firestore_utils.dart';

class FavoriteView extends StatefulWidget {
  const FavoriteView({super.key});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  final TextEditingController _searchController = TextEditingController();
  String searchText = '';
  List<EventDataModel> data = [];
  DateTime? selectedEventDate;
  @override
  Widget build(BuildContext context) {
    var appLocal = AppLocalizations.of(context);

    return SafeArea(
      child: Column(
        spacing: 10,
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextFormFieldWidget(
              onPressed: search,
              onChanged: (value) {
                searchText = value;
                search();
              },
              hintText: appLocal!.searchForEvent,
              controller: _searchController,
              suffixIcon: Assets.icons.search.svg(width: 24, height: 24),
            ),
          ),
          Visibility(
            visible: searchText.isEmpty,
            replacement: Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) => EventCardWidget(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      PagesRouteName.eventDetails,
                      arguments: favoriteEventList[index],
                    );
                  },
                  dataModel: favoriteEventList[index],
                ),
                itemCount: favoriteEventList.length,
                separatorBuilder: (context, index) => SizedBox(height: 16),
              ),
            ),
            child: StreamBuilder(
              stream: FirestoreUtils.getStreamFavoriteDataFromFirestore(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                data = snapshot.data!.docs.map((e) {
                  return e.data();
                }).toList();
                return Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => EventCardWidget(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          PagesRouteName.eventDetails,
                          arguments: data[index],
                        );
                      },
                      dataModel: data[index],
                    ),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<EventDataModel> favoriteEventList = [];
  void search() {
    favoriteEventList.clear();
    for (var event in data) {
      if (event.eventDescription.toLowerCase().contains(
        searchText.toLowerCase(),
      )) {
        favoriteEventList.add(event);
      }
    }
    setState(() {});
  }
}
