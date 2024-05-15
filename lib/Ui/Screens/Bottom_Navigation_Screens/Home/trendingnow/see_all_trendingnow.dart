import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Cart/cart_page.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/favourites.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/selected_product.dart';
import 'package:fursan_cart/bloc/AddFavourates/post_favourates_bloc.dart';
import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../../bloc/RemoveFavourate/remove_favourate_bloc.dart';
import '../../../../../bloc/Trendingnow/trendingnow_bloc.dart';
import '../../../../../repository/model_class/Product/ProductModel.dart';
import '../../../../Widgets/toast_message.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SeeAllTrendingNow extends StatefulWidget {
  const SeeAllTrendingNow({super.key});

  @override
  State<SeeAllTrendingNow> createState() => _SeeAllTrendingNowState();
}
bool isVisible=false;
bool animateButton=false;
bool _toastDisplayed = false;

class _SeeAllTrendingNowState extends State<SeeAllTrendingNow> {
   final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  void onRecognitionResult(String text){
    setState(() {
      keyvalue.text=text;
    });
  }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }
  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      animateButton=true;
    });
  }
  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      animateButton=false;
    });
  }
  void _onSpeechResult(SpeechRecognitionResult result) {

    setState(() {
      _lastWords = result.recognizedWords;
      keyvalue.text=result.recognizedWords;
      animateButton=false;
    });
    BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
  }
  @override
  void initState() {
    BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }

  late List<ProductModel> trendingnow;
  TextEditingController keyvalue = TextEditingController();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(visible: isVisible,
        child: AvatarGlow(
          animate: animateButton,
          glowColor: Colors.red,
          duration: const Duration(milliseconds: 2000),
          // repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          // endRadius:80,
          child: FloatingActionButton(backgroundColor: Colors.red,
            onPressed:
            _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child: Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title:  isLoading == false
            ? Row(children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Text(
            'Products',
            style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w400),
          ),
        ])
            : Padding(
          padding: EdgeInsets.only(left: mwidth * 0.022),
          child: Container(
              width: mwidth * 0.68,
              height: mheight * 0.06,
              decoration: BoxDecoration(
                  color: const Color(0xffF3F3F3),
                  borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                controller: keyvalue,
                onChanged: (value) {
                  BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
                },
                autofocus: true,
                decoration: InputDecoration(
                    prefixIcon: GestureDetector(onTap: ()=>setState(() {
                      isVisible=!isVisible;
                    }),
                      child: const Icon(
                        Icons.mic,
                        color: Color(0xff828282),
                        size: 25,
                      ),
                    ),
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    hintText: 'Search by keyword ',
                    hintStyle: const TextStyle(
                        color: Color(0xffA5A5A5),
                        fontSize: 16,
                        fontWeight: FontWeight.w400)),
              )),
        ),
        actions: [
          GestureDetector(
            onTap: () => setState(() {
              isLoading = !isLoading;
            }),
            child: const Icon(
              Icons.search,
              color: Color(0xff828282),
              size: 23.5,
            ),
          ),
          SizedBox(
            width: mwidth * 0.025,
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext a) => const Favourate_Product())),
            child: const Icon(
              Icons.favorite_outline,
              color: Color(0xff636363),
              size: 20,
            ),
          ),
          SizedBox(
            width: mwidth * 0.025,
          ),
          SizedBox(
            width: mwidth * 0.06,
            height: mheight * 0.04,
            child: Stack(children: [
              Positioned(
                top: mheight * 0.0312,
                child: GestureDetector(
                  onTap: () {
                    bottomNavigationCart=false;
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext a) => const Cart_Page()));},
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: Color(0xff636363),
                    size: 19.36,
                  ),
                ),
              ),
              Positioned(
                  top: mheight * 0.0238,
                  left: mwidth * 0.0383,
                  child: Container(
                    width: mwidth * 0.017,
                    height: mheight * 0.017,
                    decoration: const BoxDecoration(
                        color: Colors.red, shape: BoxShape.circle),
                  ))
            ]),
          ),
          SizedBox(
            width: mwidth * 0.04,
          )
        ],
      ),
      body: BlocBuilder<TrendingnowBloc, TrendingnowState>(
        builder: (context, state) {
          if (state is TrendingnowblocLoading) {
            return  Center(
              child: Lottie.asset('asset/Animations/shoppingcart.json',
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  height: mheight * 0.15),
            );
          }
          if (state is TrendingnowblocError) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<TrendingnowBloc>(context)
                    .add(FetchTrendingNow());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * .9,
                  // color: Colors.red,
                  child: Center(
                    child: Lottie.asset('asset/Animations/oopssomethingwentwrong.json',
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.cover,
                        height: mheight * 0.3),
                  )
                ),
              ),
            );
          }
          if (state is TrendingnowblocLoaded) {
            trendingnow =
                BlocProvider.of<TrendingnowBloc>(context).productModel;
            return trendingnow.isEmpty?Center(
              child: Lottie.asset('asset/Animations/nodata.json',
                  repeat: true,
                  reverse: true,
                  fit: BoxFit.cover,
                  height: mheight * 0.3),
            ):Padding(
              padding: EdgeInsets.only(top: mheight*0.015),
              child: ListView.builder(
                  itemCount: trendingnow.length,
                  itemBuilder: (BuildContext context, int index) {
    if (keyvalue.text.isEmpty) {
                    return GestureDetector(onTap: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext a) =>
                                Selected_Product(
                                  productid: trendingnow[index].id??'',
                                ))),
                      child: Card(elevation: 2,
                        child: SizedBox(
                            width: mwidth,
                            height: mheight * 0.16,
                            child: Row(
                              children: [SizedBox(width: mwidth * 0.026,),
                                Card(elevation: 2,
                                  child: SizedBox(
                                    width: mwidth * 0.27,
                                    height: mheight * 0.12,
                                    child: trendingnow[index].images!.isEmpty?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.cover,):Image.network(
                                      trendingnow[index].images!.first.url.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),SizedBox(width: mwidth * 0.03,),
                                SizedBox(
                                  width: mwidth * 0.5,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: mheight * 0.027,
                                      ),
                                      SizedBox(width: mwidth * 0.5,
                                        child: Text(
                                          trendingnow[index].name??''.toString(),
                                          maxLines: 2,
                                          style: const TextStyle(
                                              color: Color(0xff1D1D1B),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ),
                                      SizedBox(
                                          height: mheight * 0.01,
                                      ),
                                      RatingBar.builder(
                                          itemCount: 5,
                                          initialRating: 3,
                                          allowHalfRating: true,
                                          itemSize: 17,
                                          itemBuilder: (ctx, index) => const Icon(
                                            Icons.star,
                                            color: Color(0xffF3603F),
                                          ),
                                          onRatingUpdate: (value) {
                                            print(value);
                                          }),
                                      SizedBox(
                                        height: mheight * 0.014,
                                      ), Row(
                                          children: [trendingnow[index].price==null?const Text(''):
                                          Text('SAR ${trendingnow[index].price}',
                                            style: const TextStyle(
                                                decoration: TextDecoration.lineThrough,
                                                color: Color(0xff999595),
                                                fontWeight: FontWeight.w400,
                                                fontSize: 13),
                                          ),
                                            SizedBox(
                                              width: mwidth * 0.025,
                                            ),
                                            trendingnow[index].discountedAmount==null?const Text(''):
                                            Text('SAR ${trendingnow[index].discountedAmount}',
                                              style: const TextStyle(
                                                  color: Color(0xff999595),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 13),
                                            ),])
                                    ],
                                  ),
                                ),SizedBox(width: mwidth * 0.015,),
                                Column(
                                  children: [
                                    SizedBox(
                                    height: mheight * 0.0134,),
                                    trendingnow[index].variants!.first.wishListItem==null?  BlocListener<PostFavouratesBloc, PostFavouratesState>(
                                      listener: (context, state) {
                                        if (state is PostToFavourateblocLoading) {
                                          _toastDisplayed = false; // reset the flag when the bloc is in the loading state
                                          print('loading');
                                        }
                                        if (state is PostToFavourateblocLoaded) {
                                          if (!_toastDisplayed) {
                                            _toastDisplayed = true;
                                            BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
                                            ToastMessage().toastmessage(message: 'Item Added To Wishlist');
                                            print('loaded');
                                          }
                                        }
                                        if (state is PostToFavourateblocError) {
                                          if (!_toastDisplayed) {
                                            _toastDisplayed = true;
                                            ToastMessage().toastmessage(message: 'Item Already In Wishlist');
                                            print('error');
                                          }
                                        }
                                      },
                                      child: GestureDetector(
                                        onTap: () {
                                          BlocProvider.of<PostFavouratesBloc>(context)
                                              .add(FetchAddToFavourates(
                                              productid: trendingnow[index].id??''
                                                  .toString()));
                                        },
                                        child:  const Icon(
                                          Icons.favorite_outline,
                                          color: Color(0xffFFC113),
                                          size: 23,
                                        )
                                      ),
                                    ):BlocListener<RemoveFavourateBloc, RemoveFavourateState>(
                                    listener: (context, state) {
                                      if (state
                                      is RemoveFavourateblocLoading) {
                                        _toastDisplayed = false;
                                        print('loading');
                                      }
                                      if (state
                                      is RemoveFavourateblocLoaded) {
                                        if (!_toastDisplayed) {
                                          _toastDisplayed = true;
                                          BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
                                          ToastMessage().toastmessage(
                                              message:
                                              'Item Removed From Wishlist');
                                          print('loaded');
                                        }
                                      }
                                      if (state
                                      is RemoveFavourateblocError) {
                                        if (!_toastDisplayed) {
                                          _toastDisplayed = true;
                                          print('error');
                                          ToastMessage().toastmessage(
                                              message:
                                              'Oops Something Went Wrong');
                                        }
                                      }
                                    },
                                    child: GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<
                                            RemoveFavourateBloc>(
                                            context)
                                            .add(
                                          FetchRemoveFavourate(
                                            productwishlistid:
                                            trendingnow[index].variants!.first.wishListItem!.id??
                                                ''.toString(),
                                          ),
                                        );
                                      },
                                      child: const Icon(
                                        Icons.favorite,
                                        color: Color(0xffFFC113),
                                        size: 23,
                                      ),
                                    ),
                                  )
                                  ],
                                )
                              ],
                            )),
                      ),
                    );
                  }
    if (trendingnow[index]
        .name!
        .toUpperCase()
        .contains(keyvalue.text.toUpperCase())) {
      return Card(elevation: 2,
        child: SizedBox(
            width: mwidth,
            height: mheight * 0.16,
            child: Row(
              children: [SizedBox(width: mwidth * 0.026,),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (BuildContext a) =>
                              Selected_Product(
                                productid: trendingnow[index].id??'',
                              ))),
                  child: Card(elevation: 2,
                    child: SizedBox(
                      width: mwidth * 0.27,
                      height: mheight * 0.12,
                      child: trendingnow[index].images!.isEmpty?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.cover,):Image.network(
                        trendingnow[index].images!.first.url.toString(),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),SizedBox(width: mwidth * 0.03,),
                SizedBox(
                  width: mwidth * 0.5,
                  child: Column(
                    children: [
                      SizedBox(
                        height: mheight * 0.0134,),
                      trendingnow[index].variants!.first.wishListItem!.id==null?  BlocListener<PostFavouratesBloc, PostFavouratesState>(
                        listener: (context, state) {
                          if (state is PostToFavourateblocLoading) {
                            _toastDisplayed = false; // reset the flag when the bloc is in the loading state
                            print('loading');
                          }
                          if (state is PostToFavourateblocLoaded) {
                            if (!_toastDisplayed) {
                              _toastDisplayed = true;
                              BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
                              ToastMessage().toastmessage(message: 'Item Added To Wishlist');
                              print('loaded');
                            }
                          }
                          if (state is PostToFavourateblocError) {
                            if (!_toastDisplayed) {
                              _toastDisplayed = true;
                              ToastMessage().toastmessage(message: 'Item Already In Wishlist');
                              print('error');
                            }
                          }
                        },
                        child: GestureDetector(
                            onTap: () {
                              BlocProvider.of<PostFavouratesBloc>(context)
                                  .add(FetchAddToFavourates(
                                  productid: trendingnow[index].id??''
                                      .toString()));
                            },
                            child:  const Icon(
                              Icons.favorite_outline,
                              color: Color(0xffFFC113),
                              size: 23,
                            )
                        ),
                      ):BlocListener<RemoveFavourateBloc, RemoveFavourateState>(
                        listener: (context, state) {
                          if (state
                          is RemoveFavourateblocLoading) {
                            _toastDisplayed = false;
                            print('loading');
                          }
                          if (state
                          is RemoveFavourateblocLoaded) {
                            if (!_toastDisplayed) {
                              _toastDisplayed = true;
                              BlocProvider.of<TrendingnowBloc>(context).add(FetchTrendingNow());
                              ToastMessage().toastmessage(
                                  message:
                                  'Item Removed From Wishlist');
                              print('loaded');
                            }
                          }
                          if (state
                          is RemoveFavourateblocError) {
                            if (!_toastDisplayed) {
                              _toastDisplayed = true;
                              print('error');
                              ToastMessage().toastmessage(
                                  message:
                                  'Oops Something Went Wrong');
                            }
                          }
                        },
                        child: GestureDetector(
                          onTap: () {
                            BlocProvider.of<
                                RemoveFavourateBloc>(
                                context)
                                .add(
                              FetchRemoveFavourate(
                                productwishlistid:
                                trendingnow[index].variants!.first.wishListItem!.id??
                                    ''.toString(),
                              ),
                            );
                          },
                          child: const Icon(
                            Icons.favorite,
                            color: Color(0xffFFC113),
                            size: 23,
                          ),
                        ),
                      )
                    ],
                  )
                )],
            )),
      );
    }
    return null;

                  }),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
  @override
  void dispose() {
    keyvalue.clear();
    _speechToText.cancel();
    isVisible=false;
    super.dispose();
  }
}
