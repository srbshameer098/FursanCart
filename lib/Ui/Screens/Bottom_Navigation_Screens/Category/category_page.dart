import 'package:avatar_glow/avatar_glow.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Category/subcategory_page.dart';
import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';

import '../../../../bloc/Category/category_bloc.dart';
import '../../../../repository/model_class/Category/CategoryModel.dart';
import '../../../Widgets/shimmer.dart';
import '../favourites.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class Category_page extends StatefulWidget {
  const Category_page({super.key});

  @override
  State<Category_page> createState() => _Category_pageState();
}

TextEditingController keyvalue = TextEditingController();
bool isVisible = false;
bool animateButton = false;
bool isLoading = false;
List<CategoryModel> category = [];
class _Category_pageState extends State<Category_page> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  void onRecognitionResult(String text) {
    setState(() {
      keyvalue.text = text;
    });
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {
      animateButton = true;
    });
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {
      animateButton = false;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
      keyvalue.text = result.recognizedWords;
      animateButton = false;
    });
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
  }

  @override
  void initState() {
    BlocProvider.of<CategoryBloc>(context).add(FetchCategory());
    // TODO: implement initState
    super.initState();
    _initSpeech();
  }




  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    final double itemHeight = mheight * 0.27;
    final double itemWidth = mwidth * 0.43;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: isVisible,
        child: AvatarGlow(
          animate: animateButton,
          glowColor: Colors.red,
          duration: const Duration(milliseconds: 2000),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          endRadius: 80,
          child: FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: 'Listen',
            child:
                Icon(_speechToText.isNotListening ? Icons.mic_off : Icons.mic),
          ),
        ),
      ),
      appBar: AppBar(
        toolbarHeight: mheight * 0.085,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: isLoading == false
            ? Row(
                children: [
                  SizedBox(
                    width: mwidth * 0.13,
                  ),
                  const Text(
                    'Categories',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            : Padding(
                padding: EdgeInsets.only(left: mwidth * 0.04),
                child: Container(
                    width: mwidth * 0.68,
                    height: mheight * 0.06,
                    decoration: BoxDecoration(
                        color: const Color(0xffF3F3F3),
                        borderRadius: BorderRadius.circular(10)),
                    child: TextFormField(
                      controller: keyvalue,
                      onChanged: (value) {
                        BlocProvider.of<CategoryBloc>(context)
                            .add(FetchCategory());
                      },
                      autofocus: true,
                      decoration: InputDecoration(
                          prefixIcon: GestureDetector(
                            onTap: () => setState(() {
                              isVisible = !isVisible;
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
              size: 26,
            ),
          ),
          IconButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext a) => const Favourate_Product())),
            icon: const Icon(
              Icons.favorite_outline,
              color: Color(0xff636363),
              size: 22,
            ),
          ),
        ],
      ),
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text(
            'Double Tap To Exit',
          ),
        ),
        child:
            BlocBuilder<CategoryBloc, CategoryState>(builder: (context, state) {
          if (state is CategoryblocLoading) {
            return GridView.count(
                childAspectRatio: (itemWidth / itemHeight),
                padding: EdgeInsets.only(
                    top: mheight * 0.02,
                    left: mwidth * 0.03,
                    right: mwidth * 0.03),
                crossAxisCount: 3,
                crossAxisSpacing: mwidth * 0.0265,
                mainAxisSpacing: mwidth * 0.0265,
                controller: ScrollController(keepScrollOffset: false),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: List.generate(
                  30,
                  (index) {
                    return ShimmerWidget.rectangular(
                      width: mwidth * 0.43,
                      height: mheight * 0.27,
                      shapeBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                    );
                  },
                ));
          }
          if (state is CategoryblocError) {
            return RefreshIndicator(
              onRefresh: () async {
                return BlocProvider.of<CategoryBloc>(context)
                    .add(FetchCategory());
              },
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height * .9,
                    // color: Colors.red,
                    child: Center(
                      child: Lottie.asset(
                          'asset/Animations/oopssomethingwentwrong.json',
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.cover,
                          height: mheight * 0.3),
                    )),
              ),
            );
          }
          if (state is CategoryblocLoaded) {
            category = BlocProvider.of<CategoryBloc>(context).categoryModel;
            return category.isEmpty
                ? Center(
                    child: Lottie.asset('asset/Animations/nodata.json',
                        repeat: true,
                        reverse: true,
                        fit: BoxFit.cover,
                        height: mheight * 0.3),
                  )
                : GridView.count(
                    childAspectRatio: (itemWidth / itemHeight),
                    padding: EdgeInsets.only(
                        top: mheight * 0.02,
                        left: mwidth * 0.03,
                        right: mwidth * 0.03),
                    crossAxisCount: 3,
                    crossAxisSpacing: mwidth * 0.0265,
                    mainAxisSpacing: mwidth * 0.0265,
                    controller: ScrollController(keepScrollOffset: false),
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: List.generate(
                      category.length,
                      (index) {
                        if (keyvalue.text.isEmpty) {
                          return GestureDetector(
                            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=> Sub_Category(categoryId: category[index].id.toString(),))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff12264050),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(top: mheight * 0.018),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: mwidth * 0.23,
                                      height: mheight * 0.096,
                                      child: category[index].image == null ||
                                              category[index].image!.first.url == null
                                          ? Image.asset(
                                              'asset/Images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                            )
                                          : Image.network(
                                                  category[index]
                                                      .image!.first.url
                                                      .toString(),
                                              fit: BoxFit.cover,
                                            ),
                                    ),
                                    SizedBox(
                                      height: mheight * 0.017,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: mwidth * 0.02),
                                      width: mwidth * 0.92,
                                      height: mheight * 0.047,
                                      child: Text(
                                        category[index].name == null
                                            ? ''
                                            : category[index].name.toString(),
                                        style: const TextStyle(
                                            color: Color(0xff264050),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }
                        if (category[index]
                            .name!
                            .toUpperCase()
                            .contains(keyvalue.text.toUpperCase())) {
                          return GestureDetector(
                            onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext a)=>Sub_Category(categoryId:category[index].id.toString(),))),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xff12264050),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: EdgeInsets.only(top: mheight * 0.018),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: mwidth * 0.23,
                                      height: mheight * 0.096,
                                      child: category[index].image == null ||
                                          category[index].image!.first.url == null
                                          ? Image.asset(
                                        'asset/Images/placeholder.jpg',
                                        fit: BoxFit.cover,
                                      )
                                          : Image.network(
                                            category[index]
                                                .image!
                                                .first.url
                                                .toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      height: mheight * 0.017,
                                    ),
                                    Container(
                                      padding:
                                      EdgeInsets.only(left: mwidth * 0.02),
                                      width: mwidth * 0.92,
                                      height: mheight * 0.047,
                                      child: Text(
                                        category[index].name == null
                                            ? ''
                                            : category[index].name.toString(),
                                        style: const TextStyle(
                                            color: Color(0xff264050),
                                            fontSize: 13,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ));
          } else {
            return Container();
          }
        }),
      ),
    );
  }

  @override
  void dispose() {
    keyvalue.clear();
    _speechToText.cancel();
    isVisible = false;
    super.dispose();
  }
}
