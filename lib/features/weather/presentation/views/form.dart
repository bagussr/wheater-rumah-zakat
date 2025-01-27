// ignore_for_file: unused_field, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:searchfield/searchfield.dart';

import '../../../../core/widgets/button.dart';
import '../../domain/entity/area.dart';
import '../bloc/weather_bloc.dart';

class FormWeatherView extends StatefulWidget {
  const FormWeatherView({super.key});

  @override
  State<FormWeatherView> createState() => _FormWeatherViewState();
}

class _FormWeatherViewState extends State<FormWeatherView> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _provinceController = TextEditingController();
  TextEditingController _regencyController = TextEditingController();
  List<String> regencies = [];

  bool _submitted = false;

  void _submit() {
    setState(() {
      _submitted = true;
    });
    if (_regencyController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      final String regency =
          _regencyController.text.split(' ').skip(1).join(' ');
      setState(() {
        _submitted = false;
      });

      context.read<WeatherBloc>().add(
            WeatherCheckEvent(
                name: _nameController.text,
                province: _provinceController.text,
                regency: regency),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather Rumah Zakat'),
        backgroundColor: Colors.blue,
      ),
      body: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is WeatherError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('${state.errors}'),
              duration: Duration(seconds: 2),
            ));
          }
          if (state is WeatherCheck) {
            Navigator.pushNamed(context, '/weather');
          }
        },
        builder: (context, state) {
          if (state is WeatherLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.all(24),
            child: Stack(
              children: [
                Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    Center(
                      child: Image(
                        image: AssetImage('assets/weather_logo.png'),
                        height: 80,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Cek Cuaca terkini, di sini dan sekarang!',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 42,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            runSpacing: 32,
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: TextFormField(
                                  controller: _nameController,
                                  onChanged: (value) {
                                    if (_submitted) {
                                      setState(() {
                                        _submitted = false;
                                      });
                                    }
                                  },
                                  decoration: InputDecoration(
                                    errorText: (_submitted == true &&
                                            _nameController.text.isEmpty)
                                        ? 'Nama harus di isi'
                                        : null,
                                    labelText: 'Nama',
                                    enabledBorder: OutlineInputBorder(),
                                    focusedBorder: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(),
                                    focusedErrorBorder: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: SearchField<Area>(
                                  controller: _provinceController,
                                  onSuggestionTap: (value) {
                                    setState(() {
                                      _provinceController.text =
                                          value.item!.provinsi;
                                      regencies = state.getAreas
                                          .where((val) =>
                                              val.provinsi ==
                                              value.item!.provinsi)
                                          .first
                                          .kota;
                                    });
                                  },
                                  onTap: () {
                                    setState(() {
                                      _regencyController.text = '';
                                      regencies = [];
                                    });
                                  },
                                  searchInputDecoration: SearchInputDecoration(
                                    labelText: 'Provinsi',
                                    errorText: (_submitted == true &&
                                            _provinceController.text.isEmpty)
                                        ? 'Provinsi harus di isi'
                                        : null,
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(),
                                    focusedErrorBorder: OutlineInputBorder(),
                                  ),
                                  suggestions: state.getAreas
                                      .map(
                                        (el) => SearchFieldListItem<Area>(
                                          el.provinsi,
                                          item: el,
                                          child: Text(el.provinsi),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              SizedBox(
                                width: double.infinity,
                                child: SearchField<String>(
                                  controller: _regencyController,
                                  onSuggestionTap: (value) {
                                    setState(() {
                                      _regencyController.text = value.item!;
                                    });
                                  },
                                  searchInputDecoration: SearchInputDecoration(
                                    labelText: 'Kota / Kabupaten',
                                    errorText: (_submitted == true &&
                                            _regencyController.text.isEmpty)
                                        ? 'Kota / Kabupaten harus di isi'
                                        : null,
                                    focusedBorder: OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(),
                                    errorBorder: OutlineInputBorder(),
                                    focusedErrorBorder: OutlineInputBorder(),
                                  ),
                                  suggestions: regencies
                                      .map(
                                        (el) => SearchFieldListItem<String>(
                                          el,
                                          item: el,
                                          child: Text(el),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 48,
                    width: double.infinity,
                    child: Button(
                      onPressed: _submit,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
  }
}
