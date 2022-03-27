

// ignore_for_file: non_constant_identifier_names

import 'repository/auth_repo.dart';

class DataSource {

final AuthRepository _authRepository=AuthRepository();

 userLogIn({
  email,
  password,
}) {
  return _authRepository.userLogIn(email: email, password: password);
}

 logOut({String? auth}) => _authRepository.logOut(auth: auth);
 passwordReset({email}) => _authRepository.passwordReset(email: email);

 passwordResetConfirm(
    {uid, token, new_password1, new_password2}) => _authRepository.passwordResetConfirm(uid: uid,
      new_password1: new_password1,
      new_password2: new_password2,
      token: token);

passwordChange(
    {old_password, new_password1, new_password2}) => _authRepository.passwordChange(old_password: old_password,
      new_password2: new_password2,
      new_password1: new_password1);

 refreshToken() => _authRepository.refreshToken();

 userRegister(
    {email, username, password1, password2, birthdate, phone, gender})  => _authRepository.userRegister(email: email,
      birthdate: birthdate,
      gender: gender,
      password1: password1,
      password2: password2,
      phone: phone,
      username: username);

 getProfile()  => _authRepository.getProfile();


}
