import 'package:api_with_bloc/Home_Screen/model/product_model.dart';
import 'package:api_with_bloc/Home_Screen/repository/product_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductRepository productRepository;
  ProductBloc({required this.productRepository}) : super(ProductInitial()) {
    on<GetProductEvent>(
        (GetProductEvent event, Emitter<ProductState> emit) async {
      print('GetProductEvent received');
      emit(ProductLoading());
      try {
        print('Fetching products from repository');
        final products = await productRepository.getProducts();
        print('Fetched ${products.length} products');
        if (products.isEmpty) {
          print('No products found, emitting ProductEmpty');
          emit(ProductEmpty());
        } else {
          print('Emitting ProductLoaded with ${products.length} products');
          emit(ProductLoaded(products: products));
        }
      } catch (e) {
        print('Error occurred: $e');
        final message = e.toString();
        emit(ProductError(errorMessage: message));
      }
    });
  }
}
