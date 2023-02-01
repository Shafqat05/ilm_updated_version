import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:ilm_updated_version/view/screens/searchbook_screen/selectedlistvalue_screen.dart';

import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../view_model/category_home_book_bloc/category_home_book_bloc.dart';
import '../../../view_model/category_home_book_bloc/category_home_book_event.dart';
import '../../../view_model/category_home_book_bloc/category_home_book_states.dart';
import '../../../view_model/searchbook_bloc/searchbook_bloc.dart';
import '../../../view_model/searchbook_bloc/searchbook_event.dart';
import '../../../view_model/searchbook_bloc/searchbook_state.dart';

class SearchListScreen extends StatefulWidget {

  const SearchListScreen({Key? key,}) : super(key: key);

  @override
  State<SearchListScreen> createState() => _SearchListScreenState();
}

class _SearchListScreenState extends State<SearchListScreen> {
  SearchBookBloc searchBookBloc = SearchBookBloc(SearchBookInitialState());
  //TextEditingController textListController = TextEditingController();
  HomeScreenBloc homeScreenBloc = HomeScreenBloc(HomeScreenInitialState());

  @override
  void initState() {
    searchBookBloc.add(SearchBookEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size _screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(top: 18, left: 22, right: 22),
      height: _screenSize.height,
      width: _screenSize.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
              blurRadius: 2,
              color: AppColors.buttoncolore.withOpacity(0.25),
              offset: Offset(2, 2))
        ],
        color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.lightblack,
      ),
      child: BlocConsumer<SearchBookBloc, SearchBookState>(
        bloc: searchBookBloc,
        builder: (context, state) {
          if(state is SearchBookLoadedState){
            return ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                itemCount: state.response.data!.length,
                itemBuilder: (context, index) {
                  if(state.response != null){
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SelectedListScreen(
                          myMapValue: state.response.data![index].toJson(),
                        ),));
                         print('${state.response.data![index]}');
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(9),
                              bottomRight: Radius.circular(9)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 5,
                                color: AppColors.allButtonColor.withOpacity(0.14),
                                offset: Offset(2, 2),
                                spreadRadius: 2
                            )
                          ],
                          color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.blackColor,
                        ),
                        margin: EdgeInsets.only(top: 5, left: 8, right: 8),
                       // height: _screenSize.height * 0.15,
                        width: _screenSize.width * 0.44,
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(6),
                              height: _screenSize.height * 0.11,
                              child: Image.network('$imagecatagories' +
                                  state.response.data![index].bookCoverImage.toString()),

                            ),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: 20,left: 7,right: 7),
                                  child: Column(
                                    children: [
                                      Row(

                                        children: [
                                          Expanded(
                                              child: Text(
                                                '${state.response.data![index].bookName}',
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: _screenSize.width * 0.045,
                                                    color: AppColors.allButtonColor),
                                              )),

                                        ],
                                      ),
                                      SizedBox(
                                        height: _screenSize.height * 0.010,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Author:'.tr,
                                            style: TextStyle(
                                              color: AppColors.allButtonColor,
                                              fontSize: _screenSize.width * 0.04
                                            ),
                                          ),
                                          Expanded(
                                            child: Text(
                                              '${state.response.data![index].bookAuthor}',
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: _screenSize.width * 0.04,
                                                  fontWeight: FontWeight.w400,
                                                  color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.50) : AppColors.offWhite
                                              ),
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text('ISBN:'.tr,
                                              style: TextStyle(
                                                color: AppColors.allButtonColor,
                                                fontSize: _screenSize.width * 0.04
                                              )),
                                          SizedBox(
                                            width: _screenSize.width * 0.030,
                                          ),
                                          Text(
                                            '${state.response.data![index].bookIsbn}',
                                            style: TextStyle(fontWeight: FontWeight.w400,
                                                color: Theme.of(context).brightness == Brightness.light ? Colors.black.withOpacity(0.50) : AppColors.offWhite,
                                              fontSize: _screenSize.width * 0.04
                                            ),
                                          ),

                                        ],
                                      ),
                                      SizedBox(
                                        height: _screenSize.height * 0.01,
                                      )
                                    ],
                                  ),
                                ))
                          ],
                        ),
                      ),
                    );
                  }
                  else{
                    return Container(child: Text('No Data Found'.tr),);
                  }
                }
                );
          }
          else if(state is HomeScreenLoadingState){
            return Center(
                child: SpinKitFadingCircle(
                  size: 50,
                  color: AppColors.circlepicker,
                )
            );
          }
          else{
            return Text('');
          }
        },
        listener: (context, state) {

        },
      ),
    );
  }
}

