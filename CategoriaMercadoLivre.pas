unit CategoriaMercadoLivre;

interface

uses System.Generics.Collections;

type
  TCategoriaMercadoLivre = class
    id: String;
    nome: String;
    tipo: String;
    requerido: boolean;
    items: TObjectList<TItemCategoriaMercadoLivre>;
  end;

implementation

end.
