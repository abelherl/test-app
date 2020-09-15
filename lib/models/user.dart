
class User {
  int id;
  int idResto;
  String name;
  String pin;

	User(this.id, this.idResto, this.name, this.pin);

  User.fromJsonMap(Map<String, dynamic> map):
		id = map["id"],
		idResto = map["id-resto"],
		name = map["name"],
		pin = map["pin"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['id'] = id;
		data['id-resto'] = idResto;
		data['name'] = name;
		data['pin'] = pin;
		return data;
	}
}
