unit UPathFinder;

interface

uses
  System.Types, System.Generics.Collections, System.Generics.Defaults,
  UWorld;

type
  TNode = class
  public
    Location: TPoint;
    Parent: TNode;
    Cost: Integer;
  end;

  TPathFinder = class
  public
    function FindPath(AStart: TPoint; AGoal: TPoint): TList<TPoint>;
  end;

implementation

{ TPathFinder }

function TPathFinder.FindPath(AStart, AGoal: TPoint): TList<TPoint>;
var
  OpenNodes: TList<TNode>;
  ClosedNodes: TList<TNode>;
  Nodes: TObjectList<TNode>;

  function CreateNode(AParent: TNode; ANewPoint: TPoint): TNode;
  begin
    Result := TNode.Create;

    Result.Location := TPoint.Create(ANewPoint);
    Result.Parent := AParent;

    if Assigned(Result.Parent) then
      Result.Cost := AParent.Cost + 1
    else
      Result.Cost := 0;
  end;

  function PointisUnknown(ANewPoint: TPoint): Boolean;
  var
    l_Node: TNode;
  begin
    Result := True;

    for l_Node in Nodes do
    begin
      if l_Node.Location = ANewPoint then
      begin
        Result := False;
        Exit;
      end;
    end;
  end;

  function CheckPoint(ASourceNode: TNode; ANewPoint: TPoint): Boolean;
  var
    l_Node: TNode;
  begin
    Result := False;

    for l_Node in Nodes do
    begin
      if l_Node.Location = ANewPoint then
      begin
        if l_Node.Cost > ASourceNode.Cost + 1 then
          l_Node.Parent := ASourceNode;

        Result := True;
        Exit;
      end;
    end;
  end;

  procedure ExploreNode(ASourceNode: TNode; ANewPoint: TPoint);
  var
    NewNode: TNode;
  begin
    if TheWorld.TerrainTiles[ANewPoint.X][ANewPoint.Y].CanPassBySea then
    begin
      if NOT CheckPoint(ASourceNode, ANewPoint) then
      begin
        NewNode := CreateNode(ASourceNode, ANewPoint);
        Nodes.Add(NewNode);
        OpenNodes.Add(NewNode);
        OpenNodes.Sort;
      end;
    end;
  end;

  procedure ExploreNodes(ASourceNode: TNode);
  begin
    if ASourceNode.Location.X > 0 then
      ExploreNode(ASourceNode, ASourceNode.Location.Add(TPoint.Create(-1, 0)));

    if ASourceNode.Location.Y > 0 then
      ExploreNode(ASourceNode, ASourceNode.Location.Add(TPoint.Create(0, -1)));

    if ASourceNode.Location.X < TheWorld.SizeX -1 then
      ExploreNode(ASourceNode, ASourceNode.Location.Add(TPoint.Create(1, 0)));

    if ASourceNode.Location.Y < TheWorld.SizeY -1 then
      ExploreNode(ASourceNode, ASourceNode.Location.Add(TPoint.Create(0, 1)));
  end;
var
  CurrentNode: TNode;
  Comparer: IComparer<TNode>;
begin
  Result := TList<TPoint>.Create;

  Comparer := TDelegatedComparer<TNode>.Create(
    function(const Left, Right: TNode): Integer
    begin
      Result := Left.Cost - Right.Cost;
    end);

  Nodes := TObjectList<TNode>.Create;
  OpenNodes := TList<TNode>.Create(Comparer);
  ClosedNodes := TList<TNode>.Create;
  try
    Nodes.OwnsObjects := True;

    CurrentNode := CreateNode(NIL,AStart);

    Nodes.Add(CurrentNode);
    OpenNodes.Add(CurrentNode);

    while OpenNodes.Count > 0 do
    begin
      CurrentNode := OpenNodes.First;

      ClosedNodes.Add(CurrentNode);
      OpenNodes.Remove(CurrentNode);

      if CurrentNode.Location = AGoal then
        Break;

      ExploreNodes(CurrentNode);
    end;

    if CurrentNode.Location = AGoal then
    begin
      while Assigned(CurrentNode.Parent) do
      begin
        Result.Add(CurrentNode.Location);
        CurrentNode := CurrentNode.Parent;
      end;
    end;

  finally
    ClosedNodes.Free;
    OpenNodes.Free;
    Nodes.Free;
  end;
end;

end.
