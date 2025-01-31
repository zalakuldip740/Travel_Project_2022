import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:make_my_trip/core/base/base_state.dart';
import 'package:make_my_trip/core/theme/make_my_trip_colors.dart';
import 'package:make_my_trip/core/theme/text_styles.dart';
import 'package:make_my_trip/features/hotel_listing/data/models/hotel_list_model.dart';
import 'package:make_my_trip/features/hotel_listing/presentation/pages/hotel_list_shimmer_page.dart';
import 'package:make_my_trip/utils/constants/image_path.dart';
import 'package:make_my_trip/utils/constants/string_constants.dart';
import 'package:make_my_trip/utils/widgets/common_error_widget.dart';
import '../cubits/hotel_list_cubit.dart';
import '../widgets/hotel_list_view_widget.dart';

class HotelListPage extends StatelessWidget {
  const HotelListPage({Key? key, required this.arg}) : super(key: key);
  final Map<String, dynamic> arg;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          arg['city_name'],
          maxLines: 1,
          style: AppTextStyles.unselectedLabelStyle,
        ),
      ),
      body: SafeArea(
        child: BlocBuilder<HotelListCubit, BaseState>(
          builder: (context, state) {
            if (state is StateOnSuccess) {
              List<HotelListModel> hotelListModel = state.response;

              if (hotelListModel.isEmpty) {
                return Expanded(
                    child: CommonErrorWidget(
                        imagePath: ImagePath.noDataFoundImage,
                        title: StringConstants.noHotelFound,
                        statusCode: ""));
              }
              return Expanded(
                  child: ListView.builder(
                      itemCount: hotelListModel.length,
                      itemBuilder: (context, index) {
                        return HotelListViewWidget(
                            hotelListModel: hotelListModel[index]);
                      }));
            } else {
              return HotelListShimmer();
            }
          },
        ),
      ),
    );
  }
}
