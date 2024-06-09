import 'dart:developer';
import 'dart:io';
import 'dart:convert';

class Efeito{
  String nome = '' ;
  String _nomeEfeito = '';
  String _idEfeito = '';
  int _custoBase = 0;
  int graduacao = 0;

  int acao = -1;
  int alcance = -1;
  int duracao = -1;
  
  Future<bool> instanciarMetodo(String nome, String idEfeito) async{
    /*
      Carrega os atributos básicos do efeito 
      o algoritimo que o chamar precisa usar await
      para carregar o json

      Args:
        nome     - nome do poder a ser dados
        idEfeito - id do efeito a ser inserido
      Return:
        Map Json - o Arquivo json
    */
    
    nome = nome;
    _idEfeito = idEfeito;

    // carrega json Base    
    var efeitos = await carregaJson('efeitos');
    var efeitoAtual = efeitos["EFECTS"][efeitos["EFECTS"].indexWhere((efeito) => efeito["e_id"] == idEfeito)];
    
    //Preenche atributos do objeto
    _custoBase = efeitoAtual["custo_base"];
    acao       = efeitoAtual["acao"];
    alcance    = efeitoAtual["alcance"];
    duracao    = efeitoAtual["duracao"];

    return true;
  }


  Future carregaJson(String json) async{
    /*
      carrega qualquer arquivo json necessário dentro do projeto

      Args:
        String json - nome do arquivo sem extensão
      Return:
        Map Json - o Arquivo json
    */

    String currentDirectory = Directory.current.path;
    var jsonEfeitos = await File('${currentDirectory}/lib/poderes/${json}.json').readAsString();
    var objetoJson = jsonDecode(jsonEfeitos);

    return(objetoJson);

  }

  Map<String, dynamic> retornaObj(){
    /*
      Retorna um json com os dados montados

      Return:
        Map Json - o Arquivo json
    */

    return{
      "e_id":      _idEfeito,
      "efeito":    _nomeEfeito,
      "graduacao": graduacao,
      "acao":      acao,
      "alcance":   alcance,
      "duracao":   duracao,
      
    };
  }

    
}