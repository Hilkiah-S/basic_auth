import 'package:email_validator/email_validator.dart';

bool Compare(item1, item2) {
  if (item1 == item2) {
    print("Inside compare");
    print("true");
    return true;
  } else {
    print("Inside compare");
    print("false");
    return false;
  }
}
