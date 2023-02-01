import 'package:cached_network_image/cached_network_image.dart';
//import 'package:easy_localization/easy_localization.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/src/fading_circle.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilm_updated_version/models/bookByCatId_get_model/bookByCatId_get_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import '../../../app_utills/api_url.dart';
import '../../../global/app_colors.dart';
import '../../../global/barcode_scanner.dart';
import '../../../global/common_widgets.dart';
import '../../../global/streamsObjects.dart';
import '../../../view_model/book_subsc_bloc/book_subsc_bloc.dart';
import '../../../view_model/book_subsc_bloc/book_subsc_state.dart';
import '../../../view_model/bookbycatid_bloc/bookbycatid_bloc.dart';
import '../../../view_model/bookbycatid_bloc/bookbycatid_event.dart';
import '../../../view_model/bookbycatid_bloc/bookbycatid_states.dart';
import '../../../view_model/searchbook_bloc/searchbook_bloc.dart';
import '../../../view_model/searchbook_bloc/searchbook_event.dart';
import '../../../view_model/searchbook_bloc/searchbook_state.dart';
import '../book_chapter_screen/book_chapter_screen.dart';
import '../searchbook_screen/searchlist_screen.dart';

class BookByCatIdScreen extends StatefulWidget {
  final String? getText;
  final String? catId;
  const BookByCatIdScreen({Key? key, this.getText, this.catId}) : super(key: key);

  @override
  State<BookByCatIdScreen> createState() => _BookByCatIdScreenState();
}

class _BookByCatIdScreenState extends State<BookByCatIdScreen> {
  BookByCatIdBloc bookByCatIdBloc = BookByCatIdBloc(BookByCatIdInitialState());
  bool? istaped;
  TextEditingController searchController = TextEditingController();
  BookSubscriptionBloc bookSubscriptionBloc = BookSubscriptionBloc(BookSubsInitialState());
  bool selected = true;
  SearchBookBloc searchBookBloc = SearchBookBloc(SearchBookInitialState());
  GetStorage storage = GetStorage();
  ThemeMode themeMode = ThemeMode.light;
  @override
  void initState() {
    //bookByCatIdBloc.add(BookByCatIdEvent(CartId: widget.catId));
    active_tab_controller.stream.listen((event) {
      if(event==0){
        bookByCatIdBloc.add(BookByCatIdEvent(CartId: widget.catId));
      }
    });

    print('token is===== ${storage.read('token')}');
    if(storage.hasData('token')){
      bookByCatIdBloc.add(BookByCatIdEvent(CartId: widget.catId));
    }
    else{
      bookByCatIdBloc.add(BookByCatIdEvent(CartId: widget.catId));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: myCustomAppBar(
          titleAppBar: 'Category Id Home'.tr,
          fontSize: width * 0.045,
          context: context,
          backButton: BackButton(
            color: AppColors.allButtonColor,
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: height * 0.025,
                ),
                Container(
                  margin: EdgeInsets.only(left: width * 0.020),
                  height: height * 0.058,
                  width: width * 0.93,
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                        offset: Offset(0, 6.0),
                        color: Theme.of(context).brightness == Brightness.light? Colors.greenAccent.withOpacity(0.08):Colors.black38.withOpacity(0.04),
                        blurRadius: 0.8,
                        spreadRadius: 0.0)
                  ]),
                  child: Material(
                    elevation: 1,
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor : AppColors.whiteColor),
                      controller: searchController,
                      onChanged: (value) {
                        if (value.length > 0) {
                          searchBookBloc.add(SearchBookEvent());
                        }
                        //
                        // searchListBookController.searchListvalue.clear();
                      },
                      decoration: InputDecoration(
                          hintText:
                          'Search for book by title,Author name or ISBN'.tr,
                          hintStyle: TextStyle(fontSize: width * 0.032,color: Theme.of(context).brightness == Brightness.light ? AppColors.lightblack:AppColors.textColor),
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
                              child: const Icon(
                                Icons.zoom_in,
                                size: 35,
                                color: AppColors.whiteColor,
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
                        return Column(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: width * 0.020),
                              height: height * 0.058,
                              width: width * 0.93,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(0, 6.0),
                                      color: Theme.of(context).brightness == Brightness.light? Colors.greenAccent.withOpacity(0.08):Colors.black38.withOpacity(0.04),
                                      blurRadius: 0.8,
                                      spreadRadius: 0.08),
                                ],
                              ),
                              child: Material(
                                  elevation: 1,
                                  borderRadius: BorderRadius.circular(20),
                                  child: TextFormField(
                                    style: TextStyle(color: Theme.of(context).brightness == Brightness.light ? AppColors.blackColor:AppColors.whiteColor),
                                    readOnly: true,
                                    decoration: InputDecoration(
                                        hintText: 'Scan your textbook'.tr,
                                        hintStyle: TextStyle(fontSize: width * 0.032,color: Theme.of(context).brightness == Brightness.light ? AppColors.lightblack:AppColors.textColor),
                                        fillColor: Theme.of(context).brightness == Brightness.light ? AppColors.whiteColor:AppColors.fillColor,
                                        filled: true,
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        suffixIcon: InkWell(
                                          onTap: () {
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BarCodeScannerPage(),));
                                          },
                                          child: Container(
                                            height: height * 0.030,
                                            width: width * 0.144,
                                            decoration: BoxDecoration(
                                                color:
                                                AppColors.allButtonColor,
                                                borderRadius:
                                                BorderRadius.circular(
                                                    20)),
                                            child: Image.asset(
                                              'assets/barcode_icon.png',
                                              cacheHeight: 25,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )),

                                  )),
                            ),
                            SizedBox(
                              height: height * 0.040,
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: width * 0.060,right:width * 0.060 ),
                              child: Row(
                                children: [
                                  Text(
                                    '${widget.getText}',
                                    style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: Theme.of(context).brightness == Brightness.light ? AppColors.lightblack:AppColors.whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child:  BlocBuilder<BookByCatIdBloc, BookByCatIdState>(
                                bloc: bookByCatIdBloc,
                                builder: (context, state) {
                                  if(state is BookByCatIdLoadedState){
                                    return BookByCatScreen(context, state.response);
                                  }
                                  else if(state is BookByCatIdLoadingState) {
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
                                  else{
                                    return Text('');
                                  }
                                },

                              ),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  ),
                ]),
              ],
            ),
        ),
      );
  }

  Widget BookByCatScreen(BuildContext context, BookByCatIdGetModel bookByCatIdGetModels){
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return GridView.builder(
        itemCount:
        bookByCatIdGetModels.data!.length,
        gridDelegate:
        const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0.0,
            crossAxisSpacing: 0.0,
            childAspectRatio: 0.74),
        itemBuilder: (context, index) {
        if(bookByCatIdGetModels != null){
          print('Running if');

          print('--------------${bookByCatIdGetModels.data}');
          return Container(
           // margin: EdgeInsets.only(top: 17),
            child: Column(
              children: [
                Container(
                  margin:
                  EdgeInsets.only(top: 1),
                  height: height * 0.16,
                  child: InkWell(
                    child: CachedNetworkImage(
                      imageUrl: '$baseImageUrl' +
                          '${bookByCatIdGetModels.data![index].bookCoverImage}',
                      placeholder:
                          (context, url) =>
                          Image.asset(
                            'assets/ilam_ur.png',
                            height: 50,
                            width: 50,
                          ),
                      errorWidget:
                          (context, url, error) =>
                          Icon(Icons.error),
                    ),
                    onTap: () {
                      print('chack book  Id is == ${bookByCatIdGetModels.data![index].bId}');
                      pushNewScreen(
                        context,
                        screen: BookChapterScreen(
                          bookId: bookByCatIdGetModels.data![index].bId,
                          getBookImg: bookByCatIdGetModels.data![index].bookCoverImage,
                          author: bookByCatIdGetModels.data![index].bookAuthor,
                          bookName: bookByCatIdGetModels.data![index].bookName,
                          bookIsbn: bookByCatIdGetModels.data![index].bookIsbn,
                          bookMark:bookByCatIdGetModels.data![index].bookmarked.toString()

                        ),
                        withNavBar:
                        true, // OPTIONAL VALUE. True by default.
                        pageTransitionAnimation:
                        PageTransitionAnimation
                            .fade,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.0066,
                ),
                InkWell(
                  onTap: (){
                    if(storage.hasData('token')){
                      if(bookByCatIdGetModels.data![index].booksub == '1' ){
                        setState(() {
                          bookByCatIdGetModels.data![index].booksub = '0';

                        });
                      }else{
                        setState(() {
                          bookByCatIdGetModels.data![index].booksub = '1';
                        });
                      }
                      bookSubscriptionBloc.homeBookRepository.bookSubscriptionApi(bookId: bookByCatIdGetModels.data![index].bId,context: context);
                    }
                    else{
                      showToast(
                          'Login First'.tr,
                          context: context,
                          animation: StyledToastAnimation.fade,
                          curve: Curves.linear,
                          reverseCurve: Curves.linear);
                    }
                  },
                  child: Container(
                    height: height * 0.025,
                    width: width * 0.28,
                    decoration: BoxDecoration(
                      // color: isClicked! ? Colors.grey : Colors.blue,
                      color:
                      bookByCatIdGetModels.data![index].booksub == '1' ? AppColors.allButtonColor:Colors.grey,

                      borderRadius:
                      BorderRadius.circular(
                          20),
                    ),
                    child: Center(
                      child: bookByCatIdGetModels.data![index].booksub == '1'
                     ? Text(
                        'Subscribed'.tr,
                        textAlign:
                        TextAlign.center,
                        style: TextStyle(
                            color:
                            Colors.white,
                            fontSize: width * 0.04),
                      )
                      :Text(
                        'Subscribe'.tr,
                        textAlign:
                        TextAlign.center,
                        style: TextStyle(
                            color:
                            Colors.white,
                            fontSize: width * 0.037),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        else{
          print('runnning else');
          return Container(child: Text('zdfksgkf'),);
        }
        });
  }

}
