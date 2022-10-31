import 'package:book_nook_user/business_logic/cubit/all_book/all_book_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/book_in_library/book_in_library_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/comment/comment_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/details/details_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/home_page/home_page_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/library/library_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/login_cubit/cubit/log_in_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/offer/offer_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/order/order_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/profile/profile_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/quotes/quotes_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/setting/seeting_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/user_information/user_information_cubit.dart';
import 'package:book_nook_user/business_logic/cubit/verify/cubit/verify_cubit.dart';
import 'package:book_nook_user/data/models/Book.dart';
import 'package:book_nook_user/data/models/offers.dart';
import 'package:book_nook_user/data/models/order.dart';
import 'package:book_nook_user/data/models/quote.dart';
import 'package:book_nook_user/data/repository/user_repository.dart';
import 'package:book_nook_user/data/web_services/user_web_services.dart';
import 'package:book_nook_user/services/local_notification.dart';
import 'package:book_nook_user/services/storage/store.dart';
import 'package:book_nook_user/ui/Screens/BottomNavybar.dart';
import 'package:book_nook_user/ui/Screens/HomePage.dart';
import 'package:book_nook_user/ui/Screens/addAddress.dart';
import 'package:book_nook_user/ui/Screens/addBook.dart';
import 'package:book_nook_user/ui/Screens/add_image.dart';
import 'package:book_nook_user/ui/Screens/allLibrary/cubit.dart';
import 'package:book_nook_user/ui/Screens/allLibrary/screen.dart';
import 'package:book_nook_user/ui/Screens/all_quotes_screen.dart';
import 'package:book_nook_user/ui/Screens/borrowed%20_books/borrowed_books_cubit.dart';
import 'package:book_nook_user/ui/Screens/borrowed%20_books/borrowed_books_screen.dart';
import 'package:book_nook_user/ui/Screens/buy_book.dart';
import 'package:book_nook_user/ui/Screens/buy_offer.dart';
import 'package:book_nook_user/ui/Screens/changePassword/cubit.dart';
import 'package:book_nook_user/ui/Screens/comment_screen.dart';
import 'package:book_nook_user/ui/Screens/detailes.dart';
import 'package:book_nook_user/ui/Screens/library_screen.dart';
import 'package:book_nook_user/ui/Screens/myorders.dart';
import 'package:book_nook_user/ui/Screens/quotes.dart';
import 'package:book_nook_user/ui/Screens/savedBook/saved_book.dart';
import 'package:book_nook_user/ui/Screens/savedBook/saved_book_cubit.dart';
import 'package:book_nook_user/ui/Screens/search_user/cubit.dart';
import 'package:book_nook_user/ui/Screens/search_user/search_screen.dart';
import 'package:book_nook_user/ui/Screens/shopping_card.dart';
import 'package:book_nook_user/ui/Screens/sign_up.dart';
import 'package:book_nook_user/ui/Screens/user_information.dart';
import 'package:book_nook_user/ui/Screens/all_book.dart';
import 'package:book_nook_user/ui/Screens/category_fav.dart';
import 'package:book_nook_user/ui/Screens/log_in.dart';
import 'package:book_nook_user/ui/Screens/my_addresses.dart';
import 'package:book_nook_user/ui/Screens/settings.dart';
import 'package:book_nook_user/ui/Screens/start_screen.dart';
import 'package:book_nook_user/ui/Screens/user_profile_screen.dart';
import 'package:book_nook_user/ui/Screens/verification_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'business_logic/cubit/AddAdress/add_address_cubit.dart';
import 'business_logic/cubit/register_cubit/register_cubit.dart';
import 'services/firebase_options.dart';
import 'translate/codegen_loader.g.dart';
import 'ui/Screens/changePassword/screen.dart';

void main() async {
  await WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // final fcmToken = await FirebaseMessaging.instance.getToken();
  // // final token=await Firebase.instance.get
  // print("----fcmToken $fcmToken");

  // FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
  //   // TODO: If necessary send token to application server.

  //   // Note: This callback is fired at each app s
  //   //

  //   //tartup and whenever a new
  //   // token is generated.
  // }).onError((err) {
  //   // Error getting token.
  // });
  // await FirebaseMessaging.instance.setAutoInitEnabled(true);
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   print('------Got a message whilst in the foreground!');
  //   print('------Message data: ${message.data['title']}');

  //   if (message.notification != null) {
  //     print(
  //         '-----Message also contained a notification: ${message.notification!.body}');
  //   }
  //   LocalNotification.handle(message);
  // });
  // FirebaseMessaging messaging = FirebaseMessaging.instance;
  // NotificationSettings settings = await messaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );
  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //   print("forrrrrrrrrrrGround");
  //   print(event.data.toString());
  // });

  // FirebaseMessaging.onMessage.listen((event) {
  //   print(event.data.toString());
  // });
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await GetStorage.init();
  Store.store = GetStorage();
  // Store.store.write('token',
  //     'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiNWM5YTNmMjE4ZjcxNDNmYzAyNmQyMWQzMDQ2M2VkNzE3NTgwNjBmZGU4MzE3NmY2N2NjYzUzZTljZmMxYTA2ZDJkNTQyYWM1OWU3ZjNlNDciLCJpYXQiOjE2NjAzODI0NjEuODQyODQ2LCJuYmYiOjE2NjAzODI0NjEuODQyODQ5LCJleHAiOjE2OTE5MTg0NjEuODM4Mzk1LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.pyK05eAei7WzDb7IBb7rN1ZXi7bbAnTk4Xac-7BOZcLgj-s6bZ8fvjeomObX4vcbQVo-TVYsNv6qm_NCj6mQ6yoPo0LH2D77LEDiyv3-1r3xTF933kER31uWF8EImlloRTXvA76A1hSIFxtMmQmv7KDRQwFeQgW2SbIORsGytykPz_ZTFIVRuXf1Uz4XopUfgK7BxU-ekJDAfKWzGfsAMtrf8HgGHySZ5bAF5zlyG9gEYW6Xy_gVL1FJCEqt0b8_yrddOACihh35smTI77zaLTpF5KAu-NFzjgs8ukmPA3ByqyhUbSdMTRAIfjshJac5sDOiklr0tChh6dgBHNAjxUw_NwQBUXMm9ObzkzuQxfHXb_TdYJwIbuJaCYnWLkRn2Upim4mT01yKgOnkqM3igmizTY5qM-adIP3oIj-G4aHQu0VQbU9k1aChvnemQg9mGBAgeMCRcgtwwzZe_nYE0bKZr9kX0PWpbi0N6EO44aUB5Fh57JyJJcw8O_U1Zz8Co4vBGAlkreMOGq0eRgnQ1yFHFFrpRWkhqCKB6mbbc7DXvI7JPLH85xmXqk8q7cj9QmvLyjQX8BDzf43ZldP1Qvi3YPtIzyvFmiezMZoAsbCnSz-kFBcjK_IZAhZgAp-LpYxMYISmgVVxa80rdNy9Mfofg9RaF8_LSua8FuysefI');
  // Store.store.remove('token');
  Store.token = Store.store.read('token');

  // Store.myUser;
  Store.fcmToken = 'fcmToken';
  if (Store.token != null) {
    Store.myUser = await UserRepository(UserWebServices()).profle();
  }
  // Store.store.remove('token');
  runApp(EasyLocalization(
      path: 'assets/translate/',
      supportedLocales: const [Locale('ar'), Locale('en')],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: const MyApp()));
  // runApp(MyApp());
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (bloc is Cubit) print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => QuotesCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => VerifyCubit()),
        BlocProvider(create: (context) => UserInformationCubit()),
        BlocProvider(create: (context) => LogInCubit()),
        BlocProvider(create: (context) => AddAddressCubit()),
        BlocProvider(create: (context) => ProfileCubit()),
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => DetailsCubit()),
        BlocProvider(create: (context) => QuotesCubit()),
        BlocProvider(create: (context) => CommentCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => LibraryCubit()),
        BlocProvider(create: (context) => BookInLibraryCubit()),
        BlocProvider(create: (context) => OfferCubit()),
        BlocProvider(create: (context) => SearchCubit()),
        BlocProvider(create: (context) => SavedBookCubit()),
        BlocProvider(create: (context) => OrderCubit()),
        BlocProvider(create: (context) => BorrowedBooksCubit()),
        BlocProvider(create: (context) => AllLibraryCubit()),
        BlocProvider(create: (context) => ChangePasswordCubit()),
        BlocProvider(create: (context) => SeetingCubit()),
        BlocProvider(create: (context) => AllBookCubit()),
        BlocProvider(create: (context) => SearchCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'SfPro'),
        supportedLocales: context.supportedLocales, //supported language
        localizationsDelegates:
            context.localizationDelegates, //get fields ready
        locale: context.locale,
        home: StartHome(
          index: 1,
          // id: 1,
        ), // : const HomePageA(),
        onGenerateRoute: generateRoute,
      ),
    );
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case 'SignUp':
        return MaterialPageRoute(builder: (_) => Register());
      case 'startScreen':
        return MaterialPageRoute(builder: (_) => StartScreen());
      case 'home':
        return MaterialPageRoute(builder: (_) => HomePage());
      case 'borrowedBooksScreen':
        return MaterialPageRoute(builder: (_) => BorrowedBooksScreen());
      case 'allLibrary':
        return MaterialPageRoute(builder: (_) => AllLibrary());
      case 'startHome':
        int index = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => StartHome(
                  index: index,
                ));
      case 'login':
        return MaterialPageRoute(builder: (_) => LogIn());
      case 'adminInformation':
        return MaterialPageRoute(builder: (_) => UserInformation());
      case 'categoryFavotir':
        return MaterialPageRoute(builder: (_) => const CategoryFavourite());
      case 'home':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case 'addBook':
        return MaterialPageRoute(builder: (_) => AddBook());
      case 'changPassword':
        return MaterialPageRoute(builder: (_) => ChangPassword());
      case 'allBook':
        var books = settings.arguments as List<BookInfo>;
        return MaterialPageRoute(
            builder: (_) => AllBook(
                  books: books,
                ));
      case 'profile':
        return MaterialPageRoute(builder: (_) => UserProfileScreen());
      case 'setting':
        return MaterialPageRoute(builder: (_) => Settings());
      case 'myAddresses':
        return MaterialPageRoute(builder: (_) => MyAddresses());
      case 'searchHomeScreenUser':
        return MaterialPageRoute(builder: (_) => SearchHomeScreenUser());
      case 'verification':
        return MaterialPageRoute(builder: (_) => VerificationScreen());
      // case 'addImage':
      //   return MaterialPageRoute(builder: (_) => AddImage());
      case 'searchHomeScreenUser':
        return MaterialPageRoute(builder: (_) => SearchHomeScreenUser());
      case 'changPassword':
        return MaterialPageRoute(builder: (_) => ChangPassword());
      case 'addAddress':
        return MaterialPageRoute(builder: (_) => AddAddress());
      case 'shoppingCard':
        return MaterialPageRoute(builder: (_) => ShoppingCard());
      case 'savedBook':
        return MaterialPageRoute(builder: (_) => SavedBook());
      case 'comment':
        var book = settings.arguments as BookInfo;
        return MaterialPageRoute(
            builder: (_) => CommentScreen(
                  book: book,
                ));
      case 'allQuotes':
        int id = settings.arguments as int;
        return MaterialPageRoute(
            builder: (_) => AllQuotes(
                  id: id,
                ));
      case 'buyBook':
        var book = settings.arguments as BookInfo;
        return MaterialPageRoute(builder: (_) => BuyBook(book: book));
      case 'buyOffer':
        var offer = settings.arguments as Offer;
        return MaterialPageRoute(builder: (_) => BuyOffer(offer: offer));
      case 'details':
        final book = settings.arguments as BookInfo;
        return MaterialPageRoute(
            builder: (_) => Detailes(
                  book: book,
                ));
      case 'libraryScreen':
        final id = settings.arguments as int;
        return MaterialPageRoute(builder: (_) => LibraryScreen(id: id));
    }
  }
}
