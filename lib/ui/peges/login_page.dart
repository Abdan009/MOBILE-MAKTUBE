part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Login',
          style: fontTitle.copyWith(fontSize: 20),
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: defaultMargin),
        child: ListView(
          children: [
            SizedBox(
              height: 20,
            ),
            FieldInputDua(usernameController, 'Username'),
            SizedBox(
              height: 10,
            ),
            FieldInputDua(
              passwordController,
              'Password',
              obsecureText: true,
              maxLines: 1,
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: (!isLogin)
                  ? Container(
                      width: Get.width / 2,
                      child: RaisedButton(
                          color: mainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(
                            'Login',
                            style: whiteTextFont.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (!(usernameController.text.trim() != "" &&
                                passwordController.text.trim() != "")) {
                              return flushbar(
                                  'Harap isi username dan password terlebih dahulu',
                                  context);
                            } else {
                              setState(() {
                                isLogin = true;
                              });
                              context
                                  .read<UserCubit>()
                                  .login(usernameController.text,
                                      passwordController.text)
                                  .then((value) {
                                if (value != null) {
                                  // Get.offAll(Wrapper());
                                } else {
                                  flushbar('Username dan password tidak valid',
                                      context);
                                  setState(() {
                                    isLogin = false;
                                  });
                                }
                              });
                            }
                          }),
                    )
                  : loading(4.0),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account ? ",
                    style: greyTextFont,
                  ),
                  GestureDetector(
                      onTap: () {
                        Get.to(RegisterPage());
                      },
                      child: Text(
                        "Register Now ",
                        style: blueTextFont,
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
