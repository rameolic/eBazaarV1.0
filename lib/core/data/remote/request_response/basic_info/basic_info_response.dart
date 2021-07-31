class BasicInfoResponse {
  List<BasicInfo> basicInfo;

  BasicInfoResponse({this.basicInfo});

  BasicInfoResponse.fromJson(List<dynamic> jsonArray) {
    basicInfo = jsonArray.map((item) => BasicInfo.fromJson(item)).toList();
  }
}

class BasicInfo {
  int _id;
  String _code;
  int _websiteId;
  String _locale;
  String _baseCurrencyCode;
  String _defaultDisplayCurrencyCode;
  String _timezone;
  String _weightUnit;
  String _baseUrl;
  String _baseLinkUrl;
  String _baseStaticUrl;
  String _baseMediaUrl;
  String _secureBaseUrl;
  String _secureBaseLinkUrl;
  String _secureBaseStaticUrl;
  String _secureBaseMediaUrl;

  BasicInfo(
      {int id,
        String code,
        int websiteId,
        String locale,
        String baseCurrencyCode,
        String defaultDisplayCurrencyCode,
        String timezone,
        String weightUnit,
        String baseUrl,
        String baseLinkUrl,
        String baseStaticUrl,
        String baseMediaUrl,
        String secureBaseUrl,
        String secureBaseLinkUrl,
        String secureBaseStaticUrl,
        String secureBaseMediaUrl}) {
    this._id = id;
    this._code = code;
    this._websiteId = websiteId;
    this._locale = locale;
    this._baseCurrencyCode = baseCurrencyCode;
    this._defaultDisplayCurrencyCode = defaultDisplayCurrencyCode;
    this._timezone = timezone;
    this._weightUnit = weightUnit;
    this._baseUrl = baseUrl;
    this._baseLinkUrl = baseLinkUrl;
    this._baseStaticUrl = baseStaticUrl;
    this._baseMediaUrl = baseMediaUrl;
    this._secureBaseUrl = secureBaseUrl;
    this._secureBaseLinkUrl = secureBaseLinkUrl;
    this._secureBaseStaticUrl = secureBaseStaticUrl;
    this._secureBaseMediaUrl = secureBaseMediaUrl;
  }

  int get id => _id;
  set id(int id) => _id = id;
  String get code => _code;
  set code(String code) => _code = code;
  int get websiteId => _websiteId;
  set websiteId(int websiteId) => _websiteId = websiteId;
  String get locale => _locale;
  set locale(String locale) => _locale = locale;
  String get baseCurrencyCode => _baseCurrencyCode;
  set baseCurrencyCode(String baseCurrencyCode) =>
      _baseCurrencyCode = baseCurrencyCode;
  String get defaultDisplayCurrencyCode => _defaultDisplayCurrencyCode;
  set defaultDisplayCurrencyCode(String defaultDisplayCurrencyCode) =>
      _defaultDisplayCurrencyCode = defaultDisplayCurrencyCode;
  String get timezone => _timezone;
  set timezone(String timezone) => _timezone = timezone;
  String get weightUnit => _weightUnit;
  set weightUnit(String weightUnit) => _weightUnit = weightUnit;
  String get baseUrl => _baseUrl;
  set baseUrl(String baseUrl) => _baseUrl = baseUrl;
  String get baseLinkUrl => _baseLinkUrl;
  set baseLinkUrl(String baseLinkUrl) => _baseLinkUrl = baseLinkUrl;
  String get baseStaticUrl => _baseStaticUrl;
  set baseStaticUrl(String baseStaticUrl) => _baseStaticUrl = baseStaticUrl;
  String get baseMediaUrl => _baseMediaUrl;
  set baseMediaUrl(String baseMediaUrl) => _baseMediaUrl = baseMediaUrl;
  String get secureBaseUrl => _secureBaseUrl;
  set secureBaseUrl(String secureBaseUrl) => _secureBaseUrl = secureBaseUrl;
  String get secureBaseLinkUrl => _secureBaseLinkUrl;
  set secureBaseLinkUrl(String secureBaseLinkUrl) =>
      _secureBaseLinkUrl = secureBaseLinkUrl;
  String get secureBaseStaticUrl => _secureBaseStaticUrl;
  set secureBaseStaticUrl(String secureBaseStaticUrl) =>
      _secureBaseStaticUrl = secureBaseStaticUrl;
  String get secureBaseMediaUrl => _secureBaseMediaUrl;
  set secureBaseMediaUrl(String secureBaseMediaUrl) =>
      _secureBaseMediaUrl = secureBaseMediaUrl;

  BasicInfo.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _code = json['code'];
    _websiteId = json['website_id'];
    _locale = json['locale'];
    _baseCurrencyCode = json['base_currency_code'];
    _defaultDisplayCurrencyCode = json['default_display_currency_code'];
    _timezone = json['timezone'];
    _weightUnit = json['weight_unit'];
    _baseUrl = json['base_url'];
    _baseLinkUrl = json['base_link_url'];
    _baseStaticUrl = json['base_static_url'];
    _baseMediaUrl = json['base_media_url'];
    _secureBaseUrl = json['secure_base_url'];
    _secureBaseLinkUrl = json['secure_base_link_url'];
    _secureBaseStaticUrl = json['secure_base_static_url'];
    _secureBaseMediaUrl = json['secure_base_media_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['code'] = this._code;
    data['website_id'] = this._websiteId;
    data['locale'] = this._locale;
    data['base_currency_code'] = this._baseCurrencyCode;
    data['default_display_currency_code'] = this._defaultDisplayCurrencyCode;
    data['timezone'] = this._timezone;
    data['weight_unit'] = this._weightUnit;
    data['base_url'] = this._baseUrl;
    data['base_link_url'] = this._baseLinkUrl;
    data['base_static_url'] = this._baseStaticUrl;
    data['base_media_url'] = this._baseMediaUrl;
    data['secure_base_url'] = this._secureBaseUrl;
    data['secure_base_link_url'] = this._secureBaseLinkUrl;
    data['secure_base_static_url'] = this._secureBaseStaticUrl;
    data['secure_base_media_url'] = this._secureBaseMediaUrl;
    return data;
  }
}
