unit List_Subscription;

interface

{$I InfraCommon.Inc}

uses
  {$IFDEF USE_GXDEBUG}DBugIntf, {$ENDIF}
  InfraCommonIntf,
  InfraCommon,
  InfraBasicList;

type
  _ITERABLELIST_BASE_ = TBaseElement;
  _ITERABLELIST_INTF_ = ISubscriptionList;
  _ITEM_INTF_ = ISubscription;
  _ITERATOR_INTF_ = IInfraIterator;
  {$I ..\Templates\InfraTempl_IntfList.inc}
  end;

  TSubscriptions = class(_ITERABLELIST_);

implementation

uses
  SysUtils;

{ TSubscriptions }

{$I ..\Templates\InfraTempl_IntfList.inc}

destructor _ITERABLELIST_.Destroy;
begin
  FreeAndNil(FItems);
  inherited;
end;

end.
