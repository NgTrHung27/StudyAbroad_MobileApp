import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kltn_mobile/blocs/schools_cubit/schools_cubit.dart';

class SchoolsListPage extends StatefulWidget {
  const SchoolsListPage({super.key, required this.country});
  final String country; // Ensure this exists

  @override
  State<SchoolsListPage> createState() => _SchoolsListPageState();
}

class _SchoolsListPageState extends State<SchoolsListPage> {
  @override
  void initState() {
    super.initState();
    context.read<SchoolsCubit>().getSchoolList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Schools List'),
      ),
      body: BlocBuilder<SchoolsCubit, SchoolsState>(
        builder: (context, state) {
          if (state is SchoolsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SchoolsLoaded) {
            return ListView.builder(
              itemCount: state.schoolList.length,
              itemBuilder: (context, index) {
                final school = state.schoolList[index];
                return ListTile(
                  title: Text(school.name),
                  subtitle: Text(school.country),
                );
              },
            );
          } else if (state is SchoolsError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const Center(child: Text('Please wait...'));
        },
      ),
    );
  }
}
