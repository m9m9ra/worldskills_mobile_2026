import 'package:matule/layers/data/datasource/network/api_client.dart';
import 'package:matule/layers/domain/models/settings.dart';
import 'package:matule/layers/domain/provider/settings_provider.dart';
import 'package:matule/layers/domain/usecases/api_usecase.dart';
import 'package:matule_api/matule_api.dart';

class AuthUsecase {
  static final ApiUsecase _apiUsecase = ApiUsecase(apiClient);
  static final SettingsProvider _settingsProvider = SettingsProvider();

  Future<User?> isAuth() async {
    Settings _settings = await _settingsProvider.getSettings();
    if (_settings.token.isNotEmpty && _settings.userid.isNotEmpty) {
      return _apiUsecase.getUserProfile(_settings.userid);
    }
    return null;
  }

  Future<User?> verifyPinCode(List<int>? pincode) async {
    Settings settings = await _settingsProvider.getSettings();
    if (pincode == null) {
      throw Exception('Где мой блядский пин код, как ты сюда попал блять');
    }
    if (pincode.join('') == settings.code) {
      return isAuth();
    }
    return null;
  }

  Future<Settings> updatePinCode(List<int>? pincode) async {
    Settings settings = await _settingsProvider.getSettings();
    if (pincode == null) {
      settings.code = null;
      settings = await _settingsProvider.updateSettings(settings);
      return settings;
    }
    String code = pincode.join();
    settings.code = code;
    return await _settingsProvider.updateSettings(settings);
  }

  Future<ResponseRegister> register({
    required String email,
    required String password,
    required String passwordConfirm,
  }) async {
    Settings _settings = await _settingsProvider.getSettings();
    if (_settings.token.isNotEmpty && _settings.userid.isNotEmpty) {
      throw Exception('User is always auth');
    }
    ResponseRegister responseRegister = await _apiUsecase.register(
      email: email,
      password: password,
      passwordConfirm: passwordConfirm,
    );
    ResponseAuth userData = await login(email: email, password: password);
    _settings.userid = userData.record.id;
    _settings.token = userData.token;
    await _settingsProvider.updateSettings(_settings);
    return responseRegister;
  }

  Future<ResponseAuth> login({
    required String email,
    required String password,
  }) async {
    ResponseAuth responseAuth = await _apiUsecase.login(
      email: email,
      password: password,
    );
    Settings settings = await _settingsProvider.getSettings();
    settings.token = responseAuth.token;
    settings.userid = responseAuth.record.id;
    await _settingsProvider.updateSettings(settings);
    return responseAuth;
  }

  Future<void> logout() async {
    Settings settings = await _settingsProvider.getSettings();
    settings.token = '';
    settings.userid = '';
    settings.code = null;
    await _settingsProvider.updateSettings(settings);
  }
}
