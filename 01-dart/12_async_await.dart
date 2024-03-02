void main() async {
  print('Inicio del programa');

  final value = await httpGet('https://fernando-herrera.com/cursos');
  print(value);

  print('Fin del programa');
}

Future<String> httpGet(String url) async {
  try {
    await Future.delayed(const Duration(seconds: 1));

    return 'Tenemos un valor de la petición';
  } catch (err) {
    throw 'Tenemos un error: Error en la petición';
  }
}
