class UIHeroPromotionStats extends UIPanel;

var UIPanel BG;
var UIX2PanelHeader Header;
var UIStatList StatsList;

var protectedwrite StateObjectReference UnitRef;

simulated function UIPanel InitPanel(optional name InitName, optional name InitLibID)
{
	super.InitPanel(InitName, InitLibID);

	SetX(1415);
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
	SetY(GetUnit().IsGravelyInjured() ? 150 : 620);
}

////////////
/// Data ///
////////////

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
	StatsEntry.Value = GetCurrentAndMax(eStat_HP);
	StatsEntry.ValueState = EUIState(Unit.GetStatusUIState());
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strWillLabel;
	StatsEntry.Value = GetCurrentAndMax(eStat_Will);
	StatsEntry.ValueState = Unit.GetMentalStateUIState();
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strAimLabel;
	StatsEntry.Value = GetCurrent(eStat_Offense);
	StatsEntry.ValueState = eUIState_Normal;
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strMobilityLabel;
	StatsEntry.Value = GetCurrent(eStat_Mobility);
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strTechLabel;
	StatsEntry.Value = GetCurrent(eStat_Hacking);
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strArmorLabel;
	StatsEntry.Value = GetCurrent(eStat_ArmorMitigation);
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strDodgeLabel;
	StatsEntry.Value = GetCurrent(eStat_Dodge);
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'XLocalizedData'.default.DefenseLabel;
	StatsEntry.Value = GetCurrent(eStat_Defense);
	Stats.AddItem(StatsEntry);

	StatsEntry.Label = class'UISoldierHeader'.default.m_strPsiLabel;
	StatsEntry.Value = GetCurrent(eStat_PsiOffense);
	Stats.AddItem(StatsEntry);

	return Stats;
}

simulated function string GetCurrentOnly(ECharStatType Stat)
{
	local XComGameState_Unit Unit;
	
	Unit = GetUnit();

	return string(int(Unit.GetCurrentStat(Stat)) + Unit.GetUIStatFromAbilities(Stat));
}

simulated function string GetCurrent(ECharStatType Stat)
{
	return GetCurrentOnly(Stat) $ GetEquipmentBonus(Stat);
}

simulated function string GetCurrentAndMax(ECharStatType Stat)
{
	return GetCurrentOnly(Stat) $ "/" $ string(int(GetUnit().GetMaxStat(Stat))) $ GetEquipmentBonus(Stat);
}

simulated function string GetEquipmentBonus(ECharStatType Stat)
{
	local int Bonus;

	Bonus = GetUnit().GetUIStatFromInventory(Stat);

	if (Bonus > 0)
	{
		 return class'UIUtilities_Text'.static.GetColoredText("+" $ string(Bonus), eUIState_Good);
	}

	if (Bonus < 0)
	{
		return class'UIUtilities_Text'.static.GetColoredText(string(Bonus), eUIState_Bad);
	}

	return "";
}

simulated function XComGameState_Unit GetUnit()
{
	return XComGameState_Unit(`XCOMHISTORY.GetGameStateForObjectID(UnitRef.ObjectID));
}

/////////////////
/// Animation ///
/////////////////

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