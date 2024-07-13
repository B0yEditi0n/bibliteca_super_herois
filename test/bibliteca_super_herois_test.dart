import '../lib/poderes/lib_efeitos.dart';
// import 'package:bibliteca_super_herois/poderes/lib_efeitos.dart';
// import 'package:lib_efeitos';
// import 'package:test/test.dart';


void main() async{
  var poder = Efeito();
  await poder.instanciarMetodo('Poder01', 'E004');
  print(poder.retornaObj());

  poder.alteraDuracao(2);

  // Exemplo de Limitado
  poder.addModificador({
    "nome":"Limitado",
    "descricao":"Seres Vivos",
    "opcao": "",
    "fixo": false,
    "grad": 1,
    "custo": -1
  });

  // Exemplo de Peculiaridade
  poder.addModificador({
    "nome":"Peculiaridade",
    "descricao":"Perde automaticamente contra-ataques de poder",
    "opcao": "",
    "fixo": true,
    "grad": 1,
    "custo": -1
  });

  print(poder.retornaObj());
  
}
