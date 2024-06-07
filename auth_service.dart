/*import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Kullanıcı kayıt işlemi
  Future<void> signUp(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    if (response.error != null) {
      throw response.error!;
    }
  }

  // Kullanıcı giriş işlemi
  Future<String> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.error != null) {
      throw response.error!;
    }

    final userId = response.user?.id;
    if (userId == null) {
      throw UnimplementedError();
    }

    return userId;
  }

  // Kullanıcı çıkış işlemi
  Future<void> signOut() async {
    final response = await _client.auth.signOut();
    if (response.error != null) {
      throw response.error!;
    }
  }

  // Kullanıcı bilgilerini alma
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response =
        await _client.from('userlist').select().eq('user_id', userId).single();
    if (response.error != null) {
      throw response.error!;
    }
    return response.data as Map<String, dynamic>?;
  }

  // Kullanıcı profilini güncelleme
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    final response =
        await _client.from('userlist').update(updates).eq('user_id', userId);
    if (response.error != null) {
      throw response.error!;
    }
  }

  // Yeni kullanıcı ekleme
  Future<void> insertUserProfile(Map<String, dynamic> user) async {
    final response = await _client.from('userlist').insert(user);
    if (response.error != null) {
      throw response.error!;
    }
  }

  // Kullanıcı profilini silme
  Future<void> deleteUserProfile(String userId) async {
    final response =
        await _client.from('userlist').delete().eq('user_id', userId);
    if (response.error != null) {
      throw response.error!;
    }
  }
}*/
/*import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final SupabaseClient _client = Supabase.instance.client;

  // Kullanıcı kayıt işlemi
  Future<void> signUp(String email, String password) async {
    final response = await _client.auth.signUp(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
  }

  // Kullanıcı giriş işlemi
  Future<String> signIn(String email, String password) async {
    final response = await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
    if (response.user == null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }

    final userId = response.user?.id;
    if (userId == null) {
      throw UnimplementedError();
    }

    return userId;
  }

  // Kullanıcı çıkış işlemi
  Future<void> signOut() async {
    final response = await _client.auth.signOut();
    if (response.error != null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
  }

  // Kullanıcı bilgilerini alma
  Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    final response = await _client
        .from('userlist')
        .select()
        .eq('user_id', userId)
        .single()
        .execute();
    if (response.error != null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
    return response.data as Map<String, dynamic>?;
  }

  // Kullanıcı profilini güncelleme
  Future<void> updateUserProfile(
      String userId, Map<String, dynamic> updates) async {
    final response = await _client
        .from('userlist')
        .update(updates)
        .eq('user_id', userId)
        ._execute();
    if (response.error != null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
  }

  // Yeni kullanıcı ekleme
  Future<void> insertUserProfile(Map<String, dynamic> user) async {
    final response = await _client.from('userlist').insert(user).execute();
    if (response.error != null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
  }

  // Kullanıcı profilini silme
  Future<void> deleteUserProfile(String userId) async {
    final response = await _client
        .from('userlist')
        .delete()
        .eq('user_id', userId)
        .execute();
    if (response.error != null) {
      throw Exception(response.error?.message ?? 'Unknown error');
    }
  }
}

class _execute {
}*/
/*import 'package:supabase_flutter/supabase_flutter.dart';

final data = await supabase

.from('userlist')
.select()
.eq('user_id',1)
.heq('name','hairsalon');



await supabase
.from('userlist')
.insert(('name' ' hairsalon'));*/

/*import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase/supabase.dart';

class AuthService {
  final SupabaseClient client = Supabase.instance.client;

  Future<List<User>> getUsers() async {
    final response = await client.from('userList').select().execute();
    if (response.error != null) {
      throw response.error!;
    }
    return (response.data as List).map((e) => User.fromJson(e)).toList();
  }

  Future<User?> getUserById(int id) async {
    final response =
        await client.from('userList').select().eq('id', id).single().execute();
    if (response.error != null) {
      throw response.error!;
    }
    if (response.data != null) {
      return User.fromJson(response.data);
    } else {
      return null;
    }
  }

  Future<void> createUser({required String name}) async {
    final response =
        await client.from('userList').insert({'name': name}).execute();
    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> updateUser({required int id, required String name}) async {
    final response = await client
        .from('userList')
        .update({'name': name})
        .eq('id', id)
        .execute();
    if (response.error != null) {
      throw response.error!;
    }
  }

  Future<void> deleteUser(int id) async {
    final response =
        await client.from('userList').delete().eq('id', id).execute();
    if (response.error != null) {
      throw response.error!;
    }
  }
}

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
    );
  }
}*/
