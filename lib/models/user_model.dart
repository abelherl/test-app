import 'package:test_app/models/user.dart';

class UserList {
  List<User> user;

	UserList.fromJsonMap(Map<String, dynamic> map):
		user = List<User>.from(map["user"].map((it) => User.fromJsonMap(it)));

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['user'] = user != null ? 
			this.user.map((v) => v.toJson()).toList()
			: null;
		return data;
	}
}
