part of 'home_page_cubit.dart';

@immutable
abstract class HomePageState {}

class HomePageInitial extends HomePageState {}

class ChangePage extends HomePageState {
  final int selectedPage;

  ChangePage(this.selectedPage);
}

class HomePageISuccessfull extends HomePageState {
  final List<BookInfo> books;

  HomePageISuccessfull(this.books);
}
// class HomePageInitial extends HomePageState {}
// class HomePageInitial extends HomePageState {}


