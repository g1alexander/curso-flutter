part of 'local_storage_cubit.dart';

class LocalStorageState extends Equatable {
  final bool isLoading;
  final bool isFavorite;

  const LocalStorageState({this.isFavorite = false, this.isLoading = false});

  LocalStorageState copyWith({bool? isLoading, bool? isFavorite}) =>
      LocalStorageState(
          isLoading: isLoading ?? this.isLoading,
          isFavorite: isFavorite ?? this.isFavorite);

  @override
  List<Object> get props => [isLoading, isFavorite];
}
