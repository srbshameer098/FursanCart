import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/Category/subcategory_selected_item.dart';

import 'package:fursan_cart/bloc/SubCategoryPage/sub_category_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


import '../../../../repository/model_class/Subcategory/SubCategoryModel.dart';
import '../favourites.dart';

class Sub_Category extends StatefulWidget {
  final String categoryId;

  const Sub_Category({super.key,required this.categoryId});

  @override
  State<Sub_Category> createState() => _Sub_CategoryState();
}
TextEditingController keyvalue = TextEditingController();
bool isVisible = false;
bool animateButton = false;
bool isLoading = false;
class _Sub_CategoryState extends State<Sub_Category> {
  late List<SubCategoryModel> subcategory;
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
    BlocProvider.of<SubCategoryBloc>(context).add(FetchSubCategory(categoryId: widget.categoryId));
  }

  @override
  void initState() {
    BlocProvider.of<SubCategoryBloc>(context).add(FetchSubCategory(categoryId:  widget.categoryId));
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;
    return Scaffold(backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Visibility(
        visible: isVisible,
        child: AvatarGlow(
          animate: animateButton,
          glowColor: Colors.red,
          duration: const Duration(milliseconds: 2000),
          // repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          // endRadius: 80,
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
        titleSpacing: 0,centerTitle: false,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: isLoading == false
            ? Row(children: [
          IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          const Text(
            'Sub categories',
            style: TextStyle(
                color: Colors.black, fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ])
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
                  BlocProvider.of<SubCategoryBloc>(context)
                      .add(FetchSubCategory(categoryId:  widget.categoryId));
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
      body: BlocBuilder<SubCategoryBloc, SubCategoryState>(
                    builder: (context, state) {
                  if (state is SubCategoryblocLoading) {
                    return Center(
                      child: Lottie.asset('asset/Animations/shoppingcart.json',
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.cover,
                          height: mheight * 0.15),
                    );
                  }
                  if (state is SubCategoryblocError) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        return BlocProvider.of<SubCategoryBloc>(context)
                            .add(FetchSubCategory(categoryId:  widget.categoryId));
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
                  if (state is SubCategoryblocLoaded) {
                    subcategory = BlocProvider.of<SubCategoryBloc>(context)
                        .subcategoryModel;
                    return subcategory.isEmpty?Center(
                      child: Lottie.asset('asset/Animations/nodata.json',
                          repeat: true,
                          reverse: true,
                          fit: BoxFit.cover,
                          height: mheight * 0.3),
                    ): ListView.builder(
                        padding: EdgeInsets.only(top: mheight * 0.02,left: mwidth*0.02),
                        itemCount: subcategory.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (keyvalue.text.isEmpty) {
                            return GestureDetector(onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext a) =>
                                          SubCategorySelectedItem(
                                            subcategoryid:subcategory[index].id ?? '',
                                          )));
                            },
                              child: Card(
                                elevation: 2,
                                child: SizedBox(width: mwidth,height: mheight*0.12,
                                  child: Row(children: [SizedBox(width: mwidth*0.035,),
                                    Container(
                                      width: mwidth * 0.2,
                                      height: mheight * 0.2,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFFC113)),
                                      child: Center(
                                        child: SizedBox(
                                          width: mwidth * 0.14,
                                          height: mheight * 0.1,
                                          child: subcategory[index].image == null ||
                                              subcategory[index].image!.first.url ==
                                                  null
                                              ? Image.asset(
                                            'asset/Images/placeholder.jpg',
                                            fit: BoxFit.cover,
                                          )
                                              : Image.network(
                                                subcategory[index]
                                                    .image!.first.url
                                                    .toString(),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),SizedBox(width: mwidth*0.05,),Container(
                                      padding: EdgeInsets.only(
                                          top: mheight * 0.028,
                                          left: mwidth * 0.012),
                                      width: mwidth * 0.4,
                                      height: mheight * 0.08,
                                      child: Text(
                                        subcategory[index].name == null
                                            ? ''
                                            : subcategory[index].name.toString(),
                                        style: const TextStyle(
                                            color: Color(0xffA5A3A3),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],),
                                ),
                              ),
                            );
                          }
                          if (subcategory[index]
                              .name!
                              .toUpperCase()
                              .contains(keyvalue.text.toUpperCase())) {
                            return GestureDetector(onTap: (){
                              Navigator.of(context).push(
                                  MaterialPageRoute(
                                      builder: (BuildContext a) =>
                                          SubCategorySelectedItem(
                                            subcategoryid:subcategory[index].id ?? '',
                                          )));
                            },
                              child: Padding(
                                padding: EdgeInsets.only(left: mwidth*0.053),
                                child: Card(
                                  elevation: 6,
                                  child: Row(children: [SizedBox(width: mwidth*0.035,),
                                    Container(
                                      width: mwidth * 0.2,
                                      height: mheight * 0.2,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xffFFC113)),
                                      child: Center(
                                        child: SizedBox(
                                          width: mwidth * 0.14,
                                          height: mheight * 0.1,
                                          child: subcategory[index].image == null ||
                                              subcategory[index].image!.first.url ==
                                                  null
                                              ? Image.asset(
                                            'asset/Images/placeholder.jpg',
                                            fit: BoxFit.cover,
                                          )
                                              : Image.network(
                                                subcategory[index]
                                                    .image!.first
                                                    .url
                                                    .toString(),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),SizedBox(width: mwidth*0.05,),Container(
                                      padding: EdgeInsets.only(
                                          top: mheight * 0.028,
                                          left: mwidth * 0.012),
                                      width: mwidth * 0.4,
                                      height: mheight * 0.08,
                                      child: Text(
                                        subcategory[index].name == null
                                            ? ''
                                            : subcategory[index].name.toString(),
                                        style: const TextStyle(
                                            color: Color(0xffA5A3A3),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17),
                                      ),
                                    ),
                                  ],),
                                ),
                              ),
                            );
                          }
                          return null;
                        });
                  } else {
                    return Container();
                  }
                }),
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
