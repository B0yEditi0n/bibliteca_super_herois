class Efeito{
  String nome = '' ;
  String _nomeEfeito = '';
  String _idEfeito = '';
  int _custoBase = 0;
  int graduacao = 0;



  bool instanciarMetodo(objEfeito){
    // Preenchimento dos Atributos
    _idEfeito = objEfeito["e_id"];
    _nomeEfeito = objEfeito["efeito"];
    _custoBase = objEfeito["custo_base"];

    return true;
  }

  Map<String, dynamic> retornaObj(){
    return{
      "e_id": _idEfeito,
      "efeito": _nomeEfeito,
      "custo_base": _custoBase,
      "graduacao": graduacao,
      
    };
  }

    
}