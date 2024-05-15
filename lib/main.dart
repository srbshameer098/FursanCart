import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fursan_cart/Ui/Screens/splash_screen.dart';
import 'package:fursan_cart/bloc/AddAddress/add_address_bloc.dart';
import 'package:fursan_cart/bloc/ApplyReferal/apply_referal_bloc.dart';
import 'package:fursan_cart/bloc/Bestoffer/bestoffer_bloc.dart';
import 'package:fursan_cart/bloc/BuyNowPlaceOrder/buy_now_place_order_bloc.dart';
import 'package:fursan_cart/bloc/ChooseBrand/brand_bloc.dart';
import 'package:fursan_cart/bloc/DecreaseCartQuantity/decrease_cart_quantity_bloc.dart';
import 'package:fursan_cart/bloc/GetAllAddress/get_all_address_bloc.dart';
import 'package:fursan_cart/bloc/GetFavourates/get_favourates_bloc.dart';
import 'package:fursan_cart/bloc/GetUserDetails/get_user_details_bloc.dart';
import 'package:fursan_cart/bloc/Login/login_bloc.dart';
import 'package:fursan_cart/bloc/SelectedProduct/selected_product_bloc.dart';
import 'package:fursan_cart/bloc/Slider/slider_bloc.dart';
import 'package:fursan_cart/bloc/SubCategoryPage/sub_category_bloc.dart';
import 'package:fursan_cart/bloc/UpdatePassword/update_password_bloc.dart';
import 'package:fursan_cart/bloc/signup/signup_bloc.dart';
import 'package:fursan_cart/repository/model_class/GetAllAddress/GetAllAddressModel.dart';
import 'bloc/AddCart/add_to_cart_bloc.dart';
import 'bloc/AddFavourates/post_favourates_bloc.dart';
import 'bloc/ApplyCoupans/apply_coupans_bloc.dart';
import 'bloc/Brand/brand_selection_bloc.dart';
import 'bloc/CancelOrder/cancel_order_bloc.dart';
import 'bloc/CancelOrderReason/cancel_order_reason_bloc.dart';
import 'bloc/Category/category_bloc.dart';
import 'bloc/GetAllDeliveryType/get_all_delivery_type_bloc.dart';
import 'bloc/GetAllOrders/get_all_orders_bloc.dart';
import 'bloc/GetCart/get_cart_bloc.dart';
import 'bloc/PlaceOrder/place_order_bloc.dart';
import 'bloc/RemoveAddress/remove_address_bloc.dart';
import 'bloc/RemoveCart/remove_cart_bloc.dart';
import 'bloc/RemoveFavourate/remove_favourate_bloc.dart';
import 'bloc/SearchProduct/search_product_bloc.dart';
import 'bloc/SelectedBestOffer/selectedbestoffer_bloc.dart';
import 'bloc/SubCategorySelectedItem/subcategoryselecteditem_bloc.dart';
import 'bloc/Trendingnow/trendingnow_bloc.dart';
import 'bloc/UpdateUser/update_user_bloc.dart';
const  basePath = 'http://192.168.1.26:3010/api';
int initial=0;
GetAllAddressModel? selectedAddress;
String deliveryTypeId='';
double slabAmount=0;
double deliveryCharge=0;
String addressType='';
bool bottomNavigationCart=true;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SignupBloc()),
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => SliderBloc()),
        BlocProvider(create: (context) => BestofferBloc()),
        BlocProvider(create: (context) => BrandBloc()),
        BlocProvider(create: (context) => TrendingnowBloc(),
        ),
        BlocProvider(create: (context) => BrandSelectionBloc()),
        BlocProvider(create: (context) => SelectedProductBloc()),
        BlocProvider(create: (context) => SelectedbestofferBloc()),
        BlocProvider(create: (context)=>CategoryBloc()),
        BlocProvider(create: (context)=>SubCategoryBloc()),
        BlocProvider(create: (context)=>SubcategoryselecteditemBloc()),
        BlocProvider(create: (context)=>AddToCartBloc()),
        BlocProvider(create: (context)=>GetCartBloc()),
        BlocProvider(create: (context)=>RemoveCartBloc()),
        BlocProvider(create: (context)=>PostFavouratesBloc()),
        BlocProvider(create: (context)=>GetFavouratesBloc()),
        BlocProvider(create: (context)=>RemoveFavourateBloc()),
        BlocProvider(create:(context)=>DecreaseCartQuantityBloc()),
        BlocProvider(create: (context)=>AddAddressBloc()),
        BlocProvider(create: (context)=>GetAllAddressBloc()),
        BlocProvider(create: (context)=>PlaceOrderBloc()),
        BlocProvider(create: (context)=>BuyNowPlaceOrderBloc()),
        BlocProvider(create: (context)=>UpdateUserBloc()),
        BlocProvider(create: (context)=>GetAllOrdersBloc()),
        BlocProvider(create: (context)=>RemoveAddressBloc()),
        BlocProvider(create: (context)=>SearchProductBloc()),
        BlocProvider(create: (context)=>GetUserDetailsBloc()),
        BlocProvider(create: (context)=>UpdatePasswordBloc()),
        BlocProvider(create: (context)=>CancelOrderBloc()),
        BlocProvider(create: (context)=>ApplyCoupansBloc()),
        BlocProvider(create: (context)=>ApplyReferalBloc()),
        BlocProvider(create: (context)=>CancelOrderReasonBloc()),
        BlocProvider(create: (context)=>GetAllDeliveryTypeBloc())

      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fursan Cart',
          theme: ThemeData(

            primarySwatch: Colors.blue,
          ),
          home: const Splash_Screen()),
    );
  }
}
