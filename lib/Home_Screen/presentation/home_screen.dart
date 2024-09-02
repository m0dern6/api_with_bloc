import 'package:api_with_bloc/Home_Screen/bloc/product_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(GetProductEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('PRODUCT SCREEN')),
        body: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
          if (state is ProductLoading) {
            const Center(child: CircularProgressIndicator());
          } else if (state is ProductLoaded) {
            return ListView.builder(
                itemCount: state.products.length,
                itemBuilder: (BuildContext context, int index) {
                  final product = state.products[index];
                  return Container(
                    height: 150.0,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 20.0),
                    decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            width: 110.0,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12.0),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        product.thumbnail.toString()),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Expanded(
                          flex: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                product.title.toString(),
                                style: const TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                product.description.toString(),
                                style: const TextStyle(fontSize: 10.0),
                              ),
                              const SizedBox(height: 4.0),
                              Text(
                                product.price.toString(),
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.green),
                              ),
                              const SizedBox(height: 2.0),
                              Expanded(
                                child: Row(
                                    children: List.generate(
                                        product.rating.round(),
                                        (int index) => const Icon(
                                              Icons.star_rate,
                                              size: 12.0,
                                              color: Colors.amber,
                                            ))),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                });
          } else if (state is ProductEmpty) {
            const Center(child: Text('No Products Found'));
          } else if (state is ProductError) {
            Center(child: Text(state.errorMessage));
          } else {
            return const SizedBox();
          }
          return const SizedBox();
        }));
  }
}
