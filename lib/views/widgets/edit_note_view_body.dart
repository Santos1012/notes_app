import 'package:flutter/material.dart';
import 'package:tharwat_notes_app/helpers/custom_edit_date_format_function.dart';
import 'package:tharwat_notes_app/helpers/fetch_all_notes_function.dart';
import 'package:tharwat_notes_app/models/note_model.dart';
import 'package:tharwat_notes_app/views/notes_home_view.dart';
import 'package:tharwat_notes_app/views/widgets/edit_color_colors_list_widget.dart';
import 'package:tharwat_notes_app/views/widgets/custom_app_bar_widget.dart';
import 'package:tharwat_notes_app/views/widgets/edit_notes_text_feilds_widget.dart';

class EditNoteViewBody extends StatefulWidget {
  final NoteModel note;

  const EditNoteViewBody({super.key, required this.note});
  @override
  State<EditNoteViewBody> createState() => _EditNoteViewBodyState();
}

class _EditNoteViewBodyState extends State<EditNoteViewBody> {
  final GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  TextEditingController titleController = TextEditingController();
  TextEditingController subTitletController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    if (titleController.text == "" && subTitletController.text == "") {
      titleController.text = widget.note.title;
      subTitletController.text = widget.note.subTitle;
    }
    return SafeArea(
      child: Form(
        key: formKey,
        autovalidateMode: autovalidateMode,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
          child: Column(
            children: [
              CustomAppBar(
                title: "Edit Note",
                icon: Icons.done_rounded,
                onTap: () {
                  cheakTextFeildValidateFunction(context);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              EditNotesTextFeilds(
                titleController: titleController,
                subTitletController: subTitletController,
              ),
              const SizedBox(
                height: 20,
              ),
              EditColorColorsListView(
              
                currentColorValue: widget.note.color,
              )
            ],
          ),
        ),
      ),
    );
  }

  void cheakTextFeildValidateFunction(BuildContext context) {
    if (formKey.currentState!.validate()) {
      setState(() {
        autovalidateMode = AutovalidateMode.disabled;
      });
      editNotesByHiveFunction(context);
      titleController.text = "";
      subTitletController.text = "";
      formKey.currentState!.save();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const NotesHomeView(),
        ),
      );
    } else {
      setState(() {
        autovalidateMode = AutovalidateMode.always;
      });
    }
  }

  void editNotesByHiveFunction(BuildContext context) {
    if (widget.note.title != titleController.text ||
        widget.note.subTitle != subTitletController.text) {
      widget.note.title = titleController.text;
      widget.note.lastEditDate =
          customEditDateFormatFunction(dateAsString: DateTime.now().toString());
      widget.note.subTitle = subTitletController.text;
      widget.note.save();
      fetchAllNotesFunction(context);
    }
  }
}
