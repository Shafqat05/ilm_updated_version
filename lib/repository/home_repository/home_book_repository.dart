import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get_storage/get_storage.dart';
import 'package:ilm_updated_version/models/bookByCatId_get_model/bookByCatId_get_model.dart';
import 'package:http/http.dart' as http;
import 'package:ilm_updated_version/models/category_book_model/category_book_get_model.dart';

import '../../app_utills/api_url.dart';
import '../../main.dart';
import '../../models/book_chapter_model/book_chapter_get_model.dart';
import '../../models/book_ex_question_get_model/book_ex_question_get_model.dart';
import '../../models/book_exercise_model/book_exercise_get_model.dart';
import '../../models/book_info_model/book_info_model.dart';
import '../../models/book_mark_model/bookmark_get_model.dart';
import '../../models/book_mark_model/bookmark_post_model.dart';
import '../../models/book_subscription-model/book_subscription_get_model.dart';
import '../../models/bookmark_list_model/bookmark_list_get_model.dart';
import '../../models/booksubslist_get_model/booksubslist_get_model.dart';
import '../../models/chapter_exercise_model/chapter_ex_get_model.dart';
import '../../models/chapter_info/chapter_info_get_model.dart';
import '../../models/comment_list_model/comment_list_model.dart';
import '../../models/do_subscription_model/do_subscription_model.dart';
import '../../models/exercise_info_model/exercise_info_model.dart';
import '../../models/my_subscription_model/my_subscription_model.dart';
import '../../models/package_list_model/package_list_model.dart';
import '../../models/searchbook_get_model/searchbook_get_model.dart';
import '../../models/sol_info_model/sol_info_model.dart';

class HomeBookRepository {
  Future bookByCategoryApi() async {
    CategoryBookGetModel bookByCatGetModel;
    try {
      var response = await http.get(Uri.parse('$baseUrl$catagory'));
      var data = jsonDecode(response.body);
      print('data response is === ${response.statusCode}');
      bookByCatGetModel = CategoryBookGetModel.fromJson(data);
      print('data is === $data');
      if (bookByCatGetModel != null) {
        return bookByCatGetModel;
      }
    } catch (e) {
      print('error');
    }
  }

  Future<BookByCatIdGetModel> bookByCatidApi({String? CartId}) async {
    GetStorage storage = GetStorage();
    BookByCatIdGetModel bookByCatIdGetModel;
    var response = await http.get(
      Uri.parse('$baseUrl/bookbycatid?id=$CartId&limit=10&offset=0&lng=eng'),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': storage.read('token'),
      },
    );
    var data = jsonDecode(response.body);
    bookByCatIdGetModel = BookByCatIdGetModel.fromJson(data);
    print('data response is === ${response.statusCode}');
    return bookByCatIdGetModel;
  }

  Future<BookChapterGetModel> bookChapterApi({String? chapterId}) async {
    GetStorage storage = GetStorage();
    BookChapterGetModel bookChapterGetModel;
    var response = await http.get(
      Uri.parse(
          '$baseUrl/bookchapter?id=$chapterId&limit=10&offset=0&lng=ars'),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': storage.read('token'),
      },
    );
    var data = jsonDecode(response.body);
    print('data response is === ${response.statusCode}');
    bookChapterGetModel = BookChapterGetModel.fromJson(data);
    print('data is === $data');
    return bookChapterGetModel;
  }

  Future bookExerciseApi({String? chapId}) async {
    BookExerciseGetModel bookExerciseGetModel;
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/bookexercise?chap_id=$chapId&lng=ar'));
      var data = jsonDecode(response.body);
      print('exercise data response is === ${response.statusCode}');
      bookExerciseGetModel = BookExerciseGetModel.fromJson(data);
      print('exercise data is === $data');
      if (bookExerciseGetModel != null) {
        return bookExerciseGetModel;
      }
    } catch (e) {}
  }

  Future chapterExerciseApi({String? id}) async {
    ChapterExGetModel chapterExGetModel;
    try {
      var response =
          await http.get(Uri.parse('$baseUrl/chapterexercise?id=$id&lng=ar'));
      var data = jsonDecode(response.body);
      print('data response is === ${response.statusCode}');
      chapterExGetModel = ChapterExGetModel.fromJson(data);
      print('data is === $data');
      if (chapterExGetModel != null) {
        return chapterExGetModel;
      }
    } catch (e) {}
  }

  Future<ChapterInfoGetModel> chapterInfoApi({String? id,String? chpNu}) async {
    ChapterInfoGetModel chapterInfoGetModel;
   GetStorage storage =GetStorage();
   print('token is ===== ${storage.read('token')}');
    var response = await http.get(Uri.parse(
        '$baseUrl/chapterinfo?chapterid=$id&chapternumber=$chpNu&lng=ar'),
      headers: <String, String>{
        //  'Content-Type': 'application/json; charset=UTF-8',
        //'Authorization': storage.read('token'),
      },
    );
    var data = jsonDecode(response.body);
    print('data response is === ${response.body}');
    chapterInfoGetModel = ChapterInfoGetModel.fromJson(data);
    print('data is === $data');
    return chapterInfoGetModel;
  }

  Future bookExQuestionApi({String? id}) async {
    BookExQuesGetModel bookExQuesGetModel;
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/bookexerciseques?questnumchap=$id&lng=ars'),
        // headers: {
        //   'questnumchap': '22.1',
        //   'lng': 'ar'
        // }
      );
      var data = jsonDecode(response.body);
      print('data response is === ${response.statusCode}');
      bookExQuesGetModel = BookExQuesGetModel.fromJson(data);
      print('data is === $data');
      if (bookExQuesGetModel != null) {
        return bookExQuesGetModel;
      }
    } catch (e) {}
  }

  Future bookSubscriptionApi({String? bookId, BuildContext? context}) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(
        Uri.parse('$baseUrl$bookSubscriptionUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': storage.read('token'),
        },
        body: jsonEncode({'bookid': bookId, 'lng': 'ars'}),
      );
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response is === ${response.statusCode}');
        showToast(data['message'],
            context: context,
            animation: StyledToastAnimation.fade,
            curve: Curves.linear,
            reverseCurve: Curves.linear);
      }
    } catch (e) {}
  }

  Future bookMarksApi({
    String? bookId,
    String? bookMarkId,
    String? exId,
    String? chapId,
    String? chpteNum,
    String? exNum,
    String? quesNum,
    BuildContext? context,
  }) async {
    print('book mark api request object = ${{
      "bookid": bookId,
      "bookmarkid": bookMarkId,
      "exec_id": exId,
      "chap_id": chapId,
      "chapternum": chpteNum,
      "exec_num": exNum,
      "questionnumber": quesNum,
      "lng": "aar"
    }}');
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(
          Uri.parse('https://ilamcenter.com/Webservices/addbookmark'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "bookid": bookId,
            "bookmarkid": bookMarkId,
            "exec_id": exId,
            "chap_id": chapId,
            "chapternum": chpteNum,
            "exec_num": exNum,
            "questionnumber": quesNum,
            "lng": "aar"
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
       if (response.statusCode == 200) {
        print('data response is === ${response.statusCode}');
        showToast(data['message'],
            context: context,
            animation: StyledToastAnimation.fade,
            curve: Curves.linear,
            reverseCurve: Curves.linear);
      }
    } catch (e) {}
  }

  Future bookMarkListApi({int? bookMarkId}) async {
    GetStorage storage = GetStorage();
    BookMarkListGetModel bookMarkListGetModel;
    try {
      var response = await http.post(Uri.parse('$baseUrl$bookMarksListUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"lng": "asr"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      bookMarkListGetModel = BookMarkListGetModel.fromJson(data);
      print('abdullah bhai.........$bookMarkListGetModel');
      if (bookMarkListGetModel != null) {
        return bookMarkListGetModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future bookSubsListApi({String? subBookid}) async {
    GetStorage storage = GetStorage();
    BookSubsListGetModel bookSubsListGetModel;
    try {
      var response = await http.post(Uri.parse('$baseUrl$bookSubscripListUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"lng": "dar"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      bookSubsListGetModel = BookSubsListGetModel.fromJson(data);
      print('abdullah bhai.........$bookSubsListGetModel');
      if (bookSubsListGetModel != null) {
        return bookSubsListGetModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future searchBookApi(
      {String? isbn,
      String? bookName,
      String? bookAuthor,
      String? searchKeword}) async {
    SearchBookGetModel searchBookGetModel;

    try {
      var response = await http.post(Uri.parse('$baseUrl$searchBookUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            //'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "isbn": isbn,
            "book_name": bookName,
            "book_author": bookAuthor,
            "searchkeyword": searchKeword
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
      searchBookGetModel = SearchBookGetModel.fromJson(data);
      print('abdullah bhai.........$searchBookGetModel');
      if (searchBookGetModel != null) {
        return searchBookGetModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future addComment(
      {String? exId,
      String? chpId,
      String? bId,
      String? comment,
      String? solId,
      BuildContext? context}) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(Uri.parse('$baseUrl$commenturl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "exce_id": exId,
            "chap_id": chpId,
            "b_id": bId,
            "comment": comment,
            "sol_id": solId,
            "lng": "ar"
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response code is === ${response.statusCode}');
        return 'success';
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: data['message']));

      }
    } catch (e) {}
  }

  Future editComment(
      {String? chpId, String? comment, String? solId, BuildContext? context}) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(Uri.parse('$baseUrl$editCommentUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "cid": chpId,
            "comment": comment,
            "sol_id": solId,
            "lng": "asr"
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response code is === ${response.statusCode}');
        return 'success';
      }
    } catch (e) {}
  }

  Future likeDislike(
      {String? exId,
      String? chpId,
      String? bId,
      String? likeDislike,
      String? solId,
      }) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(Uri.parse('$baseUrl$likeDislikeUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "solid": solId,
            "bookid": bId,
            "execid": exId,
            "chapterid": chpId,
            "like_dislike": likeDislike,
            "lng": "ar"
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response code is === ${response.statusCode}');

        return 'success';
        // ScaffoldMessenger.of(context!).showSnackBar(SnackBar(content: data['message']));

      }
    } catch (e) {}
  }

  Future commentListApi({String? exId, String? solId}) async {
    GetStorage storage = GetStorage();
    CommentListModel commentListModel;
    try {
      var response = await http.post(Uri.parse('$baseUrl$commentListUrl'),
          headers: <String, String>{
            //'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"exce_id": exId, "sol_id": solId, "lng": "ar"}));
      print('response code is.........${response.body}');
      var data = jsonDecode(response.body);
      print('data is === $data');
      commentListModel = CommentListModel.fromJson(data);
      print('Abdullah bhai .........$commentListModel');

      if (commentListModel != null) {
        return commentListModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future mySubscriptionApi() async {
    GetStorage storage = GetStorage();
    MySubscriptionModel mySubscriptionModel;
    try {
      var response = await http.post(Uri.parse('$baseUrl$mySubscriptionUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"lng": "ar"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      mySubscriptionModel = MySubscriptionModel.fromJson(data);
      print('response code.........${response.statusCode}');
      if (mySubscriptionModel != null) {
        return mySubscriptionModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future doSubscriptionApi(
      {String? pkgId,
      String? tId,
      String? amount,
      String? coupon,
      String? recurring}) async {
    GetStorage storage = GetStorage();
    DoSubscriptionModel doSubscriptionModel;
    try {
      var response = await http.post(Uri.parse('$baseUrl$doSubscriptionUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({
            "packageid": pkgId,
            "tid": tId,
            "amount": amount,
            "coupon": coupon,
            "recurring": recurring,
            "lng": "ar"
          }));
      var data = jsonDecode(response.body);
      print('data is === $data');
      doSubscriptionModel = DoSubscriptionModel.fromJson(data);
      print('response code.........${response.statusCode}');
      if (doSubscriptionModel != null) {
        return doSubscriptionModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }

  Future checkSubscription({String? pkgId, BuildContext? context}) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(Uri.parse('$baseUrl$checkSubscriptionUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"packageid": pkgId, "lng": "asr"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response code is === ${response.statusCode}');
        showToast(data['message'],
            context: context,
            animation: StyledToastAnimation.fade,
            curve: Curves.linear,
            reverseCurve: Curves.linear);
        return 'success';
      }
    } catch (e) {}
  }

  Future deleteCommentApi({String? cId, BuildContext? context}) async {
    GetStorage storage = GetStorage();
    try {
      var response = await http.post(Uri.parse('$baseUrl$deleteCommentUrl'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': storage.read('token'),
          },
          body: jsonEncode({"cid": cId, "lng": "ar"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      if (response.statusCode == 200) {
        print('data response code is === ${response.statusCode}');
        // showToast(data['message'],
        //     context: Get.context,
        //     animation: StyledToastAnimation.fade,
        //     curve: Curves.linear,
        //     reverseCurve: Curves.linear);
        return 'success';
      }
    } catch (e) {}
  }

  Future<BookInfoGetModel> bookInfoApi({String? bookId}) async {
    GetStorage storage = GetStorage();
    BookInfoGetModel bookInfoGetModel;
    var response = await http.get(Uri.parse('$baseUrl/bookinfo?bookid=$bookId&lng=ars'),
      headers: <String, String>{
        //'Content-Type': 'application/json; charset=UTF-8',
       // 'Authorization': storage.read('token'),
      },);
    // body: jsonEncode({"lng": "ar"}));
    var data = jsonDecode(response.body);
    print('data is === $data');
    bookInfoGetModel = BookInfoGetModel.fromJson(data);
    print('response code.........${response.statusCode}');
    return bookInfoGetModel;
  }


  Future<ExerciseInfoGetModel> exerciseInfoApi({String? exId, String? bookId, String? chpId}) async {
    GetStorage storage = GetStorage();
    ExerciseInfoGetModel exerciseInfoGetModel;
    var response = await http.get(Uri.parse('$baseUrl/exerciseinfo?exec_id=$exId&bookid=$bookId&chaperid=$chpId&lng=ar'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
       // 'Authorization': storage.read('token'),
      },);
    // body: jsonEncode({"lng": "ar"}));
    var data = jsonDecode(response.body);
    print('data is === $data');
    exerciseInfoGetModel = ExerciseInfoGetModel.fromJson(data);
    print('response data.........${response.body}');
    return exerciseInfoGetModel;
  }



  Future solInfoApi({String? exId}) async {
     GetStorage storage = GetStorage();
    SolInfoGetModel solInfoGetModel;
    try {
      var response = await http.get(Uri.parse('$baseUrl/solinfo?exec_id=$exId&bookid=1&chaperid=1&lng=ar'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          //'Authorization': storage.read('token'),
        },);
      // body: jsonEncode({"lng": "ar"}));
      var data = jsonDecode(response.body);
      print('data is === $data');
      solInfoGetModel = SolInfoGetModel.fromJson(data);
      print('response code.........${response.statusCode}');
      if (solInfoGetModel != null) {
        return solInfoGetModel;
      }
    } catch (e) {
      print('error.....${e.toString()}');
    }
  }


  Future packageListApi() async {
    GetStorage storage = GetStorage();
    PackageListModel packageListModel;
    try {
      var response = await http.get(
        Uri.parse('$baseUrl$packageListUrl'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
         // 'Authorization': storage.read('token'),
        },
      );
      var data = jsonDecode(response.body);
      print('data response is === ${response.statusCode}');
      packageListModel = PackageListModel.fromJson(data);
      print('data is === $data');
      if (packageListModel != null) {
        return packageListModel;
      }
    } catch (e) {}
  }

  Future<ExerciseInfoGetModel> exerciseInfo2Api({String? exId, String? bookId, String? chpId}) async {
    GetStorage storage = GetStorage();
    ExerciseInfoGetModel exerciseInfoGetModel;
    var response = await http.get(Uri.parse('$baseUrl/exerciseinfo?exec_id=2&bookid=$bookId&chaperid=$chpId&lng=ar'),
      headers: <String, String>{
        // 'Content-Type': 'application/json; charset=UTF-8',
        // 'Authorization': storage.read('token'),
      },);
    // body: jsonEncode({"lng": "ar"}));
    var data = jsonDecode(response.body);
    print('data is === $data');
    exerciseInfoGetModel = ExerciseInfoGetModel.fromJson(data);
    print('response data.........${response.body}');
    return exerciseInfoGetModel;
  }

}
