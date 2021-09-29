import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const screenRoute = '/filter_screen';

  final Function saveFilters; // check 21 => 03:00
  final Map<String, bool?> currentFilter;

  FilterScreen(this.currentFilter, this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool? _summer = false;
  bool? _winter = false;
  bool? _family = false;

  @override
  initState() {
    _summer = widget.currentFilter['summer'];
    _winter = widget.currentFilter['winter'];
    _family = widget.currentFilter['family'];
    super.initState();
  }

  Widget buildSwitchListTile(String title, String subtitle, bool currentValue,
      Function(bool)? updateValue) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: currentValue,
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('فلترة الرحلات'),
          actions: [
            IconButton(
                onPressed: () {
                  final selectedFilters = {
                    'summer': _summer,
                    'winter': _winter,
                    'family': _family,
                  };
                  widget.saveFilters(selectedFilters);
                },
                icon: Icon(Icons.save))
          ],
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: ListView(
                children: [
                  buildSwitchListTile(
                    'الرحلات الصيفية ',
                    'إظهار الرحلات في فصل الصيف فقط',
                    _summer!,
                    (newValue) {
                      setState(() {
                        _summer = newValue;
                      });
                    },
                  ),
                  buildSwitchListTile(
                    'الرحلات الشتوية ',
                    'إظهار الرحلات في فصل الشتاء فقط',
                    _winter!,
                    (newValue) {
                      setState(() => _winter = newValue);
                    },
                  ),
                  buildSwitchListTile(
                    'الرحلات العائلية ',
                    'إظهار الرحلات العائلية فقط',
                    _family!,
                    (newValue) {
                      setState(() {
                        _family = newValue;
                      });
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }
}
