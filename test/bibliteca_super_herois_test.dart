import '../lib/poderes/lib_efeitos.dart';
// import 'package:bibliteca_super_herois/poderes/lib_efeitos.dart';
// import 'package:lib_efeitos';
// import 'package:test/test.dart';


void main() async{
  var poder = Efeito();
  await poder.instanciarMetodo('Poder01', 'E004');
  print(poder.retornaObj());

  poder.alteraDuracao(2);

  print(poder.retornaObj());
}
