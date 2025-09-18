import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:ezmanagement/src/domain/enum/permission_enum.dart';
import 'package:ezmanagement/src/inject/riverpod_presentation.dart';
import 'package:ezmanagement/src/presentation/ui/custom_widgets/inputs/custom_input_text_field_widget.dart';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateRoleScreen extends ConsumerStatefulWidget {
  const CreateRoleScreen({super.key});

  @override
  ConsumerState<CreateRoleScreen> createState() => _CreateRoleScreenState();
}

class _CreateRoleScreenState extends ConsumerState<CreateRoleScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  final Map<PermissionEnum, bool> _selectedPermissions = {};

  bool _saving = false;

  @override
  void initState() {
    super.initState();
    for (PermissionEnum permission in PermissionEnum.values) {
      _selectedPermissions[permission] = false;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final scaffoldBg = isDark ? EZColorsApp.darkBackgroud : Colors.white;

    final textPrimary = isDark ? Colors.white : EZColorsApp.textDarkColor;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: CustomAppBarWidget(title: "Crear rol"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomInputTextField(
              labelTitle: "Nombre",
              hintText: "Digite el nombre",
              controller: _nameController,
            ),
            const SizedBox(height: 24),
            CustomInputTextField(
              labelTitle: "Descripcion",
              hintText: "Digite la descripcion",
              controller: _descriptionController,
            ),
            const SizedBox(height: 24),
            Text(
              'Permisos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: textPrimary,
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              decoration: BoxDecoration(
                color: EZColorsApp.ezAppColor.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.transparent),
              ),
              child: Column(
                children: [
                  ...List.generate(PermissionEnum.values.length, (index) {
                    final permission = PermissionEnum.values[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      decoration: BoxDecoration(
                        color: _selectedPermissions[permission] == true
                            ? EZColorsApp.ezAppColor.withValues(alpha: 0.15)
                            : scaffoldBg,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _selectedPermissions[permission] == true
                              ? EZColorsApp.ezAppColor
                              : EZColorsApp.lightGray,
                        ),
                      ),
                      child: CheckboxListTile(
                        title: Text(
                          permission.label,
                          style: TextStyle(fontSize: 14, color: textPrimary),
                        ),
                        value: _selectedPermissions[permission] ?? false,
                        onChanged: (bool? value) {
                          setState(() {
                            _selectedPermissions[permission] = value ?? false;
                          });
                        },
                        activeColor: EZColorsApp.ezAppColor,
                        checkColor: Colors.white,
                        controlAffinity: ListTileControlAffinity.leading,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        dense: true,
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _saveRole,
                style: ElevatedButton.styleFrom(
                  backgroundColor: EZColorsApp.ezAppColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Guardar',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveRole() async {
    // Validaciones básicas
    if (_nameController.text.trim().isEmpty) {
      _showSnackBar('Por favor, ingrese un nombre para el rol');
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showSnackBar('Por favor, ingrese una descripción para el rol');
      return;
    }

    final selectedPermissions = _selectedPermissions.entries
        .where((e) => e.value)
        .map((e) => e.key)
        .toList();

    if (selectedPermissions.isEmpty) {
      _showSnackBar('Por favor, seleccione al menos un permiso');
      return;
    }

    setState(() => _saving = true);

    try {
      // Lee el controller desde Riverpod
      final roleController = ref.read(roleControllerProvider);
      await roleController.createRole(
        roleName: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        permissions: selectedPermissions,
      );

      _showSnackBar('Rol creado exitosamente', isSuccess: true);

      // Cierra después de un momento
      await Future.delayed(const Duration(milliseconds: 800));
      if (mounted) Navigator.of(context).pop();
    } catch (_) {
      // Si luego haces que el controller retorne Either, aquí puedes leer el error real
      _showSnackBar('Error creando el rol');
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
