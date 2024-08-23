part of "home_bloc.dart";

class HomeState extends Equatable {
  const HomeState({
    this.message,
    this.isLoading = false,
    this.categories = const <CategoryEntity>[],
    this.banners = const <BannerEntity>[],
    this.tags = const <Tags>[],
    this.products = const <ProductEntity>[],
  });

  final String? message;
  final bool isLoading;
  final List<CategoryEntity> categories;
  final List<BannerEntity> banners;
  final List<Tags> tags;
  final List<ProductEntity> products;

  HomeState copyWith({
    String? message,
    bool? isLoading,
    List<CategoryEntity>? categories,
    List<BannerEntity>? banners,
    List<Tags>? tags,
    List<ProductEntity>? products,
  }) =>
      HomeState(
        products: products ?? this.products,
        tags: tags ?? this.tags,
        banners: banners ?? this.banners,
        categories: categories ?? this.categories,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => <Object?>[
        products,
        message,
        isLoading,
        categories,
        banners,
        tags,
      ];
}
