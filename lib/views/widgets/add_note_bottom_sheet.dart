import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tharwat_notes_app/cubits/add_note_cubit/add_note_cubit.dart';
import 'package:tharwat_notes_app/views/widgets/add_note_form_sheet_body.dart';


class AddNoteBottomSheet extends StatelessWidget {
  const AddNoteBottomSheet({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddNoteCubit(),
      child: BlocConsumer<AddNoteCubit, AddNoteState>(
        listener: (context, state) {
          if (state is AddNoteFailure) {
            log("state is ${state.error}");
          }
          if (state is AddNoteSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: AddNoteForm(),
          );
        },
      ),
    );
  }
}