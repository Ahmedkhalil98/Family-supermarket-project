import 'package:adminapp/components/app_bar_widget.dart';
import 'package:adminapp/components/loading_widget.dart';
import 'package:adminapp/constants.dart';
import 'package:adminapp/models/slider_model.dart';
import 'package:adminapp/screens/home_screen/widgets/control_button.dart';
import 'package:adminapp/services/slider_Dialog.dart';
import 'package:adminapp/services/slider_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SliderListView extends StatefulWidget {
  const SliderListView({Key? key}) : super(key: key);

  @override
  State<SliderListView> createState() => _SliderListViewState();
}

class _SliderListViewState extends State<SliderListView> {
  @override
  Widget build(BuildContext context) {
    final sliderProvider = Provider.of<SliderProvider>(context, listen: true);
    return Scaffold(
      appBar: MyAppBar(pageTitle: "Sliders"),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context
              .read<SliderDialog>()
              .showDialogStyle(context: context, state: "Add");
        },
        backgroundColor: kPrimaryColor,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                height: 5.h,
              ),
              FutureBuilder<SliderModel>(
                  future: sliderProvider.getSliderList(),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Column(
                        children: [
                          SizedBox(
                            height: 250.h,
                          ),
                          const LoadingWidget(),
                        ],
                      );
                    }
                    if (snapshot.data == null) {
                      return const Center(
                        child: Text("data is null"),
                      );
                    }
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    }
                    List<SliderData> items = snapshot.data!.slider;
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.h),
                          height: 200.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: Container(
                                  width: 400.w,
                                  height: 140.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(10.r),
                                        topRight: Radius.circular(10.r)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://family-supermarket.000webhostapp.com/images/${items[index].imageurl}"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.all(6),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        context
                                            .read<SliderDialog>()
                                            .showDialogStyle(
                                                context: context,
                                                state: "update",
                                                data: items[index]);
                                      },
                                      child: ControlButton(
                                          color: Colors.green,
                                          iconData: Icons.edit,
                                          title: "edit"),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        sliderProvider.deleteSlider(
                                          sliderId: items[index].id,
                                          imageName: items[index].imageurl,
                                        );
                                      },
                                      child: ControlButton(
                                          color: Colors.red,
                                          iconData: Icons.delete,
                                          title: "delete"),
                                    ),
                                    SizedBox(
                                      width: 5.w,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        // sliderProvider.changeShowToUser();
                                        sliderProvider.hideSlider(
                                          sliderId: items[index].id,
                                          showToUser: items[index].showToUser,
                                        );
                                      },
                                      child: ControlButton(
                                          color: Colors.grey,
                                          iconData:
                                              items[index].showToUser == '1'
                                                  ? Icons.visibility
                                                  : Icons.visibility_off,
                                          title: items[index].showToUser == '1'
                                              ? 'show'
                                              : "hide"),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }))
            ],
          )),
    );
  }

//

}
