import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/domain/entities/role_entity.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/inputs/custom_dropdown_field_widget.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/inputs/custom_input_text_field_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateUserScreen extends ConsumerStatefulWidget {
  const CreateUserScreen({super.key});

  @override
  ConsumerState<CreateUserScreen> createState() => _CreateUserScreenState();
}

class _CreateUserScreenState extends ConsumerState<CreateUserScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  RoleEntity? selectedRoleEntity;
  bool _saving = false;

  late Future<List<RoleEntity>> _rolesFuture;

  @override
  void initState() {
    super.initState();
    _rolesFuture = ref.read(roleControllerProvider).getRoles();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;
    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: const CustomAppBarWidget(title: "Crear usuario"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputTextFieldWidget(
              labelTitle: "Nombre",
              hintText: "Ingrese el nombre",
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            CustomInputTextFieldWidget(
              labelTitle: "Correo",
              hintText: "Ingrese el correo",
              controller: _emailController,
              textInputType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 24),
            CustomInputTextFieldWidget(
              labelTitle: "Contraseña",
              hintText: "Ingrese la contraseña",
              controller: _passwordController,
              isPassword: true,
            ),
            const SizedBox(height: 24),
            CustomInputTextFieldWidget(
              labelTitle: "Confirmar Contraseña",
              hintText: "Ingrese la confirmación de contraseña",
              controller: _confirmPasswordController,
              isPassword: true,
            ),
            const SizedBox(height: 24),

            // Dropdown de roles conectado
            FutureBuilder<List<RoleEntity>>(
              future: _rolesFuture,
              builder: (context, snap) {
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snap.hasError) {
                  return const Text('Error cargando roles');
                }
                final roles = snap.data ?? const <RoleEntity>[];

                // Si el seleccionado ya no está en la lista, lo limpiamos
                if (selectedRoleEntity != null &&
                    !roles.any((r) => r.id == selectedRoleEntity!.id)) {
                  selectedRoleEntity = null;
                }

                return CustomDropdownWidget<RoleEntity>(
                  labelTitle: 'Rol',
                  hintText: 'Seleccione un rol',
                  items: roles,
                  value: selectedRoleEntity,
                  onChanged: (value) => setState(() {
                    selectedRoleEntity = value;
                  }),
                  displayStringForItem: (role) => role.roleName,
                  itemBuilder: (role) => Text(
                    role.roleName,
                    style: TextStyle(color: textPrimary),
                  ),
                );
              },
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saving ? null : _saveUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: EZColorsApp.ezAppColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: _saving
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text(
                        'Guardar',
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveUser() async {
    // Validaciones básicas
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Ingrese un nombre');
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      _showSnackBar('Ingrese un correo');
      return;
    }
    if (_passwordController.text.isEmpty ||
        _confirmPasswordController.text.isEmpty) {
      _showSnackBar('Complete ambas contraseñas');
      return;
    }
    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar('Las contraseñas no coinciden');
      return;
    }
    if (selectedRoleEntity == null) {
      _showSnackBar('Seleccione un rol');
      return;
    }

    setState(() => _saving = true);

    try {
      final userController = ref.read(userControllerProvider);
      await userController.createUser(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        role: selectedRoleEntity!, // rol elegido
        password: _passwordController.text,
        // sendEmailVerification: true, // opcional: usa el default de tu función
      );

      _showSnackBar('Usuario creado', isSuccess: true);
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      _showSnackBar('Error creando el usuario');
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  void _showSnackBar(String message, {bool isSuccess = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
