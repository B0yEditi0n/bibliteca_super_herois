import 'package:bibliteca_super_herois/bibliteca_super_herois.dart';
import 'package:bibliteca_super_herois/poderes/lib_efeitos.dart';
import 'package:test/test.dart';


void main() async{
  var poder = Efeito();
  await poder.instanciarMetodo('Poder01', 'E004');
}
