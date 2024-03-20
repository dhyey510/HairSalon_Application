class AppointmentModel{
  String id = '';
  String name = '';
  String address = '';
  String city ='';
  String state = '';
  String imageUrl = '';
  String appointmentDate = "";

  AppointmentModel({
    this.id = "",
    this.name = "",
    this.address = '',
    this.city ='',
    this.state = '',
    this.imageUrl = '',
    this.appointmentDate = ''
  });

  void updateUser(AppointmentModel model) {
    this.address = model.address;
    this.name = model.name;
    this.appointmentDate = model.appointmentDate;
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "name": name,
      "address": address,
      "city": city,
      "state": state,
      "imgUrl": imageUrl,
      "appointmentDate": appointmentDate
    };
  }

}