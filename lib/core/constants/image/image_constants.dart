class ImageConstants {
  ImageConstants._init();
  static ImageConstants? _instace;

  static ImageConstants get instance => _instace ??= ImageConstants._init();

  String get power => toPng("power");

  String toPng(String name) => "assets/images/$name.png";

  String get facebook => toFacebookPng("facebook");

  String toFacebookPng(String name) => "assets/icons/$name.png";

  String get apple => toApplePng("apple");

  String toApplePng(String name) => "assets/icons/$name.png";

  String get google => toGooglePng("google");

  String toGooglePng(String name) => "assets/icons/$name.png";
}
