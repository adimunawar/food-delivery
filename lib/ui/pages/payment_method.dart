part of 'pages.dart';

class PaymentMethodPage extends StatelessWidget {
  final String paymentUrl;
  PaymentMethodPage(this.paymentUrl);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: IlustrationPage(
        title: "finish Your Payment",
        subtitle: "Please select your favorite\n payment method",
        picturePath: 'assets/Payment.png',
        buttonTitle1: 'Payment Method',
        buttonTap1: () async {
          await launch(paymentUrl);
        },
        buttonTap2: () {
          Get.to(SuccessOrderPage());
        },
        buttonTitle2: 'Continue',
      ),
    );
  }
}
