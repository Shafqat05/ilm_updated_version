import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fullscreen/fullscreen.dart';

import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../view_model/searchbook_bloc/searchbook_bloc.dart';
import '../../../view_model/searchbook_bloc/searchbook_state.dart';

class SelectedListScreen extends StatefulWidget {
  final Map? myMapValue;
  const SelectedListScreen({Key? key, this.myMapValue}) : super(key: key);

  @override
  State<SelectedListScreen> createState() => _SelectedListScreenState();
}

class _SelectedListScreenState extends State<SelectedListScreen> {
  SearchBookBloc searchBookBloc = SearchBookBloc(SearchBookInitialState());
  bool isHide = true;

  @override
  void initState() {
    print('check map value ${widget.myMapValue}');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(
        builder: (context, size) {
          var height = size.maxHeight;
          var width = size.maxWidth;
          return Scaffold(
            appBar: isHide
           ? myCustomAppBar(
              titleAppBar: 'Selected Text'.tr,
              fontSize: width * 0.045,
              context: context,
              backButton: BackButton(
                color: AppColors.allButtonColor,
              ),
            )
          : PreferredSize(child: SizedBox(), preferredSize: Size.fromHeight(5)),
            body: Stack(
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.015,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: width * 0.02,vertical: height * 0.02),
                        //height: height * 0.12,
                        width: width * 0.95,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: AppColors.allButtonColor
                                      .withOpacity(0.14),
                                  offset: Offset(4, 6),
                                  blurRadius: 5,
                                  spreadRadius: 2)
                            ],
                            color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.030,
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                 // height: height * 0.090,
                                  width: width * 0.13,
                                  child: Image.network(
                                    '$baseImageUrl' +
                                        widget.myMapValue!['book_cover_image'],
                                  ),
                                ),
                                SizedBox(width: width * 0.030),
                                Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                '${widget.myMapValue!['book_name']}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    color: AppColors.allButtonColor,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.013,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  right: width * 0.020),
                                              child: Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Icon(
                                                    Icons.bookmark,
                                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.50) : AppColors.textColor,
                                                    size: width * 0.07,
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.020,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (isHide) {
                                                        setState(() {
                                                          isHide = false;
                                                        });
                                                        enterFullScreen(
                                                          FullScreenMode
                                                              .EMERSIVE_STICKY,
                                                        );
                                                      } else {
                                                        setState(() {
                                                          isHide = true;
                                                        });
                                                        exitFullScreen();
                                                      }
                                                    },
                                                    child: isHide
                                                   ? Image.asset(
                                                      'assets/fullscreen.png',
                                                      //cacheHeight: 24,
                                                      height: height * 0.04,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,

                                                    )
                                                        : Icon(
                                                      Icons.zoom_out_map,
                                                      size: width * 0.04,
                                                      color: Theme.of(context).brightness == Brightness.light? AppColors.blackColor:AppColors.textColor,

                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'Author: '.tr,
                                              style: TextStyle(
                                                  fontSize: width * 0.04,
                                                  color: AppColors.allButtonColor,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Expanded(
                                              child: Text(
                                                '${widget.myMapValue!['book_author']}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: width * 0.04,
                                                    color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.60) : AppColors.textColor
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              'ISBN:'.tr,
                                              style: TextStyle(
                                                color: AppColors.allButtonColor,
                                                fontSize: width * 0.04
                                              ),
                                            ),
                                            SizedBox(
                                              width: width * 0.030,
                                            ),
                                            Text(
                                              '${widget.myMapValue!['book_isbn']}',
                                              style: TextStyle(
                                                fontSize: width * 0.04,
                                                  color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.60) : AppColors.textColor
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ))
                              ],
                            ),
                            SizedBox(
                              height: height * 0.013,
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: height * 0.040,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
