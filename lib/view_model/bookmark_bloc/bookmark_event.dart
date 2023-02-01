import 'dart:core';

abstract class BookMarkScreenEvent{}
class BookMarkEvent extends BookMarkScreenEvent{
  String? bookId;
  String? bookMarkId;
  String? exId;
  String? chapId;
  String? chpteNum;
  String? exNum;
  String? quesNum;
  BookMarkEvent({
    required this.bookId,
    required this.bookMarkId,
    required this.exId,
    required this.chapId,
    required this.chpteNum,
    required this.exNum,
    required this.quesNum});
}