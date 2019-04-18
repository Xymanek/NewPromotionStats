class UIHeroPromotionStats extends UIPanel;

var UIPanel BG;
var UIX2PanelHeader Header;
var UIStatList StatsList;

var protectedwrite StateObjectReference UnitRef;

simulated function UIPanel InitPanel(optional name InitName, optional name InitLibID)
{
	super.InitPanel(InitName, InitLibID);

	SetPosition(1415, 620);
	SetWidth(240);

	BG = Spawn(class'UIPanel', self);
	BG.InitPanel('BG', class'UIUtilities_Controls'.const.MC_X2Background);
	BG.SetWidth(Width);

	Header = Spawn(class'UIX2PanelHeader', self);
	Header.InitPanelHeader('Header', "Stats");
	Header.SetHeaderWidth(Width - 20);
	Header.SetPosition(10, 10);

	StatsList = Spawn(class'UIStatList', self);
	StatsList.InitStatList('StatsList');
	StatsList.Width = Width;
	StatsList.PADDING_LEFT = 10;
	StatsList.PADDING_RIGHT = 10;
	StatsList.SetY(50);

	StatsList.RefreshData(GetStats(), false);
	BG.SetHeight(StatsList.Y + StatsList.Height + 20);

	return self;
}

simulated function array<UISummary_ItemStat> GetStats()
{
	local array<UISummary_ItemStat> Stats;
	local UISummary_ItemStat StatsEntry;

	StatsEntry.Label = "Something";
	StatsEntry.Value = "1";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = "Something2";
	StatsEntry.Value = "2";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = "Something3";
	StatsEntry.Value = "3";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = "Somethin4";
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);

	return Stats;
}

simulated function PopulateData(StateObjectReference InUnitRef)
{
	UnitRef = InUnitRef;
}

defaultproperties
{
	MCName = "HeroPromotionStats"
	bAnimateOnInit = false;
}