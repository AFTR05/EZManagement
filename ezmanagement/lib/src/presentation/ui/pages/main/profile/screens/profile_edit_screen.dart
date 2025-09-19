import 'dart:io';
import 'package:ezmanagement/src/presentation/ui/pages/custom_widgets/app_bar/custom_app_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ezmanagement/src/core/helpers/ez_colors_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:ezmanagement/translations/locale_keys.g.dart';

/// Pantalla para editar el perfil del usuario.
///
/// Permite modificar nombre, teléfono, email, fecha de cumpleaños y foto de perfil.
///
/// Usa Riverpod para estado y maneja selección de imágenes con ImagePicker.
class ProfileEditScreen extends ConsumerStatefulWidget {
  /// Constructor de ProfileEditScreen.
  const ProfileEditScreen({super.key});

  @override
  ConsumerState<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends ConsumerState<ProfileEditScreen> {
  /// Clave global para el formulario de validación.
  final _formKey = GlobalKey<FormState>();

  /// Campos con valores iniciales del formulario.
  String name = "Maria Celeste Cardona";
  String phone = "+57 320 7406333";
  String email = "mariacel@ezsolutions";
  DateTime? birthday = DateTime(2004, 12, 14);

  /// Almacena la imagen seleccionada por el usuario.
  XFile? profileImage;
  final ImagePicker _picker = ImagePicker();

  /// Función para seleccionar una imagen desde la galería.
  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() => profileImage = pickedFile);
      if (mounted) Navigator.of(context).pop();
    }
  }

  /// Muestra el modal para elegir actualizar la foto de perfil.
  void _showImagePickerModal() {
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => _ModalContent(
        onPickImage: _pickImage,
        mainBlue: EZColorsApp.ezAppColor,
        isDarkmode: isDarkmode,
      ),
      isScrollControlled: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Detecta si el tema actual es oscuro.
    final isDarkmode = Theme.of(context).brightness == Brightness.dark;

    // Muestra imagen de perfil si existe una seleccionada, si no imagen por defecto.
    final profileImageWidget = profileImage != null
        ? CircleAvatar(
            radius: 50,
            backgroundImage: FileImage(File(profileImage!.path)),
            backgroundColor: EZColorsApp.ezAppColor.withAlpha(20),
          )
        : CircleAvatar(
            radius: 50,
            backgroundImage: const AssetImage('assets/images/profile.jpg'),
            backgroundColor: EZColorsApp.ezAppColor.withAlpha(20),
          );

    return Scaffold(
      backgroundColor: isDarkmode ? EZColorsApp.darkBackgroud : Colors.white,
      appBar: CustomAppBarWidget(title: LocaleKeys.profileLabel.tr()),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 8),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Stack(
                  children: [
                    // Foto de perfil con opción para editar imagen
                    profileImageWidget,
                    Positioned(
                      bottom: 0,
                      right: 3,
                      child: GestureDetector(
                        onTap: _showImagePickerModal,
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: EZColorsApp.ezAppColor,
                          child: const Icon(
                            PhosphorIconsBold.pencilSimple,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Label y campo de entrada para nombre completo
              buildLabel(LocaleKeys.profileEditFullNameLabel.tr(),
                  isDarkmode ? Colors.white : Colors.black87),
              buildInput(
                initialValue: name,
                inputBg: EZColorsApp.ezAppColor.withAlpha(20),
                textColor: isDarkmode ? Colors.white : Colors.black87,
                onChanged: (val) => name = val,
              ),
              // Label y campo de entrada para teléfono
              buildLabel(LocaleKeys.profileEditPhoneLabel.tr(),
                  isDarkmode ? Colors.white : Colors.black87),
              buildInput(
                initialValue: phone,
                inputBg: EZColorsApp.ezAppColor.withAlpha(20),
                textColor: isDarkmode ? Colors.white : Colors.black87,
                keyboardType: TextInputType.phone,
                onChanged: (val) => phone = val,
              ),
              // Label y campo de entrada para correo electrónico
              buildLabel(LocaleKeys.profileEditEmailLabel.tr(),
                  isDarkmode ? Colors.white : Colors.black87),
              buildInput(
                initialValue: email,
                inputBg: EZColorsApp.ezAppColor.withAlpha(20),
                textColor: isDarkmode ? Colors.white : Colors.black87,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) => email = val,
              ),
              // Label y selector de fecha para cumpleaños
              buildLabel(LocaleKeys.profileEditBirthdayLabel.tr(),
                  isDarkmode ? Colors.white : Colors.black87),
              buildDateInput(
                context,
                EZColorsApp.ezAppColor.withAlpha(20),
                isDarkmode ? Colors.white : Colors.black87,
              ),
              const SizedBox(height: 30),

              // Botón para guardar cambios
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: EZColorsApp.ezAppColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.symmetric(vertical: 13),
                  ),
                  child: Text(
                    LocaleKeys.profileEditUpdateButton.tr(),
                    style: const TextStyle(
                      fontFamily: 'OpenSansHebrew',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  onPressed: () {
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content:
                              Text(LocaleKeys.profileEditUpdatedSnack.tr())),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Construye un widget etiqueta para los campos de formulario.
  Widget buildLabel(String label, Color textColor) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 6),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: 'OpenSansHebrew',
            fontWeight: FontWeight.w500,
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
    );
  }

  /// Construye un widget campo de texto para formularios.
  Widget buildInput({
    required String initialValue,
    required Color inputBg,
    required Color textColor,
    TextInputType? keyboardType,
    required ValueChanged<String> onChanged,
  }) {
    return TextFormField(
      initialValue: initialValue,
      keyboardType: keyboardType,
      onChanged: onChanged,
      style: TextStyle(
          fontFamily: 'OpenSansHebrew', fontSize: 15, color: textColor),
      decoration: InputDecoration(
        filled: true,
        fillColor: inputBg,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
      ),
    );
  }

  /// Construye un widget selector de fecha para cumpleaños.
  ///
  /// Al tocar abre un [showDatePicker] con tema personalizado según modo claro u oscuro.
  Widget buildDateInput(BuildContext context, Color inputBg, Color textColor) {
    return GestureDetector(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: birthday ?? DateTime(2000),
          firstDate: DateTime(1900),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (context, child) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            final mainBlue = EZColorsApp.ezAppColor;

            final calendarTheme = ThemeData(
              colorScheme: ColorScheme(
                brightness: isDark ? Brightness.dark : Brightness.light,
                primary: mainBlue,
                onPrimary: Colors.white,
                secondary: mainBlue,
                onSecondary: Colors.white,
                error: Colors.red,
                onError: Colors.white,
                surface: isDark ? EZColorsApp.darkGray : Colors.white,
                onSurface: isDark ? Colors.white : const Color(0xFF242425),
              ),
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF242425),
                  fontFamily: 'OpenSansHebrew',
                  fontWeight: FontWeight.w700,
                ),
                bodyMedium: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF242425),
                  fontFamily: 'OpenSansHebrew',
                ),
              ),
              iconTheme: IconThemeData(color: mainBlue),
              highlightColor: mainBlue,
              scaffoldBackgroundColor: isDark ? EZColorsApp.darkGray : Colors.white,
              dialogTheme: DialogThemeData(backgroundColor: isDark ? EZColorsApp.darkGray : Colors.white),
            );

            return Theme(
              data: calendarTheme,
              child: child!,
            );
          },
        );
        if (picked != null) setState(() => birthday = picked);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: inputBg,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.centerLeft,
        child: Text(
          birthday != null
              ? '${birthday!.day.toString().padLeft(2, '0')} / ${birthday!.month.toString().padLeft(2, '0')} / ${birthday!.year}'
              : LocaleKeys.profileEditSelectDate.tr(), // "Seleccionar fecha"
          style: TextStyle(
            fontFamily: 'OpenSansHebrew',
            fontSize: 15,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

/// Contenido del modal para seleccionar o cancelar actualización de foto.
///
/// Contiene botones para elegir imagen desde galería o cancelar.
class _ModalContent extends StatelessWidget {
  /// Callback que se ejecuta al seleccionar imagen.
  final VoidCallback onPickImage;

  /// Color principal azul.
  final Color mainBlue;

  /// Indica si el tema es oscuro.
  final bool isDarkmode;

  /// Constructor para el modal.
  const _ModalContent({
    required this.onPickImage,
    required this.mainBlue,
    required this.isDarkmode,
  });

  @override
  Widget build(BuildContext context) {
    final modalBg = isDarkmode ? const Color(0xFF252525) : Colors.white;
    final textColor = isDarkmode ? Colors.white : Colors.black87;

    return Container(
      decoration: BoxDecoration(
        color: modalBg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      height: 160,
      child: Column(
        children: [
          // Título del modal
          Text(
            LocaleKeys.profileEditUpdatePhotoTitle.tr(), // "Actualizar foto de perfil"
            style: TextStyle(
              fontFamily: 'OpenSansHebrew',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: mainBlue,
            ),
          ),
          const SizedBox(height: 20),
          // Botón para seleccionar imagen desde galería
          ElevatedButton.icon(
            icon: const Icon(Icons.photo_library),
            label: Text(
              LocaleKeys.profileEditSelectImageButton.tr(), // "Seleccionar imagen"
              style: const TextStyle(fontFamily: 'OpenSansHebrew', color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: mainBlue),
            onPressed: onPickImage,
          ),
          const SizedBox(height: 10),
          // Botón para cancelar modal
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: isDarkmode ? Colors.grey[700] : Colors.grey,
            ),
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              LocaleKeys.profileEditCancelButton.tr(), // "Cancelar"
              style: TextStyle(fontFamily: 'OpenSansHebrew', color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}