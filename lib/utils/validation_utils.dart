class ValidationUtils {
  static bool isUrl(String? url) {
    if (url == null || url.isEmpty) {
      return false;
    }

    // Regular expression to check if the string is a valid URL
    final RegExp urlRegExp = RegExp(
      r'^(?:http|https):\/\/'
      r'(?:www\.)?'
      r'(?:[\w]+\.){1,}'
      r'[a-zA-Z]{2,}(?:\/[^\s]*)?$',
    );

    return urlRegExp.hasMatch(url);
  }
}
