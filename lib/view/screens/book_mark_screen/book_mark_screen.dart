//import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:get/get.dart';
import '../../../global/app_colors.dart';
import '../../../global/common_widgets.dart';
import '../../../global/streamsObjects.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_bloc.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_event.dart';
import '../../../view_model/bookmark_list_bloc/bookmark_list_state.dart';

class BookMarkScreen extends StatefulWidget {
  const BookMarkScreen({Key? key}) : super(key: key);

  @override
  State<BookMarkScreen> createState() => _BookMarkScreenState();
}

class _BookMarkScreenState extends State<BookMarkScreen> {
  BookMarkListBloc bookMarkListBloc = BookMarkListBloc(BookMarkListInitialState());

  @override
  void initState() {
    active_tab_controller.stream.listen((event) {
      if(event==3){
        bookMarkListBloc.add(BookMarkListEvent());
      }
    });
    bookMarkListBloc.add(BookMarkListEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, size) {
        var height = size.maxHeight;
        var width = size.maxWidth;
        return Scaffold(
          appBar: myCustomAppBar(
            backButton: BackButton(
              color: Colors.transparent,
            ),
            titleAppBar: 'Book Marked Items'.tr,
              fontSize: width * 0.043,
            context: context
          ),
          body: Container(
            height: height,
            child: BlocBuilder<BookMarkListBloc, BookMarkListState>(
              bloc: bookMarkListBloc,
              builder: (context, state) {
                if(state is BookMarkListLoadedState){
                  return ListView.builder(
                      itemCount: state.response.data!.length,
                      itemBuilder: (context, index) {
                       if(state.response != null){
                         return Container(
                             margin: EdgeInsets.all(10),
                            // height: height*0.080,
                             width: width*0.87,
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(12),
                               boxShadow: [
                                 BoxShadow(
                                     color: AppColors.allButtonColor.withOpacity(0.14),
                                     offset: Offset(2,4),
                                     spreadRadius: 2,
                                     blurRadius: 5
                                 ),

                               ],
                               color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor,
                             ),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Expanded(
                                   flex: 4,
                                   child: Padding(
                                     padding:  EdgeInsets.only(left: width * 0.026,right: width * 0.026),
                                     child: Row(
                                       children: [
                                         Image.asset('assets/bookmark_green.png'),
                                         SizedBox(
                                           width: width*0.030,
                                         ),
                                         Text(
                                             'Chap..${state.response.data![index].cNumber}'.tr,
                                           style: TextStyle(
                                             fontSize: width * 0.04
                                           ),
                                         ),
                                       ],
                                     ),
                                   ),
                                 ),
                                 Expanded(
                                     flex: 5,
                                     child: Center(
                                       child: Text('${state.response.data![index].bookName}',
                                         textAlign: TextAlign.center,
                                         overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: width * 0.04
                                        ),
                                        // maxLines: 1,
                                       ),
                                     )
                                 ),
                                 SizedBox(
                                   width: width*0.24,
                                 ),
                                 Expanded(flex: 1,
                                     child: Image.asset(
                                     'assets/arrow.png',
                                     height: height * 0.06,
                                       width: width * 0.01,
                                     ))
                               ],
                             )
                         );
                       }
                       else{
                         return Container(child: Text('No Data'.tr));
                       }
                      }
                      );
                }
                else if(state is BookMarkListLoadingState){
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
                    BoxDecoration(color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                  );
                }
                else{
                  return Text('');
                }

              },
            ),
          ),
        );
      }),
    );
  }
}
