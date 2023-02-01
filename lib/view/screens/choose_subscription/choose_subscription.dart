import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/do_subscription_bloc/do_subscription_bloc.dart';
import '../../../view_model/do_subscription_bloc/do_subscription_event.dart';
import '../../../view_model/do_subscription_bloc/do_subscription_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../view_model/package_list_bloc/package_list_bloc.dart';
import '../../../view_model/package_list_bloc/package_list_event.dart';
import '../../../view_model/package_list_bloc/package_list_state.dart';
import '../subscription_payment/subscription_payment.dart';

class ChooseSubscriptionScreen extends StatefulWidget {
  const ChooseSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<ChooseSubscriptionScreen> createState() => _ChooseSubscriptionScreenState();
}

class _ChooseSubscriptionScreenState extends State<ChooseSubscriptionScreen> {

  PackageListBloc packageListBloc = PackageListBloc(PackageListInitialState());
  //MySubscriptionBloc mySubscriptionBloc = MySubscriptionBloc(MySubsInitialState());
  DoSubscriptionBloc doSubscriptionBloc = DoSubscriptionBloc(DoSubsInitialState());

  @override
  void initState() {
   packageListBloc.add(PackageListEvent());
   // mySubscriptionBloc.add(MySubscriptionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      var height = size.maxHeight;
      var width = size.maxWidth;
      return SafeArea(
        child: Scaffold(
          appBar: myCustomAppBar(
            titleAppBar: 'Subscribe'.tr,
            fontSize: width * 0.04,
            backButton: BackButton(
              color: AppColors.allButtonColor,
            ),
            context: context
          ),
          body: Container(
            child: Column(
              children: [
                SizedBox(
                  height: 0.010,
                ),
                Center(
                  child: Container(
                    height: height * 0.23,
                    width: width * 0.40,
                    child: Image.asset('assets/subscribe_img.png'),
                  ),
                ),
                SizedBox(
                  height: 0.030,
                ),
                Center(
                  child: Text(
                    'Choose Subscription'.tr,
                    style: TextStyle(fontSize: width * 0.06, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: height * 0.020,
                ),
                Expanded(
                  child: BlocBuilder<PackageListBloc, PackageListState>(
                    bloc: packageListBloc,
                    builder: (context, state) {
                      if(state is PackageListLoadedState){
                        return GridView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: state.response.data!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1.03,
                              mainAxisSpacing: 15.5,
                              crossAxisSpacing: 10,
                            ),
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {

                                  pushNewScreen(
                                      context,
                                      screen: SubscriptionPaymentScreen(
                                        getMonthId: state.response.data![index].title,
                                        getPrice: state.response.data![index].price,
                                      )
                                  );

                                },
                                child: Container(
                                 // height: height * 0.13,
                                  width: width * 0.21,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: [
                                        BoxShadow(
                                            color: AppColors.allButtonColor
                                                .withOpacity(0.14),
                                            blurRadius: 5,
                                            spreadRadius: 2)
                                      ],
                                      color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor : AppColors.blackColor),
                                  child: Column(
                                    children: [
                                      SizedBox(height: height * 0.008,),
                                      Container(
                                        height: height * 0.13,
                                        width: width * 0.22,
                                        child: Image.asset('assets/renew_img.png'),
                                      ),
                                      SizedBox(
                                        height: height * 0.006,
                                      ),
                                      Text(
                                          '${state.response.data![index].title}',
                                      style: TextStyle(fontSize: width * 0.04),
                                      ),
                                      SizedBox(
                                        height: height * 0.01,
                                      ),
                                      Text(
                                        'AED'.tr +'${state.response.data![index].price}/-',
                                        style: TextStyle(
                                            fontSize: width * 0.04,
                                            color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                      else{
                        return Container(
                          height: height,
                          width: width,
                          child: Center(
                              child:
                              SpinKitFadingCircle(
                                size: 50,
                                color: AppColors
                                    .circlepicker,
                              )),
                          decoration:
                          BoxDecoration(
                              color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                        );
                      }
                    },
                  ),
                )
              ],
            ),
          ),
          // persistentFooterButtons: [
          //   Container(
          //     height: height * 0.073,
          //     width: width,
          //     child: Center(
          //         child: MyCustomButton(
          //           height: height * 0.05,
          //           width: width * 0.83,
          //           buttonColors: AppColors.allButtonColor,
          //           text: 'Apply Now',
          //           myimag: Image.asset(
          //             'assets/book.png',
          //             color: Colors.white,
          //           ),
          //           ontap: () {
          //            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SubscriptionPaymentScreen(),));
          //           },
          //         )),
          //   )
          // ],
        ),
      );
    });
  }
}
