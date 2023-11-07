// ignore_for_file: unused_import, no_leading_underscores_for_local_identifiers, use_key_in_widget_constructors, no_logic_in_create_state

import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class _SharedPreferences {
  final rut = 'rut';
  final telefono = 'telefono';
  final patente = 'patente';
  final nombre = 'nombre';
  final email = 'email';

  final preferences = SharedPreferences.getInstance();
  Future<String> getRut() async {
    final sp = await preferences;
    return sp.getString(rut) ?? '';
  }

  setRut(String _rut) async {
    final sp = await preferences;
    await sp.setString(rut, _rut);
  }

  Future<int> getTelefono() async {
    final sp = await preferences;
    return sp.getInt(telefono) ?? 0;
  }

  setTelefono(int _telefono) async {
    final sp = await preferences;
    await sp.setInt(telefono, _telefono);
  }

  Future<String> getPatente() async {
    final sp = await preferences;
    return sp.getString(patente) ?? '';
  }

  setPatente(String _patente) async {
    final sp = await preferences;
    await sp.setString(patente, _patente);
  }

  Future<String> getNombre() async {
    final sp = await preferences;
    return sp.getString(nombre) ?? '';
  }

  setNombre(String _nombre) async {
    final sp = await preferences;
    await sp.setString(nombre, _nombre);
  }

  Future<String> getEmail() async {
    final sp = await preferences;
    return sp.getString(email) ?? '';
  }

  setEmail(String _email) async {
    final sp = await preferences;
    await sp.setString(email, _email);
  }
}

final sharedPref = _SharedPreferences();
