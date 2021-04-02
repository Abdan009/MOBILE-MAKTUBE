part of 'pages.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController ulangiPasswordController = TextEditingController();
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController noHpController = TextEditingController();

  bool isLogin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        title: Text(
          'Register',
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
            FieldInputDua(namaController, 'Nama Lengkap'),
            SizedBox(
              height: 10,
            ),
            FieldInputDua(
              noHpController,
              'No Hp',
              inputFormater: [FilteringTextInputFormatter.digitsOnly],
              typeText: TextInputType.numberWithOptions(),
              maxLines: 1,
            ),
            SizedBox(
              height: 10,
            ),
            FieldInputDua(
              alamatController,
              'Alamat',
              height: 100,
            ),
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
              height: 10,
            ),
            FieldInputDua(
              ulangiPasswordController,
              'Repeat Password',
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
                            'Register',
                            style: whiteTextFont.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          onPressed: () async {
                            if (!(usernameController.text.trim() != "" &&
                                namaController.text.trim() != "" &&
                                alamatController.text.trim() != "" &&
                                noHpController.text.trim() != "" &&
                                ulangiPasswordController.text.trim() != "" &&
                                passwordController.text.trim() != "")) {
                              return flushbar(
                                  'Harap isi semua data terlebih dahulu',
                                  context);
                            } else if (ulangiPasswordController.text !=
                                passwordController.text) {
                              return flushbar(
                                  'Password yang anda ulangi tidak sesuai',
                                  context);
                            } else {
                              setState(() {
                                isLogin = true;
                              });
                              User user = User(
                                  username: usernameController.text,
                                  password: passwordController.text,
                                  nama: namaController.text,
                                  alamat: alamatController.text,
                                  noHp: noHpController.text);
                              context
                                  .read<UserCubit>()
                                  .register(user)
                                  .then((value) {
                                if (value != null) {
                                  Get.offAll(Wrapper());
                                } else {
                                  flushbar('Register Gagal', context);
                                  setState(() {
                                    isLogin = false;
                                  });
                                }
                              });
                            }
                          }),
                    )
                  : loading(4.0),
            )
          ],
        ),
      ),
    );
  }
}
