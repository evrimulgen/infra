unit InfraParseParamsTests;

interface

uses
  SysUtils,
  Classes,
  InfraOPFIntf,
  TestFramework;

type
  TTestSQLParamsParser = class(TTestCase)
  private
    FParser: ISQLParamsParser;
  protected
    procedure SetUp; override;
    procedure TearDown; override;
  published
    procedure TestParserSelect;
    procedure TestParserInsert;
    procedure TestParserUpdate;
    procedure TestParserDelete;
    procedure TestParserParamsRepeated;
    procedure TestParserParamNoName;
    procedure TestParserMacroNoName;
    procedure TestParserMacrosAndParams;
    procedure TestParserMacrosAndParamsAndComments;
    procedure TestParserResult1;
    procedure TestParserResult2;
  end;

implementation

uses
  InfraOPFParsers;

{ TTestParseParams }

procedure TTestSQLParamsParser.SetUp;
begin
  inherited;
  FParser := TSQLParamsParser.Create;
end;

procedure TTestSQLParamsParser.TearDown;
begin
  FParser := nil;
  inherited;
end;

procedure TTestSQLParamsParser.TestParserInsert;
const
  cSql = 'insert into tabela'#13#10+
    '(codigo, nome)'#13#10+
    'values (:codigo, :nome)';
var
  vParams: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(2, vParams.Count);
  CheckEqualsString('codigo', vParams[0]);
  CheckEqualsString('nome', vParams[1]);
end;

procedure TTestSQLParamsParser.TestParserSelect;
const
  cSql = 'select *'#13#10+
    'from tabela'#13#10+
    'where codigo = :codigo'#13#10+
    ' and nome = :nome';
var
  vParams: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(2, vParams.Count);
  CheckEqualsString('codigo', vParams[0]);
  CheckEqualsString('nome', vParams[1]);
end;

procedure TTestSQLParamsParser.TestParserUpdate;
const
  cSql = 'update tabela set'#13#10+
    'codigo = :codigo, '#13#10+
    'nome = :nome'#13#10+
    'where id = :id';
var
  vParams: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(3, vParams.Count);
  CheckEqualsString('codigo', vParams[0]);
  CheckEqualsString('nome', vParams[1]);
  CheckEqualsString('id', vParams[2]);
end;

procedure TTestSQLParamsParser.TestParserDelete;
const
  cSql = 'delete from tabela'#13#10+
    'where codigo=:codigo'#13#10+
    ' and nome=:nome'#13#10+
    ' and id=:id';
var
  vParams: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(3, vParams.Count);
  CheckEqualsString('codigo', vParams[0]);
  CheckEqualsString('nome', vParams[1]);
  CheckEqualsString('id', vParams[2]);
end;

procedure TTestSQLParamsParser.TestParserParamsRepeated;
const
  cSql = 'update tabela set id = :id, codigo = :codigo, nome = :nome where id = :id';
var
  vParams: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(4, vParams.Count);
  CheckEqualsString('id', vParams[0]);
  CheckEqualsString('codigo', vParams[1]);
  CheckEqualsString('nome', vParams[2]);
  CheckEqualsString('id', vParams[3]);
end;

procedure TTestSQLParamsParser.TestParserParamNoName;
const
  cSql = 'update tabela set id = :id, codigo = :codigo, nome = :nome where id = :';
begin
  ExpectedException := EPersistenceParserError;
  FParser.Parse(cSql);
  ExpectedException := nil;
end;

procedure TTestSQLParamsParser.TestParserMacrosAndParams;
const
  cSql = 'select #macro1 from #macro2 where id = :id or codigo = :codigo or campo3 = ::campo3 order by #macro3 ##macro4';
var
  vParams: TStrings;
  vMacros: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(2, vParams.Count);
  CheckEqualsString('id', vParams[0]);
  CheckEqualsString('codigo', vParams[1]);

  vMacros := FParser.GetMacroParams;
  CheckEquals(3, vMacros.Count);
  CheckEqualsString('macro1', vMacros[0]);
  CheckEqualsString('macro2', vMacros[1]);
  CheckEqualsString('macro3', vMacros[2]);
end;

procedure TTestSQLParamsParser.TestParserMacroNoName;
const
  cSql = 'update # set codigo = :codigo, nome = :nome where id = :id';
begin
  ExpectedException := EPersistenceParserError;
  FParser.Parse(cSql);
  ExpectedException := nil;
end;

procedure TTestSQLParamsParser.TestParserMacrosAndParamsAndComments;
const
  cSql = '/* comentario multi-linha '#13#10+
    ' linha 2 do comentario #macro_ignorada1'#13#10+
    ' linha 3 do comentario :codigo'#13#10+
    '*/#inst1 select #macro1 --teste de comentario :codigo'#13#10+
    'from #macro2 /* outro comentario multi-linha '#13#10+
    ' linha 2 do comentario '#13#10+
    ' linha 3 do comentario #macro_ignorada2'#13#10+
    '*/'#13#10+
    'where id = :id '#13#10+
    '  or codigo=:codigo '#13#10+
    '  or campo3 = ::campo3 '#13#10+
    '#inst2 order by #macro3 ##macro4';
var
  vParams: TStrings;
  vMacros: TStrings;
begin
  FParser.Parse(cSql);
  vParams := FParser.GetParams;
  CheckEquals(2, vParams.Count);
  CheckEqualsString('id', vParams[0]);
  CheckEqualsString('codigo', vParams[1]);

  vMacros := FParser.GetMacroParams;
  CheckEquals(5, vMacros.Count);
  CheckEqualsString('inst1', vMacros[0]);
  CheckEqualsString('macro1', vMacros[1]);
  CheckEqualsString('macro2', vMacros[2]);
  CheckEqualsString('inst2', vMacros[3]);
  CheckEqualsString('macro3', vMacros[4]);
end;

procedure TTestSQLParamsParser.TestParserResult1;
const
  cSql = 'insert into tabela'#13#10+
    '(codigo, nome)'#13#10+
    'values (:codigo, :nome)';
  cExpected = 'insert into tabela'#13#10+
    '(codigo, nome)'#13#10+
    'values (?, ?)';
var
  vSql: string;
begin
  vSql := FParser.Parse(cSql);
  CheckEqualsString(cExpected, vSql);
end;

procedure TTestSQLParamsParser.TestParserResult2;
const
  cSql = 'select * '#13#10+
    'from tabela'#13#10+
    'where codigo=:codigo'#13#10;
  cExpected = 'select * '#13#10+
    'from tabela'#13#10+
    'where codigo=?'#13#10;
var
  vSql: string;
begin
  vSql := FParser.Parse(cSql);
  CheckEqualsString(cExpected, vSql);
end;

initialization
  TestFramework.RegisterTest('Persistence Testes Caixa-Cinza',
    TTestSQLParamsParser.Suite);

end.


