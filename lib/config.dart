class Config {
  static final Config _instance = new Config._();

  factory Config() {
    return _instance;
  }

  String _appName;
  String _host;
  int _port;
  bool _production;

  Config._();

  initConfig({String appName, String host, int port, bool production}) {
    this._appName = appName;
    this._production = production;
    this._host = host;
    this._port = port;
  }

  get appName => this._appName;

  get isProduction => this._production;

  get host => this._host;

  get port => this._port;

  get apiUrl {
    if (port != null) {
      return '$host:$port';
    }

    return host;
  }
}
