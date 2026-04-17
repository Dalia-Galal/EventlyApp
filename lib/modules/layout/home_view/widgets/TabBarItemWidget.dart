import 'package:evently/models/event_category_model.dart';
import 'package:evently/core/providers/appProvider/app_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../core/app_theme/color_palette.dart';
import '../../../../gen/assets.gen.dart';

class TabBarItemWidget extends StatelessWidget {
  final EventCategoryModel eventCategoryModel;
  final bool isSelected;
  const TabBarItemWidget({
    super.key,
    required this.eventCategoryModel,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppProvider>(context);
    var theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: provider.isDark
            ? isSelected
                  ? ColorPalette.primaryDarkColor
                  : ColorPalette.backgroundDarkColor
            : isSelected
            ? ColorPalette.primaryLightColor
            : ColorPalette.primaryDarkTextColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: provider.isDark
              ? ColorPalette.strokeDarkColor
              : ColorPalette.strokeLightColor,
        ),
      ),
      child: Row(
        spacing: 8,
        children: [
          eventCategoryModel.icon.svg(
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              provider.isDark
                  ? isSelected
                        ? ColorPalette.primaryDarkTextColor
                        : ColorPalette.primaryDarkColor
                  : isSelected
                  ? ColorPalette.primaryDarkTextColor
                  : ColorPalette.primaryLightColor,
              BlendMode.srcIn,
            ),
          ),
          Text(
            eventCategoryModel.name,
            style: isSelected
                ? theme.textTheme.titleMedium!.copyWith(
                    color: ColorPalette.primaryDarkTextColor,
                  )
                : theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
