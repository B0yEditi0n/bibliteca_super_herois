
import 'dart:developer';
import 'dart:io';
import 'dart:convert';

class Efeito{
  String nome = '' ;
  String _nomeEfeito = '';
  String _idEfeito = '';
  int _custoBase = 0;
  int graduacao = 0;

  int acao = -1;    // 0 - Nenhuma | 1 - Padrao | 2 - Movimento | 3 - Livre | 4 - Reação
  int alcance = -1; // 0 - Pessoa | 1 - Perto | 2 - A Distância | 3 - Percepção | 4 - Graduação
  int duracao = -1; // 0 - Permente | 1 - Instantanêo | 2 - Concentração | 3 - Sustentado | 4 - Contínuo 

  var padraoEfeito = {};
  
  // ###########################
  // Methodos de Inicialização #
  // ###########################
  Future<bool> instanciarMetodo(String nome , String idEfeito) async{
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

    // carrega json Base e preenche atributos do objeto
    var efeitos = await carregaJson('efeitos');
    var efeitoAtual = efeitos["EFECTS"][efeitos["EFECTS"].indexWhere((efeito) => efeito["e_id"] == idEfeito)];
    
    padraoEfeito = efeitoAtual;

    _nomeEfeito = efeitoAtual["efeito"];
    _custoBase = efeitoAtual["custo_base"];
    acao       = efeitoAtual["acao"];
    alcance    = efeitoAtual["alcance"];
    duracao    = efeitoAtual["duracao"];

    return true;
  }
  Future<bool> reinstanciarMetodo(Map objPoder) async{
    /*
      Carrega os atributos básicos do efeito 
      o algoritimo que o chamar precisa usar await
      para carregar o json

      Args:
        objPoder - Map json de para instanciar atributos
        
      Return:
        Map Json - o Arquivo json
    */

    nome = objPoder["nome"];
    _idEfeito = objPoder["e_id"];
    graduacao = objPoder["graduacao"];
    acao = objPoder["acao"];
    alcance = objPoder["alcance"];
    duracao = objPoder["duracao"];

    var efeitos = await carregaJson('efeitos');
    var efeitoAtual = efeitos["EFECTS"][efeitos["EFECTS"].indexWhere((efeito) => efeito["e_id"] == objPoder["e_id"])];

    _nomeEfeito = efeitoAtual["efeito"];

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

  // ####################################
  // # Modificações de atributos Classe #
  // ####################################
  alteraDuracao(novaDuracao){
    /* 
      o metodo apenas avaiará qual alterações mecanicamente são permitidas
      ele não calculará custo isso fica a cargo do CustearAlteracoes

      Args:
        int novaDuracao - um valor a ser definido em duração

    */ 
    var duracaoPadrao = padraoEfeito["duracao"];
    switch (duracaoPadrao) {
      
      case 1 || 2: 
        // Instantaneo ou Concentração
        if([1, 2].contains(novaDuracao)){
          duracao = novaDuracao;
        }          
        break;
      case 0 || 3 || 4:
        // Permanente Sustentado Continuo 
        if([0, 3, 4].contains(novaDuracao)){
          duracao = novaDuracao;
        }        
        break;
    }

  }
  alteraAcao(novaAcao){
    /* 
      avalia alterações de ação disponiveis do efeito

      Args:
        int novaAcao - um valor a ser definido em duração

    */ 
    var acaoPadrao = padraoEfeito["acao"];
    switch (acaoPadrao){
      case 1: 
        // Padrão
        if([1, 4].contains(novaAcao)){
          duracao = novaAcao;
        }          
        break;
      case 2:
        // Movimento
        if([1, 2].contains(novaAcao)){
          duracao = novaAcao;
        }        
        break;
      case 3:
        // Livre
        if([1, 2, 3, 4].contains(novaAcao)){
          duracao = novaAcao;
        }        
        break;
      case 4:
        // Reação
        if([1, 2, 3, 4].contains(novaAcao)){
          duracao = novaAcao;
        }        
    }
  }

  aleteraAlcance(novoAlcance){
    /* 
      avalia alterações de Alcance disponiveis do efeito

      Args:
        int novaDuracao - um valor a ser definido em duração

    */ 
    var alcancePadrao = padraoEfeito["alcance"];
    switch (alcancePadrao){
      case 0:
        // Pessoal
        if([0, 1, 2, 3].contains(novoAlcance)){
          alcance = novoAlcance;
        }
        break;
      case 1 || 2 || 3:
        // Perto, a Distânca, Percepção
        if([1, 2, 3].contains(novoAlcance)){
          alcance = novoAlcance;
        }
        break;
    }

  }

  CustearAlteracoes(){
    /*
      Processa o custo de alterações feitas em (Ação, Duração e Alcance)
        
    */
  }

  // ################################
  // # Methodos de Retorno do objto #
  // ################################

  Map<String, dynamic> retornaObj(){
    /*
      Retorna um json com os dados montados

      Return:
        Map Json - o Arquivo json
    */

    return{
      "nome":      nome,
      "e_id":      _idEfeito,
      "efeito":    _nomeEfeito,
      "graduacao": graduacao,
      "acao":      acao,
      "alcance":   alcance,
      "duracao":   duracao,
      
    };
  }

    
}