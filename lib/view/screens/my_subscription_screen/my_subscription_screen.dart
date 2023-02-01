import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/my_subscription_bloc/my_subscription_bloc.dart';
import '../../../view_model/my_subscription_bloc/my_subscription_event.dart';
import '../../../view_model/my_subscription_bloc/my_subscription_state.dart';

class MySubscriptionScreen extends StatefulWidget {
  const MySubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<MySubscriptionScreen> createState() => _MySubscriptionScreenState();
}

class _MySubscriptionScreenState extends State<MySubscriptionScreen> {
  MySubscriptionBloc mySubscriptionBloc = MySubscriptionBloc(MySubsInitialState());
  bool _lights = false;

  @override
  void initState() {
    mySubscriptionBloc.add(MySubscriptionEvent());
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
              titleAppBar: 'My Subscriptions'.tr,
              fontSize: width * 0.04,
              context: context,
            backButton: BackButton(color: Colors.transparent,)
          ),
          body: Stack(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: height * 0.030,
                    ),
                    Center(
                      child: Container(
                          height: height * 0.22,
                          child: Image.asset('assets/subscribed_img.png')),
                    ),
                    SizedBox(
                      height: height * 0.060,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.060,right: width * 0.060),
                      child: Row(
                        children: [
                          Text(
                            'Ilam Study Package'.tr,
                            style: TextStyle(
                                fontSize: width * 0.05, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: height * 0.023,
                    ),
                    MergeSemantics(
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.only(left: width * 0.050,right: width * 0.050),
                          child: Row(
                            children: [
                              Text(
                                'Auto Renew'.tr,
                                style: TextStyle(
                                    fontSize: width * 0.045, fontWeight: FontWeight.w400,color: AppColors.allButtonColor),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: width * 0.020),
                                child: CupertinoSwitch(
                                  value: _lights,
                                  onChanged: (bool value) {
                                    setState(() {
                                      _lights = value;
                                    });
                                  },
                                ),
                              ),
                              // onTap: () {
                              // setState(() {
                              //  _lights = !_lights;
                              // });
                              // },
                            ],
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      child: BlocBuilder<MySubscriptionBloc, MySubscriptionState>(
                        bloc: mySubscriptionBloc,
                        builder: (context, state) {
                          if(state is MySubsLoadedState){
                            return Container(
                              height: height * 0.45,
                              child: ListView.builder(
                                  itemCount: state.response.data!.length,
                                  itemBuilder: (context, index) {
                                    if(state.response.data != null){
                                      return Container(
                                        margin: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height*0.02),
                                        height: height * 0.25,
                                        width: width * 0.26,
                                        decoration: BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: AppColors.allButtonColor
                                                    .withOpacity(0.14),
                                                offset: Offset(2, 4),
                                                blurRadius: 4,
                                                spreadRadius: 2),
                                          ],
                                          borderRadius: BorderRadius.circular(16),
                                          color: Theme.of(context).brightness == Brightness.light ? Colors.white : AppColors.blackColor,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.all(6),
                                              height: height * 0.40,
                                              width: width * 0.30,
                                              child: Image.asset(
                                                'assets/renew_img.png',
                                                //'$seprateImage'+'${subscriptionController.subscripList[index]['thumb']}',fit: BoxFit.cover,
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.all(10),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${state.response.data![index].title}',
                                                          style: TextStyle(
                                                            fontSize: width * 0.038,
                                                              color: AppColors.allButtonColor,
                                                              fontWeight: FontWeight.bold),
                                                        ),
                                                        Container(
                                                          height: height * 0.040,
                                                          width: width * 0.22,
                                                          //color: AppColors.allButtonColor,
                                                          child: Image.asset(
                                                              'assets/renew_btn.png'),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                              '${state.response.data![index].activated}',
                                                          style: TextStyle(fontSize: width * 0.038),
                                                          )],
                                                      )
                                                    ],
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Expire:'.tr,
                                                            style: TextStyle(
                                                              fontSize: width * 0.038,
                                                                color:
                                                                AppColors.buttoncolore,
                                                                fontWeight:
                                                                FontWeight.w400),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.030,
                                                          ),
                                                          Text(
                                                              '${state.response.data![index].expire}',
                                                            style: TextStyle(fontSize: width * 0.038),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.010,
                                                  ),
                                                  Column(
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Text(
                                                            'Price:'.tr,
                                                            style: TextStyle(
                                                              fontSize: width * 0.038,
                                                                color:
                                                                AppColors.buttoncolore,
                                                                fontWeight:
                                                                FontWeight.w400),
                                                          ),
                                                          SizedBox(
                                                            width: width * 0.030,
                                                          ),
                                                          Text(
                                                              '${state.response.data![index].price}',
                                                            style: TextStyle(fontSize: width * 0.038),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.020,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'ACCESS NOW ALL BOOK\n SOLUTIONS'.tr,
                                                        style: TextStyle(
                                                          fontSize: width * 0.035,
                                                            color: AppColors.buttoncolore,
                                                            fontWeight: FontWeight.w400),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    }
                                    else{
                                      return Center(child: Text('No Data Found'.tr));
                                    }
                                  }),
                            );
                          }
                          else if(state is MySubsLoadingState){
                            return Container(
                              height: height,
                              width: width,
                              child:
                              Center(
                                  child: SpinKitFadingCircle(
                                    size: 50,
                                    color: AppColors.circlepicker,
                                  )
                              ),
                              decoration:
                              BoxDecoration(color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor : AppColors.blackColor),
                            );
                          }
                          else{
                            return Text('');
                          }
                        },
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      );
    });
  }
}
