import 'package:api_with_bloc/Home_Screen/bloc/product_bloc.dart';
import 'package:api_with_bloc/Home_Screen/presentation/home_screen.dart';
import 'package:api_with_bloc/Home_Screen/repository/product_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepository(),
        child: BlocProvider(
          lazy: false,
          create: (BuildContext context) =>
              ProductBloc(productRepository: context.read<ProductRepository>()),
          child: HomeScreen(),
        ),
      ),
    );
  }
}
