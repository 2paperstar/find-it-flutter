import 'dart:async';

import 'package:find_it/app/modules/user/domain/repositories/token_repository.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart';

@Injectable(as: TokenRepository)
class FlutterSecureStorageTokenRepository implements TokenRepository {
  final FlutterSecureStorage _storage;
  final String _tokenKey = 'token';
  final String _expiredAtKey = 'expiredAt';
  final _subject = BehaviorSubject<String?>.seeded(null);
  final _expiredAtSubject = BehaviorSubject<DateTime?>.seeded(null);

  FlutterSecureStorageTokenRepository(this._storage);

  @PostConstruct(preResolve: true)
  Future<void> init() async {
    await Future.wait([
      _storage.read(key: _tokenKey).then(_subject.add),
      _storage
          .read(key: _expiredAtKey)
          .then((v) => v == null ? null : DateTime.parse(v))
          .then(_expiredAtSubject.add),
    ]);
  }

  static FutureOr dispose(TokenRepository repository) {
    (repository as FlutterSecureStorageTokenRepository)
      .._subject.close()
      .._expiredAtSubject.close();
  }

  @override
  Stream<String?> get token => _subject.stream;

  @override
  Future<void> saveToken(String token,
      {Duration duration = const Duration(seconds: 3600)}) async {
    _subject.add(token);
    _expiredAtSubject.add(DateTime.now().add(duration));
    await _storage.write(key: _tokenKey, value: token);
    await _storage.write(
      key: _expiredAtKey,
      value: DateTime.now().add(duration).toIso8601String(),
    );
  }

  @override
  Future<void> deleteToken() async {
    _subject.add(null);
    _expiredAtSubject.add(null);
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _expiredAtKey);
  }

  @override
  DateTime? get tokenExpiration => _expiredAtSubject.value;
}
