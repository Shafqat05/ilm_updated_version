import 'package:cached_network_image/cached_network_image.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../app_utills/api_url.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import '../../../global/app_colors.dart';
import '../../../global/barcode_scanner.dart';
import '../../../global/common_widgets.dart';
import '../../../models/category_book_model/category_book_get_model.dart';
import '../../../repository/home_repository/home_book_repository.dart';
import '../../../view_model/searchbook_bloc/searchbook_bloc.dart';
import '../../../view_model/searchbook_bloc/searchbook_event.dart';
import '../../../view_model/searchbook_bloc/searchbook_state.dart';
import '../bookbycatid_screen/bookbycatid_screen.dart';
import '../searchbook_screen/searchlist_screen.dart';
import 'category_book_behaviour.dart';
import 'package:ilm_updated_version/view_model/category_home_book_bloc/category_home_book_bloc.dart';
import 'package:ilm_updated_version/view_model/category_home_book_bloc/category_home_book_event.dart';
import 'package:ilm_updated_version/view_model/category_home_book_bloc/category_home_book_states.dart';
import 'package:ilm_updated_version/view/screens/bottom_sheet_screen.dart';

class CategoryHomeBookScreen extends StatefulWidget {
  const CategoryHomeBookScreen({Key? key}) : super(key: key);

  @override
  State<CategoryHomeBookScreen> createState() => _CategoryHomeBookScreenState();
}

class _CategoryHomeBookScreenState extends State<CategoryHomeBookScreen> with CategoryBookBehaviour {
  HomeScreenBloc homeScreenBloc = HomeScreenBloc(HomeScreenInitialState());
  HomeBookRepository homeBookRepository = HomeBookRepository();
  SearchBookBloc searchBookBloc = SearchBookBloc(SearchBookInitialState());

  ThemeMode themeMode = ThemeMode.light;

  Future<bool> showExitPopup() async{
    return await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Exit App?'.tr),
          content: Text('Do you want to exit this App?'.tr),
          actions: [
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'.tr)),
            ElevatedButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'.tr)),
          ],
        )
    ) ?? false;
  }

  @override
  void initState() {
    homeScreenBloc.add(HomeEvent());
   // searchBookBloc.add(SearchBookEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: showExitPopup,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: myCustomAppBar(
            titleAppBar: 'Home'.tr,
            fontSize: width * 0.045,
            context: context,
            backButton: BackButton(
              color: Colors.transparent,
            ),
          ),
          body: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: height * 0.020,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    height: height * 0.06,
                    width: width * 0.88,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.lightblack,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 2.5),
                          color: Theme.of(context).brightness == Brightness.light? Colors.greenAccent.withOpacity(0.18):Colors.black38.withOpacity(0.04),
                          blurRadius: 0.8,
                          spreadRadius: 0.8,
                        ),
                      ],
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Material(
                      // color: Colors.transparent,
                      elevation: 0,
                      borderRadius: BorderRadius.circular(30),
                      child: TextField(
                        style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor),
                        onChanged: (value) {
                          if (value.length > 0) {
                            searchBookBloc.add(SearchBookEvent());
                          } else {
                           // searchListBookController.searchListvalue.clear();
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Search using book title or ISBN'.tr,
                            hintStyle: TextStyle(fontSize: width * 0.033,
                                color: Theme.of(context).brightness == Brightness.light ? AppColors.lightblack:AppColors.offWhite
                            ),
                            fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.fillColor,
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(20)),
                            suffixIcon: Container(
                                height: height * 0.030,
                                width: width * 0.144,
                                decoration: BoxDecoration(
                                    color: AppColors.allButtonColor,
                                    borderRadius: BorderRadius.circular(20)),
                                child: Center(
                                  child: Icon(
                                    Icons.zoom_in,
                                    size: width * 0.09,
                                    color: AppColors.whiteColor,
                                  ),
                                ))),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.020,
                  ),
                  Expanded(
                    child: BlocBuilder<SearchBookBloc, SearchBookState>(
                      bloc: searchBookBloc,
                      builder: (context, state) {
                        if(state is SearchBookLoadedState){
                          return Container(
                            height:
                            MediaQuery.of(context).size.height * 0.015,
                            child: SearchListScreen(),
                          );
                        }
                        else{
                          return Container(
                            child: Column(
                              children: [
                                InkWell(
                                  onTap:(){
                                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarCodeScannerPage(),));
                                  },
                                  child: Material(
                                    elevation: 4,
                                    shadowColor:
                                    Colors.greenAccent.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                        height: height * 0.15,
                                        width: width * 0.57,

                                        //color: Colors.cyan,

                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                              height: height * 0.050,
                                              child: Image.asset(
                                                  'assets/barcode_icon.png'),
                                            ),
                                            SizedBox(
                                              height: height * 0.016,
                                            ),
                                            Container(
                                              child:
                                              Text(
                                                'Scan your Textbook'.tr,
                                              style: TextStyle(fontSize: width * 0.04,
                                              color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.textColor
                                              ),
                                              ),
                                            ),

                                            SizedBox(
                                              height: height * 0.010,
                                            ),
                                            // Container()
                                          ],
                                        )),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.020,
                                ),
                                Container(
                                  height: height * 0.029,
                                  width: width * 0.91,
                                  child: Text(
                                    'Select Subject from below'.tr,
                                    style: TextStyle(
                                        fontSize: width * 0.043,
                                        color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.textColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.010,
                                ),
                                Expanded(
                                  child: BlocBuilder<HomeScreenBloc,HomeScreenState>(
                                    bloc: homeScreenBloc,
                                    builder: (context, state) {
                                      if(state is HomeScreenLoadedState){
                                        return GridView.builder(
                                            itemCount:
                                            state.response.data!.length,
                                            padding: EdgeInsets.only(
                                                left: 10, right: 8),
                                            gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 0.90,
                                              mainAxisSpacing: 15.5,
                                              crossAxisSpacing: 10,
                                            ),
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(10),
                                                child: Material(
                                                  elevation: 3,
                                                  shadowColor: Colors.greenAccent
                                                      .withOpacity(0.5),
                                                  borderRadius:
                                                  BorderRadius.circular(8),
                                                  child: Container(
                                                      child: Center(
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            InkWell(
                                                              onTap: () {
                                                                print('${state.response.data![index]}');
                                                                print('print catagory id ${state.response.data![index].catId}');
                                                                goBack = false;

                                                                pushNewScreen(
                                                                  context,
                                                                  screen:
                                                                  BookByCatIdScreen(
                                                                    catId:
                                                                    state.response.data![
                                                                    index]
                                                                        .catId,
                                                                    getText:
                                                                    state.response.data![
                                                                    index]
                                                                        .catName,
                                                                  ),
                                                                  withNavBar:
                                                                  true, // OPTIONAL VALUE. True by default.
                                                                  pageTransitionAnimation:
                                                                  PageTransitionAnimation
                                                                      .fade,
                                                                ).then((value) =>
                                                                {goBack = true});
                                                              },
                                                              child:  Container(
                                                                margin:
                                                                EdgeInsets.only(
                                                                    top: height * 0.023),
                                                                height: height * 0.14,
                                                                width: width * 0.21,
                                                                child: Center(
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    imageUrl: '$imagecatagories' +
                                                                        state.response.data![
                                                                        index]
                                                                            .catImage!,
                                                                    placeholder:
                                                                        (context,
                                                                        url) =>
                                                                        Image
                                                                            .asset(
                                                                          'assets/ilam_ur.png',
                                                                          height: 50,
                                                                          width: 50,
                                                                        ),
                                                                    errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                        Icon(Icons
                                                                            .error),
                                                                  ),
                                                                ),
                                                                // color: AppColors.buttoncolore
                                                              ),

                                                            ),
                                                            SizedBox(
                                                              height: height * 0.013,
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: Text(
                                                                  state.response.data![index]
                                                                      .catName!,

                                                                  textAlign: TextAlign
                                                                      .center,
                                                                  style: TextStyle(
                                                                    fontSize: width * 0.043,
                                                                    color:
                                                                    Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.whiteColor,
                                                                  ),
                                                                  //overflow: TextOverflow.ellipsis,
                                                                ),
                                                              ),
                                                            ),

                                                            SizedBox(
                                                              height: height * 0.010,
                                                            )
                                                          ],
                                                        ),
                                                      )),
                                                ),
                                              );
                                            });
                                      }
                                      else{
                                        return Container(
                                          height: height,
                                          width: width,
                                          decoration:
                                          BoxDecoration(
                                              color: Theme.of(context).brightness == Brightness.light? Colors.white:AppColors.blackColor),
                                          child: Center(
                                              child:
                                              SpinKitFadingCircle(
                                                size: 50,
                                                color: AppColors
                                                    .circlepicker,
                                              )),
                                        );
                                      }
                                    },
                                  ),),
                              ],
                            ),
                          );
                        }
                      },
                    ),

                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget HomeScreenUi(BuildContext context, CategoryBookGetModel categoryBookGetModel){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  GridView.builder(
        itemCount:
        categoryBookGetModel.data!.length,
        padding: EdgeInsets.only(
            left: 10, right: 8),
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.90,
          mainAxisSpacing: 15.5,
          crossAxisSpacing: 10,
        ),
        itemBuilder: (BuildContext context,
            int index) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Material(
              elevation: 3,
              shadowColor: Colors.greenAccent
                  .withOpacity(0.5),
              borderRadius:
              BorderRadius.circular(8),
              child: Container(

                // height: height*0.12,

                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          print('${categoryBookGetModel.data![index]}');
                          print('print catagory id ${categoryBookGetModel.data![index].catId}');
                          goBack = false;

                          pushNewScreen(
                            context,
                            screen:
                            BookByCatIdScreen(
                              catId:categoryBookGetModel.data![index].catId.toString(),
                              getText: categoryBookGetModel.data![index].catName!,
                            ),
                            withNavBar:
                            true, // OPTIONAL VALUE. True by default.
                            pageTransitionAnimation:
                            PageTransitionAnimation
                                .fade,
                          ).then((value) =>
                          {goBack = true});
                        },
                        child: Container(
                            margin:
                            EdgeInsets.only(
                                top: 12),
                            height: height * 0.14,
                            width: width * 0.21,
                            child: Center(
                              child:
                              CachedNetworkImage(
                                imageUrl: '$imagecatagories' +
                                    categoryBookGetModel.data![index].catImage!,

                                placeholder:
                                    (context,
                                    url) =>
                                    Image
                                        .asset(
                                      'assets/ilam_ur.png',
                                      height: 50,
                                      width: 50,
                                    ),
                                errorWidget: (context,
                                    url,
                                    error) =>
                                    Icon(Icons
                                        .error),
                              ),
                            ),
                            // color: AppColors.buttoncolore
                          ),
                      ),
                      SizedBox(
                        height: height * 0.013,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            categoryBookGetModel.data![index].catName!,

                            textAlign: TextAlign
                                .center,
                            style: TextStyle(
                              fontSize: width * 0.038,
                              color:
                              Colors.black,
                            ),
                            //overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),

                      SizedBox(
                        height: height * 0.010,
                      )
                    ],
                  )),
            ),
          );
        });
  }

}
