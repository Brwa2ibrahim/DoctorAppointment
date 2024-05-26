class Doctor {
  Doctor(
      {this.doctorName = '',
      this.doctorSpecialty = '',
      this.doctorRating = '',
      this.doctorHospital = '',
      this.doctorNumberOfPatient = '',
      this.doctorYearOfExperince = '',
      this.doctorDescription = '',
      this.doctorPicture = '',
      this.doctorIsOpen = false});

  String doctorName;
  String doctorSpecialty;
  String doctorRating;
  String doctorHospital;
  String doctorNumberOfPatient;
  String doctorYearOfExperince;
  String doctorDescription;
  String doctorPicture;
  bool doctorIsOpen;
}

var topDoctors = [
  Doctor(
      doctorName: 'dr. lana mirza mhamad',
      doctorSpecialty: 'heart',
      doctorRating: '2',
      doctorHospital: 'Smart Hostpital',
      doctorNumberOfPatient: '233',
      doctorYearOfExperince: '5',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '2.png',
      doctorIsOpen: true),
  Doctor(
      doctorName: 'dr. mhamad ahmad',
      doctorSpecialty: 'eye',
      doctorRating: '3.3',
      doctorHospital: 'Asia Hostpital',
      doctorNumberOfPatient: '970',
      doctorYearOfExperince: '6',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '3.png',
      doctorIsOpen: false),
  Doctor(
      doctorName: 'dr. brwa ibrahim',
      doctorSpecialty: 'brine',
      doctorRating: '4.9',
      doctorHospital: 'Faruq Hostpital',
      doctorNumberOfPatient: '2500',
      doctorYearOfExperince: '9',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '4.png',
      doctorIsOpen: true),
  Doctor(
      doctorName: 'dr. sara azad anwar',
      doctorSpecialty: 'eye',
      doctorRating: '4.5',
      doctorHospital: 'Smart Hostpital',
      doctorNumberOfPatient: '506',
      doctorYearOfExperince: '3',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '4.png',
      doctorIsOpen: false),
  Doctor(
      doctorName: 'dr. mhamad azad',
      doctorSpecialty: 'heart',
      doctorRating: '4.0',
      doctorHospital: 'Asia Hostpital',
      doctorNumberOfPatient: '134',
      doctorYearOfExperince: '7',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '1.jpg',
      doctorIsOpen: true),
  Doctor(
      doctorName: 'dr. banaz mhamad',
      doctorSpecialty: 'teath',
      doctorRating: '0.0',
      doctorHospital: 'Asia Hostpital',
      doctorNumberOfPatient: '122',
      doctorYearOfExperince: '15',
      doctorDescription:
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
      doctorPicture: '4.png',
      doctorIsOpen: false),
];

class DoctorMenu {
  String name;
  String image;
  DoctorMenu({this.name = '', this.image = ''});
}

var doctorMenu = [
  DoctorMenu(name: 'Heart', image: 'heart.svg'),
  DoctorMenu(name: 'eye', image: 'eye.svg'),
  DoctorMenu(name: 'brine', image: 'brine.svg'),
  DoctorMenu(name: 'Dental', image: 'dental.svg'),
  DoctorMenu(name: 'Heart', image: 'heart.svg'),
  DoctorMenu(name: 'eye', image: 'eye.svg'),
  DoctorMenu(name: 'brine', image: 'brine.svg'),
  DoctorMenu(name: 'Dental', image: 'dental.svg'),
];
