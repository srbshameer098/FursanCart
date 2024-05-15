import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/Bottom_Navigation_Screens/selected_product.dart';
import 'package:fursan_cart/bloc/SearchProduct/search_product_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../../repository/model_class/SearchProduct/SearchProductModel.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

TextEditingController keyvalue = TextEditingController();
late List<SearchProductModel> searchproducts;
bool isVisible=false;
bool animateButton=false;
class _SearchPageState extends State<SearchPage> {
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
    BlocProvider.of<SearchProductBloc>(context)
        .add(FetchSearchProduct(keyword: result.recognizedWords));
    setState(() {
      _lastWords = result.recognizedWords;
      keyvalue.text=result.recognizedWords;
      animateButton=false;
    });
  }


  @override
  void initState() {
    super.initState();
    _initSpeech();
  }

  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery
        .of(context)
        .size
        .width;
    var mheight = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          toolbarHeight: mheight * 0.13,
          elevation: 0,

          backgroundColor: Colors.white,
          actions: [
            Column(
              children: [
                SizedBox(
                  height: mheight * 0.03,
                ),
                Container(
                  width: mwidth * 0.95,
                  height: mheight * 0.07,
                  decoration: BoxDecoration(
                      color: const Color(0xffF3F3F3),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: mheight * 0.0065, right: mwidth * 0.03),
                    child: TextFormField(controller: keyvalue,
                      onChanged: (value) {
                        BlocProvider.of<SearchProductBloc>(context)
                            .add(FetchSearchProduct(keyword: value));
                      },onFieldSubmitted: (value){
                        BlocProvider.of<SearchProductBloc>(context)
                            .add(FetchSearchProduct(keyword: value));

                      },
                      autofocus: true,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(
                          Icons.search_rounded,
                          color: Color(0xff828282),
                          size: 25,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isVisible=!isVisible;
                            });
                          },
                          child: const Icon(
                            Icons.mic,
                            color: Color(0xff828282),
                            size: 25,
                          ),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: 'Search by keyword or Brand',
                        hintStyle: const TextStyle(
                            color: Color(0xffA5A5A5),
                            fontSize: 16,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: mwidth * 0.02,
            )
          ]),
      body: BlocBuilder<SearchProductBloc, SearchProductState>(
          builder: (context, state) {
            if (state is SearchProductblocloading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is SearchProductblocerror) {
              return RefreshIndicator(
                onRefresh: () async {
                  return BlocProvider.of<SearchProductBloc>(context)
                      .add(FetchSearchProduct(keyword: keyvalue.text));
                },
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * .9,
                    // color: Colors.red,
                    child: const Center(
                      child: Text("No data found"),
                    ),
                  ),
                ),
              );
            }
            if (state is SearchProductblocloaded) {
              searchproducts =
                  BlocProvider
                      .of<SearchProductBloc>(context)
                      .searchProductModel;
              return searchproducts.isEmpty ? Center(
                child: Lottie.asset('asset/Animations/search.json',
                    repeat: true,
                    reverse: true,
                    fit: BoxFit.cover,
                    height: mheight * 0.3),
              ) : ListView.builder(
                  itemCount: searchproducts.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext a) =>
                                  Selected_Product(
                                    productid: searchproducts[index].id,
                                  ))),
                      child: Card(
                        elevation: 2.5,
                        child: Container(
                          width: mwidth * 0.94,
                          height: mheight * 0.13,
                          color: Colors.white,
                          child: Row(
                            children: [
                              SizedBox(
                                width: mwidth * 0.045,
                              ),
                              Container(
                                width: mwidth * 0.23,
                                height: mheight * 0.1,
                                color: Colors.grey,
                                child:searchproducts[index].url==null?Image.asset('asset/Images/placeholder.jpg',fit: BoxFit.contain,): Image.network(
                                    searchproducts[index].url.toString()),
                              ),
                              SizedBox(
                                width: mwidth * 0.04,
                              ),
                              SizedBox(
                                width: mwidth * 0.63,
                                child: Center(
                                  child: Text(
                                    maxLines: 2,
                                    searchproducts[index].name??''.toString(),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
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
    isVisible=false;
    super.dispose();
  }
}
