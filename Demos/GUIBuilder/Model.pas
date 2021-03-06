unit Model;

interface

uses
  InfraValueTypeIntf, InfraValueType, InfraCommonIntf, InfraCommon, ModelIntf,
  DateUtils;

type

  TUser = class(TInfraObject, IUser)
  private
    FLogin: IInfraString;
    FPassword: IInfraString;
    function GetLogin: IInfraString;
    function GetPassword: IInfraString;
    procedure SetLogin(const Value: IInfraString);
    procedure SetPassword(const Value: IInfraString);
  public
    procedure InfraInitInstance; override;
    procedure LoadSampleData;
    property Login: IInfraString read GetLogin write SetLogin;
    property Password: IInfraString read GetPassword write SetPassword;
  end;

  TCity = class(TInfraObject, ICity)
  private
    FName: IInfraString;
    FPopulation: IInfraInteger;
    function GetName: IInfraString;
    function GetPopulation: IInfraInteger;
    procedure SetName(const Value: IInfraString);
    procedure SetPopulation(const Value: IInfraInteger);
  public
    procedure InfraInitInstance; override;
    procedure LoadSampleData;
    property Name: IInfraString read GetName write SetName;
    property Population: IInfraInteger read GetPopulation write SetPopulation;
  end;

  TPerson = class(TInfraObject, IPerson)
  private
    FID: IInfraInteger;
    FName: IInfraString;
    FEmail: IInfraString;
    FAddress: IInfraString;
    FState: IInfraString;
    FCountry: IInfraString;
    FBirthday: IInfraDateTime;
    FActive: IInfraBoolean;
    FAmount: IInfraDouble;
    FDetails: IInfraString;
    FCity: ICity;
    function GetActive: IInfraBoolean;
    function GetAddress: IInfraString;
    function GetAmount: IInfraDouble;
    function GetBirthday: IInfraDateTime;
    function GetCountry: IInfraString;
    function GetEmail: IInfraString;
    function GetID: IInfraInteger;
    function GetName: IInfraString;
    function GetState: IInfraString;
    function GetDetails: IInfraString;
    function GetCity: ICity;
    procedure SetActive(const Value: IInfraBoolean);
    procedure SetAddress(const Value: IInfraString);
    procedure SetAmount(const Value: IInfraDouble);
    procedure SetBirthday(const Value: IInfraDateTime);
    procedure SetCountry(const Value: IInfraString);
    procedure SetEmail(const Value: IInfraString);
    procedure SetID(const Value: IInfraInteger);
    procedure SetName(const Value: IInfraString);
    procedure SetState(const Value: IInfraString);
    procedure SetDetails(const Value: IInfraString);
    procedure SetCity(const Value: ICity);
  public
    procedure InfraInitInstance; override;
    procedure LoadSampleData;
    property ID: IInfraInteger read GetID write SetID;
    property Name: IInfraString read GetName write SetName;
    property Email: IInfraString read GetEmail write SetEmail;
    property Address: IInfraString read GetAddress write SetAddress;
    property State: IInfraString read GetState write SetState;
    property Country: IInfraString read GetCountry write SetCountry;
    property Birthday: IInfraDateTime read GetBirthday write SetBirthday;
    property Active: IInfraBoolean read GetActive write SetActive;
    property Amount: IInfraDouble read GetAmount write SetAmount;
    property Details: IInfraString read GetDetails write SetDetails;
    property City: ICity read GetCity write SetCity;
  end;

procedure RegisterUser;
procedure RegisterPerson;
procedure RegisterCity;

implementation

procedure RegisterUser;
var
  lUser: IClassInfo;
begin
  with TypeService do
  begin
    lUser := AddType(IUser, 'User', TUser, IInfraObject, GetType(IInfraObject));

    with lUser do
    begin
      AddConstructorInfo('Create', nil, @TUser.Create);
      AddPropertyInfo('Login', GetType(IInfraString),
        @TUser.GetLogin, @TUser.SetLogin);
      AddPropertyInfo('Password', GetType(IInfraString),
        @TUser.GetPassword, @TUser.SetPassword);
    end;
  end;
end;

procedure RegisterPerson;
var
  lPerson: IClassInfo;
begin
  with TypeService do
  begin
    lPerson := AddType(IPerson, 'Person', TPerson, IInfraObject,
      GetType(IInfraObject));

    with lPerson do
    begin
      AddConstructorInfo('Create', nil, @TPerson.Create);
      AddPropertyInfo('ID', GetType(IInfraInteger),
        @TPerson.GetID, @TPerson.SetID);
      AddPropertyInfo('Name', GetType(IInfraString),
        @TPerson.GetName, @TPerson.SetName);
      AddPropertyInfo('Email', GetType(IInfraString),
        @TPerson.GetEmail, @TPerson.SetEmail);
      AddPropertyInfo('Address', GetType(IInfraString),
        @TPerson.GetAddress, @TPerson.SetAddress);
      AddPropertyInfo('City', GetType(ICity),
        @TPerson.GetCity, @TPerson.SetCity);
      AddPropertyInfo('State', GetType(IInfraString),
        @TPerson.GetState, @TPerson.SetState);
      AddPropertyInfo('Country', GetType(IInfraString),
        @TPerson.GetCountry, @TPerson.SetCountry);
      AddPropertyInfo('Birthday', GetType(IInfraDateTime),
        @TPerson.GetBirthday, @TPerson.SetBirthday);
      AddPropertyInfo('Active', GetType(IInfraBoolean),
        @TPerson.GetActive, @TPerson.SetActive);
      AddPropertyInfo('Amount', GetType(IInfraDouble),
        @TPerson.GetAmount, @TPerson.SetAmount);
      AddPropertyInfo('Details', GetType(IInfraString),
        @TPerson.GetDetails, @TPerson.SetDetails);
    end;
  end;
end;

procedure RegisterCity;
var
  lCity: IClassInfo;
begin
  with TypeService do
  begin
    lCity := AddType(ICity, 'City', TCity, IInfraObject, GetType(IInfraObject));

    with lCity do
    begin
      AddConstructorInfo('Create', nil, @TCity.Create);
      AddPropertyInfo('Name', GetType(IInfraString),
        @TCity.GetName, @TCity.SetName);
      AddPropertyInfo('Population', GetType(IInfraInteger),
        @TCity.GetPopulation, @TCity.SetPopulation);
    end;
  end;
end;

{ TUser }

function TUser.GetLogin: IInfraString;
begin
  Result := FLogin;
end;

function TUser.GetPassword: IInfraString;
begin
  Result := FPassword;
end;

procedure TUser.InfraInitInstance;
begin
  inherited;

  FLogin := AddProperty('Login') as IInfraString;
  FPassword := AddProperty('Password') as IInfraString;
end;

procedure TUser.LoadSampleData;
begin

end;

procedure TUser.SetLogin(const Value: IInfraString);
begin
  FLogin := Value;
end;

procedure TUser.SetPassword(const Value: IInfraString);
begin
  FPassword := Value;
end;

{ TCity }

procedure TCity.InfraInitInstance;
begin
  inherited;

  FName := AddProperty('Name') as IInfraString;
  FPopulation := AddProperty('Population') as IInfraInteger;
end;

procedure TCity.LoadSampleData;
begin
  Name.AsString := 'S�o Leopoldo';
  Population.AsInteger := 200000;
end;

function TCity.GetName: IInfraString;
begin
  Result := FName;
end;

function TCity.GetPopulation: IInfraInteger;
begin
  Result := FPopulation;
end;

procedure TCity.SetName(const Value: IInfraString);
begin
  FName := Value;
end;

procedure TCity.SetPopulation(const Value: IInfraInteger);
begin
  FPopulation := Value;
end;

{ TPerson }

procedure TPerson.InfraInitInstance;
begin
  inherited;

  FID := AddProperty('ID') as IInfraInteger;
  FName := AddProperty('Name') as IInfraString;
  FEmail := AddProperty('Email') as IInfraString;
  FAddress := AddProperty('Address') as IInfraString;
  FState := AddProperty('State') as IInfraString;
  FCountry := AddProperty('Country') as IInfraString;
  FBirthday := AddProperty('Birthday') as IInfraDateTime;
  FActive := AddProperty('Active') as IInfraBoolean;
  FAmount := AddProperty('Amount') as IInfraDouble;
  FDetails := AddProperty('Details') as IInfraString;
  FCity := AddProperty('City') as ICity;
end;

procedure TPerson.LoadSampleData;
begin
  ID.AsInteger := 1;
  Name.AsString := 'Diogo Augusto Pereira';
  Email.AsString := 'diogoap82@gmail.com';
  Address.AsString := 'Rua ABC';
  State.AsString := 'RS';
  Country.AsString := 'Brasil';
  Birthday.AsDateTime := 30280;
  Active.AsBoolean := True;
  Amount.AsDouble := 10000;
  Details.AsString := 'Observa��es linha 1' + #13 +
    'Observa��es linha 2' + #13 +
    'Observa��es linha 3';
  City.LoadSampleData;  
end;

function TPerson.GetActive: IInfraBoolean;
begin
  Result := FActive;
end;

function TPerson.GetAddress: IInfraString;
begin
  Result := FAddress;
end;

function TPerson.GetAmount: IInfraDouble;
begin
  Result := FAmount;
end;

function TPerson.GetBirthday: IInfraDateTime;
begin
  Result := FBirthday;
end;

function TPerson.GetCity: ICity;
begin
  Result := FCity;
end;

function TPerson.GetCountry: IInfraString;
begin
  Result := FCountry;
end;

function TPerson.GetDetails: IInfraString;
begin
  Result := FDetails;
end;

function TPerson.GetEmail: IInfraString;
begin
  Result := FEmail;
end;

function TPerson.GetID: IInfraInteger;
begin
  Result := FID;
end;

function TPerson.GetName: IInfraString;
begin
  Result := FName;
end;

function TPerson.GetState: IInfraString;
begin
  Result := FState;
end;

procedure TPerson.SetActive(const Value: IInfraBoolean);
begin
  FActive := Value;
end;

procedure TPerson.SetAddress(const Value: IInfraString);
begin
  FAddress := Value;
end;

procedure TPerson.SetAmount(const Value: IInfraDouble);
begin
  FAmount := Value;
end;

procedure TPerson.SetBirthday(const Value: IInfraDateTime);
begin
  FBirthday := Value;
end;

procedure TPerson.SetCity(const Value: ICity);
begin
  FCity := Value;
end;

procedure TPerson.SetCountry(const Value: IInfraString);
begin
  FCountry := Value;
end;

procedure TPerson.SetDetails(const Value: IInfraString);
begin
  FDetails := Value;
end;

procedure TPerson.SetEmail(const Value: IInfraString);
begin
  FEmail := Value;
end;

procedure TPerson.SetID(const Value: IInfraInteger);
begin
  FID := Value;
end;

procedure TPerson.SetName(const Value: IInfraString);
begin
  FName := Value;
end;

procedure TPerson.SetState(const Value: IInfraString);
begin
  FState := Value;
end;

initialization
  RegisterUser;
  RegisterCity;
  RegisterPerson;

end.
