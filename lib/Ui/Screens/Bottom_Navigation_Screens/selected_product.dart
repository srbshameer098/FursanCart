import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fursan_cart/bloc/AddCart/add_to_cart_bloc.dart';
import 'package:fursan_cart/main.dart';
import 'package:lottie/lottie.dart';
import '../../../bloc/AddFavourates/post_favourates_bloc.dart';
import '../../../bloc/GetCart/get_cart_bloc.dart';
import '../../../bloc/RemoveFavourate/remove_favourate_bloc.dart';
import '../../../bloc/SelectedProduct/selected_product_bloc.dart';
import '../../../repository/model_class/SelectedProductModel/SelectedProductModel.dart';
import '../../Widgets/toast_message.dart';
import 'Home/slider/selected_product_slider.dart';
import 'Cart/cart_page.dart';
import 'buynow_order_summary.dart';
import 'package:flutter_html/flutter_html.dart';
class Selected_Product extends StatefulWidget {
  final productid;
  const Selected_Product({super.key, required this.productid});

  @override
  State<Selected_Product> createState() => _Selected_ProductState();
}

class _Selected_ProductState extends State<Selected_Product> {
  @override
  void initState() {
    BlocProvider.of<SelectedProductBloc>(context)
        .add(FetchSelectedProduct(productid: widget.productid));


    super.initState();
  }

  late SelectedProductModel selectedproduct;

  TextEditingController count = TextEditingController(text: '1');
  int flag=0;
  @override
  Widget build(BuildContext context) {
    var mwidth = MediaQuery.of(context).size.width;
    var mheight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: BlocBuilder<SelectedProductBloc, SelectedProductState>(
            builder: (context, state) {
              if (state is SelectedProductblocLoading) {
                return Center(
                  child: Lottie.asset('asset/Animations/shoppingcart.json',
                      repeat: true,
                      reverse: true,
                      fit: BoxFit.cover,
                      height: mheight * 0.15),
                );
              }
              if (state is SelectedProductblocError) {
                return RefreshIndicator(
                  onRefresh: () async {
                    return BlocProvider.of<SelectedProductBloc>(context)
                        .add(FetchSelectedProduct(productid: widget.productid));
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
              if (state is SelectedProductblocLoaded) {
                double selectedproductdiscountprice = 0;
                selectedproduct =
                    BlocProvider.of<SelectedProductBloc>(context).productmodel;
                if (selectedproduct.product != null ||
                    selectedproduct.product!.discountedAmount != null) {
                  selectedproductdiscountprice = double.parse(
                      selectedproduct.product!.discountedAmount.toString());
                }


                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(
                              left: mwidth * 0.91, top: mheight * 0.0055),
                          child:
                          selectedproduct.product!.variants!.first.wishListItem==null?  BlocListener<PostFavouratesBloc, PostFavouratesState>(
                            listener: (context, state) {
                              if (state is PostToFavourateblocLoading) {
                                print('loading');
                              }
                              if (state is PostToFavourateblocLoaded) {

                                ToastMessage().toastmessage(message: 'Item Added To Wishlist');
                                BlocProvider.of<SelectedProductBloc>(context)
                                    .add(FetchSelectedProduct(productid: widget.productid));
                                print('loaded');
                              }
                              if (state is PostToFavourateblocError) {
                                ToastMessage().toastmessage(
                                    message: 'Item Already In Wishlist');
                                print('error');
                              }
                            },
                            child: GestureDetector(
                              onTap: () {
                                BlocProvider.of<PostFavouratesBloc>(context).add(
                                    FetchAddToFavourates(
                                        productid: selectedproduct.product!.variants!.first.id ??
                                            ''.toString()));
                              },
                              child:const Icon(
                                Icons.favorite_border,
                                color: Color(0xffFFC113),
                                size: 23,
                              ),
                            ),
                          ):BlocListener<RemoveFavourateBloc,
                              RemoveFavourateState>(
                            listener: (context, state) {
                              if (state
                              is RemoveFavourateblocLoading) {
                                print('loading');
                              }
                              if (state
                              is RemoveFavourateblocLoaded) {
                                BlocProvider.of<SelectedProductBloc>(context)
                                    .add(FetchSelectedProduct(productid: widget.productid));
                                ToastMessage().toastmessage(
                                    message:
                                    'Item Removed From Wishlist');
                                print('loaded');
                              }

                              if (state
                              is RemoveFavourateblocError) {
                                print('error');
                                ToastMessage().toastmessage(
                                    message:
                                    'Oops Something Went Wrong');
                              }
                            },child:GestureDetector(
                            onTap: () {
                              if (selectedproduct.product!.variants!.first.id != null) {
                                var id = selectedproduct.product!.variants!.first.id;
                                BlocProvider.of<
                                    RemoveFavourateBloc>(
                                    context)
                                    .add(FetchRemoveFavourate(
                                    productwishlistid:id.toString()));
                              } else {
                                print('no item found');
                              }

                            },
                            child:const Icon(
                              Icons.favorite,
                              color: Color(0xffFFC113),
                              size: 23,
                            ),
                          ) ,
                          )),
                      SizedBox(
                        width: mwidth,
                        height: mheight * 0.335,
                        child: Selected_Product_Slider(
                          SelectedProductModel: selectedproduct,
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.02,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.038),
                        child: SizedBox(
                          width: mwidth * 0.98,
                          child: Text(
                            selectedproduct.product != null ||
                                selectedproduct.product!.name != null
                                ? selectedproduct.product!.name.toString()
                                : ' ',
                            style: const TextStyle(
                                color: Color(0xff1D1D1B),
                                fontWeight: FontWeight.w400,
                                fontSize: 20),
                            maxLines: 2,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.04, top: mheight * 0.014),
                        child: Row(children: [
                          selectedproduct.product!.price == null
                              ? const Text('')
                              : Text(
                            'SAR ${selectedproduct.product!.price}',
                            style: const TextStyle(
                                decoration: TextDecoration.lineThrough,
                                color: Color(0xff999595),
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                          ),
                          SizedBox(
                            width: mwidth * 0.03,
                          ),
                          selectedproduct.product!.discountedAmount == null
                              ? const Text('')
                              : Text(
                            'SAR ${selectedproduct.product!.discountedAmount}',
                            style: const TextStyle(
                                color: Color(0xff999595),
                                fontWeight: FontWeight.w500,
                                fontSize: 16),
                          ),
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: mwidth * 0.038, top: mheight * 0.01),
                        child: RatingBar.builder(
                            itemCount: 5,
                            initialRating: 3,
                            allowHalfRating: true,
                            itemSize: 16.5,
                            itemBuilder: (ctx, index) => const Icon(
                              Icons.star,
                              color: Color(0xffF3603F),
                            ),
                            onRatingUpdate: (value) {
                              print(value);
                            }),
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffF0F0F0),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          if (selectedproduct.product != null &&
                              selectedproduct.product!.discPerQtt!.isNotEmpty &&
                              selectedproduct.product!.discPerQtt!.isNotEmpty)
                            Column(
                              children: [
                                Text(
                                  '${selectedproduct.product!.discPerQtt![0].qttFrom} - ${selectedproduct.product!.discPerQtt![0].qttTo} sets',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: mheight * 0.01),
                                Text(
                                  'SAR ${selectedproduct.product!.discPerQtt![0].discFlatAmnt}',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(width: mwidth * 0.03),
                          if (selectedproduct.product != null &&
                              selectedproduct.product!.discPerQtt!.isNotEmpty &&
                              selectedproduct.product!.discPerQtt!.length >= 2)
                            Column(
                              children: [
                                Text(
                                  '${selectedproduct.product!.discPerQtt![1].qttFrom} - ${selectedproduct.product!.discPerQtt![1].qttTo} sets',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: mheight * 0.01),
                                Text(
                                  'SAR ${selectedproduct.product!.discPerQtt![1].discFlatAmnt}',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          SizedBox(width: mwidth * 0.03),
                          if (selectedproduct.product != null &&
                              selectedproduct.product!.discPerQtt!.isNotEmpty &&
                              selectedproduct.product!.discPerQtt!.length >= 3)
                            Column(
                              children: [
                                Text(
                                  '${selectedproduct.product!.discPerQtt![2].qttFrom} - ${selectedproduct.product!.discPerQtt![2].qttTo} sets',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                SizedBox(height: mheight * 0.01),
                                Text(
                                  'SAR ${selectedproduct.product!.discPerQtt![2].discFlatAmnt}',
                                  style: const TextStyle(
                                    color: Color(0xff1D1D1B),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                      const Divider(
                        thickness: 1,
                        color: Color(0xffF0F0F0),
                      ),
                      SizedBox(
                        height: mheight * 0.012,
                      ),
                      Center(
                        child: SizedBox(
                          width: mwidth * 0.512,
                          height: mheight * 0.05,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (int.parse(count.text) > 1) {
                                    count.text =
                                        (int.parse(count.text) - 1).toString();
                                  }
                                },
                                child: Container(
                                  width: mwidth * 0.12,
                                  height: mheight * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xffEEEEEE))),
                                  child: const Center(
                                    child: Icon(
                                      Icons.horizontal_rule_rounded,
                                      color: Color(0xff929292),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: mwidth * 0.02,
                              ),
                              Container(
                                width: mwidth * 0.23,
                                height: mheight * 0.05,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border:
                                    Border.all(color: const Color(0xffEEEEEE))),
                                child: Center(
                                    child: TextFormField(
                                      style: const TextStyle(color: Color(0xff929292)),
                                      controller: count,
                                      keyboardType: TextInputType.number,
                                      textAlign: TextAlign.center,
                                      decoration: const InputDecoration(
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          hintStyle: TextStyle(
                                              color: Color(0xff929292),
                                              fontSize: 13.5)),
                                    )),
                              ),
                              SizedBox(
                                width: mwidth * 0.02,
                              ),
                              GestureDetector(
                                onTap: () {
                                  count.text =
                                      (int.parse(count.text) + 1).toString();
                                },
                                child: Container(
                                  width: mwidth * 0.12,
                                  height: mheight * 0.05,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      border: Border.all(
                                          color: const Color(0xffEEEEEE))),
                                  child: const Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Color(0xff929292),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.02,
                      ),
                      Center(
                        child: BlocListener<AddToCartBloc, AddToCartState>(
                          listener: (context, state) async {
                            if (state is AddToCartblocLoaded) {
                              initial = 0;

                              BlocProvider.of<GetCartBloc>(context)
                                  .add(FetchGetCart());
                              print('loaded');
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: const Text('Item added to cart'),
                                action: SnackBarAction(
                                    label: 'Go To Cart',
                                    textColor: Colors.orange,
                                    onPressed: () {
                                      bottomNavigationCart=false;
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (BuildContext a) =>
                                              const Cart_Page()));}
                                ),
                                behavior: SnackBarBehavior.floating,
                                margin: EdgeInsets.only(bottom: mheight * 0.02),
                              ));
                            }
                            if (state is AddToCartblocLoading) {
                              print('loading');
                            }
                            if (state is AddToCartblocError) {
                              ToastMessage().toastmessage(
                                  message: 'Oops Something Went Wrong');
                            }
                            // TODO: implement listener
                          },
                          child: GestureDetector(
                            onTap: () {

                              print(selectedproduct.product!.id.toString());
                              BlocProvider.of<AddToCartBloc>(context)
                                  .add(FetchAddToCart(
                                varientid: selectedproduct.product == null ||
                                    selectedproduct.product!.variants == null
                                    ? ''
                                    : selectedproduct.product!.variants!.first.id.toString(),
                                // price: double.parse(selectedproduct.product ==
                                //     null ||
                                //     selectedproduct.product!.discountedAmount ==
                                //         null
                                //     ? '0'
                                //     : selectedproduct.product!.discountedAmount
                                //     .toString()),
                                quantity: int.parse(count.text),
                              ));
                            },
                            child: Container(
                              width: mwidth * 0.94,
                              height: mheight * 0.08,
                              decoration: BoxDecoration(
                                  color: const Color(0xff264050),
                                  borderRadius: BorderRadius.circular(19)),
                              child: const Center(
                                child: Text(
                                  'Add To Cart',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.008,
                      ),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext a) => BuyNowOrderSummary(
                                  price: selectedproduct.product == null ||
                                      selectedproduct
                                          .product!.discountedAmount ==
                                          null
                                      ? 0
                                      : double.parse(selectedproduct
                                      .product!.price
                                      .toString()),
                                  discountAmount:
                                  selectedproduct.product == null ||
                                      selectedproduct
                                          .product!.discountedAmount ==
                                          null
                                      ? 0
                                      : double.parse(selectedproduct
                                      .product!.discountedAmount
                                      .toString()),
                                  image: selectedproduct.product == null ||
                                      selectedproduct
                                          .product!.images!.isEmpty ||
                                      selectedproduct
                                          .product!.images!.first.url ==
                                          null
                                      ? ''
                                      : selectedproduct
                                      .product!.images!.first.url
                                      .toString(),
                                  productname: selectedproduct.product ==
                                      null ||
                                      selectedproduct.product!.name == null
                                      ? ''
                                      : selectedproduct.product!.name
                                      .toString(),
                                  productId: selectedproduct.product!.variants!.first.id ??
                                      ''.toString(),
                                  quantity: int.parse(count.text.toString()),
                                )));
                          },
                          child: Container(
                            width: mwidth * 0.94,
                            height: mheight * 0.08,
                            decoration: BoxDecoration(
                                color: const Color(0xffFFC113),
                                borderRadius: BorderRadius.circular(19)),
                            child: const Center(
                              child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.03,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.052),
                        child: const Text(
                          'Product Details',
                          style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.017,
                      ),
                      Center(
                        child: SizedBox(
                          width: mwidth * 0.9,
                          child: Text(
                            selectedproduct.product != null ||
                                selectedproduct.product!.description != null
                                ? selectedproduct.product!.description.toString()
                                : ' ',
                            style: const TextStyle(
                                fontSize: 14, color: Color(0xff1D1D1B)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.017,
                      ),
                      Divider(
                        thickness: mwidth * 0.028,
                        color: const Color(0xffF3F3F3),
                      ),SizedBox(
                        height: mheight * 0.03,
                      ),Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.052),
                        child: const Text(
                          'Specifications',
                          style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.017,
                      ),Padding(
                        padding:EdgeInsets.only(left: mwidth * 0.052),
                        child:selectedproduct.product != null ||
                            selectedproduct.product!.specifications != null? Html(data: selectedproduct.product?.specifications):const SizedBox(),
                      ),SizedBox(
                        height: mheight * 0.017,
                      ),
                      Divider(
                        thickness: mwidth * 0.028,
                        color: const Color(0xffF3F3F3),
                      ),SizedBox(
                        height: mheight * 0.03,
                      ),Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.052),
                        child: const Text(
                          'Highlights',
                          style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                     Padding(
                        padding:EdgeInsets.only(left: mwidth * 0.052),
                        child:selectedproduct.product != null ||
                            selectedproduct.product?.highlights != null? Html(data: selectedproduct.product?.highlights):const SizedBox(),
                      ), SizedBox(
                        height: mheight * 0.017,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: mwidth * 0.052),
                        child: const Text(
                          'Related Product',
                          style: TextStyle(
                              color: Color(0xff181725),
                              fontSize: 17.5,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      SizedBox(
                        height: mheight * 0.027,
                      ),
                      SizedBox(
                        height: mheight * 0.265,
                        child: ListView.separated(
                            padding: EdgeInsets.only(left: mwidth * 0.052),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (ctx, index) {
                              double productPrice = double.parse(selectedproduct
                                  .relatedProducts!.isEmpty ||
                                  selectedproduct
                                      .relatedProducts![index].price ==
                                      null
                                  ? ''
                                  : selectedproduct.relatedProducts![index].price
                                  .toString());
                              double discountPrice = double.parse(selectedproduct
                                  .relatedProducts!.isEmpty ||
                                  selectedproduct
                                      .relatedProducts![index].discountedAmount ==
                                      null
                                  ? ''
                                  : selectedproduct.relatedProducts![index].discountedAmount
                                  .toString());
                              return GestureDetector(
                                onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext a) =>
                                            Selected_Product(
                                                productid: selectedproduct
                                                    .relatedProducts![index]
                                                    .id ==
                                                    null
                                                    ? ''
                                                    : selectedproduct
                                                    .relatedProducts![index].id
                                                    .toString()))),
                                child: Container(
                                    width: mwidth * 0.43,
                                    height: mheight * 0.26,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(
                                            color: const Color(0xffcccccc))),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: mheight * 0.01,
                                        ),
                                        Center(
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(10),
                                            child: selectedproduct
                                                .relatedProducts!.isEmpty ||
                                                selectedproduct
                                                    .relatedProducts![index]
                                                    .images ==
                                                    null ||
                                                selectedproduct
                                                    .relatedProducts![index]
                                                    .images!
                                                    .isEmpty ||
                                                selectedproduct
                                                    .relatedProducts![index]
                                                    .images!
                                                    .first
                                                    .url ==
                                                    null
                                                ? Image.asset(
                                              'asset/Images/placeholder.jpg',
                                              width: mwidth * 0.3,
                                              height: mheight * 0.15,
                                              fit: BoxFit.cover,
                                            )
                                                : SizedBox(
                                              width: mwidth * 0.3,
                                              height: mheight * 0.15,
                                              child: Image.network(
                                                selectedproduct
                                                        .relatedProducts![
                                                    index]
                                                        .images!
                                                        .first
                                                        .url.toString(),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                            width: mwidth * 0.4,
                                            padding: EdgeInsets.only(
                                                left: mwidth * 0.023),
                                            child: selectedproduct
                                                .relatedProducts!.isEmpty ||
                                                selectedproduct
                                                    .relatedProducts![index]
                                                    .name ==
                                                    null
                                                ? const SizedBox()
                                                : Text(
                                              selectedproduct
                                                  .relatedProducts![index]
                                                  .name
                                                  .toString(),
                                              style: const TextStyle(
                                                  color: Color(0xff1D1D1B),
                                                  fontSize: 14,
                                                  fontWeight:
                                                  FontWeight.w400),
                                              maxLines: 2,
                                            )),
                                        SizedBox(
                                          height: mheight * 0.004,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: mwidth * 0.015),
                                          child: RatingBar.builder(
                                              itemCount: 5,
                                              initialRating: 3,
                                              allowHalfRating: true,
                                              itemSize: 14,
                                              itemBuilder: (ctx, index) =>
                                              const Icon(
                                                Icons.star,
                                                color: Color(0xffF3603F),
                                              ),
                                              onRatingUpdate: (value) {
                                                print(value);
                                              }),
                                        ),
                                        SizedBox(
                                          height: mheight * 0.006,
                                        ),
                                        Padding(
                                          padding:
                                          EdgeInsets.only(left: mwidth * 0.023),
                                          child: Row(children: [
                                            productPrice == null
                                                ? const Text('')
                                                : Text(
                                              'SAR ${productPrice
                                                      .toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Color(0xff999595),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 11),
                                            ),
                                            SizedBox(
                                              width: mwidth * 0.013,
                                            ),
                                            discountPrice == null
                                                ? const Text('')
                                                : Text(
                                              'SAR ${discountPrice
                                                      .toStringAsFixed(1)}',
                                              style: const TextStyle(
                                                  color: Color(0xff999595),
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 11),
                                            ),
                                          ]),
                                        )
                                      ],
                                    )),
                              );
                            },
                            separatorBuilder: (ctx, index) {
                              return SizedBox(
                                width: mwidth * 0.023,
                              );
                            },
                            itemCount: selectedproduct.relatedProducts!.isEmpty ||
                                selectedproduct.relatedProducts == null
                                ? 0
                                : selectedproduct.relatedProducts!.length),
                      )
                    ],
                  ),
                );
              } else {
                return Container();
              }
            }),
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
}