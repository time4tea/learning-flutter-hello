import 'package:flutter/foundation.dart';
import 'package:hello/api/petstore_api/lib/api.dart';
import 'package:test/test.dart';

void main() {
  test("something", () async {
    var apiClient = ApiClient(basePath: "http://localhost:1234/v3/");
    var petApi = MyPetApi(apiClient);

    var addPet = await petApi
        .addPet(Pet(name: "hello", id: 123, status: PetStatusEnum.available));

    var things = ["10", "2", "3"];

    print(things.map((e) => e.length));

    var token = AccessToken("1245");
    var t2 = AccessToken("4567");

    print(token.value);

    var s = Success("hello");
    var f = Failure("goodbyte");

    var r = f.flatMap((p) => Success("jim"));

    var ss = "string".apply((p0) => print(p0));

    print(ss);
  });
}

sealed class Result<T, E> {}

@immutable
final class Success<T> extends Result<T, Never> {
  final T value;

  Success(this.value);

  @override
  String toString() {
    return "Success(value='$value')";
  }
}

@immutable
final class Failure<E> extends Result<Never, E> {
  final E value;

  Failure(this.value);

  @override
  String toString() {
    return "Failure(value='$value')";
  }
}

extension ResultGet<T> on Result<T, T> {
  T get() {
    if (this case Success(value: var t)) {
      return t;
    } else if (this case Failure(value: var r)) {
      return r;
    }
    throw Exception("unexpected");
  }
}

extension ResultMap<T, E> on Result<T, E> {
  Result<Tdash, E> map<Tdash>(Tdash Function(T) f) =>
      flatMap((v) => Success(f(v)));

  Result<Tdash, E> flatMap<Tdash>(Result<Tdash, E> Function(T) f) {
    if (this is Failure) {
      return this as Result<Tdash, E>;
    } else if (this case Success(value: var t)) {
      return f(t);
    }
    throw Exception("unexpected");
  }

  Result<T, Edash> mapFailure<Edash>(Edash Function(E) f) =>
      flatMapFailure((reason) => Failure(f(reason)));

  Result<T, Edash> flatMapFailure<Edash>(Result<T, Edash> Function(E) f) {
    if (this is Success) {
      return this as Result<T, Edash>;
    } else if (this case Failure(value: var reason)) {
      return f(reason);
    }
    throw Exception("unexpected");
  }
}

extension ResultPeek<T, E> on Result<T, E> {}

extension Apply on Object {
  dynamic apply(void Function(dynamic) f) {
    f(this);
    return this;
  }
}

extension type AccessToken(String value) {}

class MyPetApi extends PetApi {
  MyPetApi(ApiClient apiClient) : super(apiClient);

  Future<Pet?> addPet(
    Pet pet,
  ) async {
    return null;
  }
}

abstract class Something {
  void hello();
}
