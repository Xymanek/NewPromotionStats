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

	return self;
}

simulated function PopulateData(StateObjectReference InUnitRef)
{
	UnitRef = InUnitRef;

	StatsList.RefreshData(GetStats(), false);
	BG.SetHeight(StatsList.Y + StatsList.Height + 20);
}

simulated function array<UISummary_ItemStat> GetStats()
{
	local array<UISummary_ItemStat> Stats;
	local UISummary_ItemStat StatsEntry;
	local XComGameState_Unit Unit;

	Unit = XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));

	if (Unit == none)
	{
		Stats.Length = 0;
		return Stats;
	}

	StatsEntry.Label = class'UISoldierHeader'.default.m_strHealthLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_HP)) + Unit.GetUIStatFromAbilities(eStat_HP));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strWillLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_Will)) + Unit.GetUIStatFromAbilities(eStat_Will)) $ "/" $ string(int(Unit.GetMaxStat(eStat_Will)));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_Offense)) + Unit.GetUIStatFromAbilities(eStat_Offense));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strMobilityLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_Mobility)) + Unit.GetUIStatFromAbilities(eStat_Mobility));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strTechLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_Hacking)) + Unit.GetUIStatFromAbilities(eStat_Hacking));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strArmorLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_ArmorMitigation)) + Unit.GetUIStatFromAbilities(eStat_ArmorMitigation));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strDodgeLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_Dodge)) + Unit.GetUIStatFromAbilities(eStat_Dodge));
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strPsiLabel;
	StatsEntry.Value = string(int(Unit.GetCurrentStat(eStat_PsiOffense)) + Unit.GetUIStatFromAbilities(eStat_PsiOffense));
	Stats.AddItem(StatsEntry);

	/*StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = "4";
	Stats.AddItem(StatsEntry);*/

	return Stats;
}

simulated function AnimateIn(optional float Delay = 0)
{
	local TUIStatList_Item StatItem;

	BG.AnimateIn(Delay + class'UIUtilities'.const.INTRO_ANIMATION_TIME);
	Delay += class'UIUtilities'.const.INTRO_ANIMATION_TIME;

	Header.AnimateIn(Delay + class'UIUtilities'.const.INTRO_ANIMATION_TIME);
	Delay += class'UIUtilities'.const.INTRO_ANIMATION_TIME;

	foreach StatsList.Items(StatItem)
	{
		StatItem.BG.AnimateIn(Delay + class'UIUtilities'.const.INTRO_ANIMATION_DELAY_PER_INDEX);
		StatItem.Label.AnimateIn(Delay + class'UIUtilities'.const.INTRO_ANIMATION_DELAY_PER_INDEX);
		StatItem.Value.AnimateIn(Delay + class'UIUtilities'.const.INTRO_ANIMATION_DELAY_PER_INDEX);

		Delay += class'UIUtilities'.const.INTRO_ANIMATION_DELAY_PER_INDEX;
	}
}

defaultproperties
{
	MCName = "HeroPromotionStats"
	bAnimateOnInit = false;
}