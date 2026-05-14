import 'package:flutter/material.dart';
import 'package:flutter_ces/services/auth_service.dart';

class AccountPage extends StatefulWidget {
  final VoidCallback onClose;

  AccountPage({required this.onClose});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final TextEditingController _DateNacController = TextEditingController();
  final TextEditingController _NombreController = TextEditingController();
  final TextEditingController _ApellidoController = TextEditingController();
  final TextEditingController _TelefonoController = TextEditingController();
  final TextEditingController _DireccionController = TextEditingController();
  final TextEditingController _PaisController = TextEditingController();

  String? _currentUserEmail;

  @override
  void initState() {
    super.initState();
    _loadCurrentUserEmail();
  }

  Future<void> _loadCurrentUserEmail() async {
    _currentUserEmail = await AuthService.getCurrentUserEmail();
    if (_currentUserEmail != null) {
      _loadUserData(_currentUserEmail!);
    }
  }

  Future<void> _loadUserData(String email) async {
    try {
      final perfil = await AuthService.getUserProfile(email);
      if (perfil != null) {
        _NombreController.text = perfil['nombre'] ?? '';
        _ApellidoController.text = perfil['apellido'] ?? '';
        _DateNacController.text = perfil['fecNac'] ?? '';
        _DireccionController.text = perfil['direccion'] ?? '';
        _PaisController.text = perfil['pais'] ?? '';
      }
    } catch (e) {
      debugPrint('Error al cargar los datos del usuario: $e');
    }
  }

  Future<void> _saveUserProfile() async {
    try {
      await AuthService.saveUserProfile(_currentUserEmail!, {
        'nombre': _NombreController.text,
        'apellido': _ApellidoController.text,
        'fecNac': _DateNacController.text,
        'direccion': _DireccionController.text,
        'pais': _PaisController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Perfil actualizado correctamente')),
      );
    } catch (e) {
      debugPrint('Error al guardar el perfil del usuario: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al actualizar el perfil')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Datos de Cuenta'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: widget.onClose,
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _NombreController,
                decoration: InputDecoration(
                    hintText: "Nombre",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.person)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _ApellidoController,
                decoration: InputDecoration(
                    hintText: "Apellido",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.person_2)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _TelefonoController,
                decoration: InputDecoration(
                    hintText: "Teléfono",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.phone)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _DateNacController,
                decoration: InputDecoration(
                    hintText: "Fecha de Nacimiento",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.calendar_month)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _DireccionController,
                decoration: InputDecoration(
                    hintText: "Dirección",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.house)),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _PaisController,
                decoration: InputDecoration(
                    hintText: "País",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(18),
                        borderSide: BorderSide.none),
                    fillColor: const Color(0xff142047).withOpacity(0.1),
                    filled: true,
                    prefixIcon: const Icon(Icons.location_pin)),
              ),
              SizedBox(height: 32.0),
              Center(
                child: ElevatedButton(
                  onPressed: _saveUserProfile,
                  child: const Text(
                    "Guardar",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 40),
                    backgroundColor: const Color(0xff142047),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
