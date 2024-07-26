import '../models/chart_data.dart';
import '../models/contact.dart';

class ContactRepository {
  List<Contact> _data = Contact.generateFakeContacts(5);

  List<ChartData> _ageChartData = [
    ChartData('1-10', 0),
    ChartData('11-20', 0),
    ChartData('21-30', 0),
    ChartData('31-40', 0),
    ChartData('other', 0)
  ];

  List<ChartData> countAgeChartData() {
    for (var contact in _data) {
      if (contact.age >= 1 && contact.age <= 10) {
        _ageChartData[0].count += 1;
      } else if (contact.age >= 11 && contact.age <= 20) {
        _ageChartData[1].count += 1;
      } else if (contact.age >= 21 && contact.age <= 30) {
        _ageChartData[2].count += 1;
      } else if (contact.age >= 31 && contact.age <= 40) {
        _ageChartData[3].count += 1;
      } else {
        _ageChartData[4].count += 1;
      }
    }
    return _ageChartData;
  }

  List<GenderData> countMales() {
    int count = 0;
    for (var contact in _data) {
      if (contact.gender == Gender.male) {
        count++;
      }
    }
    return [
      GenderData(gender: Gender.male, count: count),
      GenderData(gender: Gender.female, count: _data.length - count)
    ];
  }

  List<String?> _groups = [];
  ContactRepository() {
    _groups = getGroups();
  }
  List<String?> getGroups() {
    return _data.map((e) => e.group).toSet().toList();
  }

  List<String?> get groups => _groups;

  void addGroup(String group) {
    _groups.add(group);
  }

  List<Contact> get contacts => _data;

  void addContact(Contact contact) {
    _data.add(contact);
    if (!_groups.contains(contact.group)) {
      _groups.add(contact.group);
    }
  }

  void removeContact(String id) {
    _data.removeWhere((element) => element.id == id);
  }

  void sortByName() {
    _data.sort((a, b) => a.name.compareTo(b.name));
  }

  void sortByAge() {
    _data.sort((a, b) => a.age.compareTo(b.age));
  }

  void updateContact(String oldContactId, Contact newContact) {
    int index = _data.indexWhere((element) => element.id == oldContactId);
    if (index != -1) {
      _data[index] = newContact;
    }
  }

  List<Contact> filterByGroup(String group) {
    return _data.where((element) => element.group == group).toList();
  }

  void removeGroupOnly(String group) {
    _groups.removeWhere((element) => element == group);
    for (var contact in _data) {
      if (contact.group == group) {
        contact.group = null;
      }
    }
  }

  void removeGroupAndItsContent(String group) {
    _data.removeWhere((element) => element.group == group);
    _groups.remove(group);
  }

  void updateGroupInAllContacts(
      {required String oldGroupName, required String newGroupName}) {
    for (var element in _data) {
      if (element.group == oldGroupName) {
        element.group = newGroupName;
      }
    }
    _groups[_groups.indexOf(oldGroupName)] = newGroupName;
  }

  getContactById(String id) {
    return _data.firstWhere((element) => element.id == id);
  }

  List<Contact> searchByName(String name) {
    return _data.where((element) => element.name.contains(name)).toList();
  }
}
