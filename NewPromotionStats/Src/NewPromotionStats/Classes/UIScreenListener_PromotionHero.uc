class UIScreenListener_PromotionHero extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	HandleEvent(Screen);
}

event OnReceiveFocus(UIScreen Screen)
{
	HandleEvent(Screen);
}

event OnLoseFocus(UIScreen Screen)
{
	HandleEvent(Screen);
}

event OnRemoved(UIScreen Screen)
{
	HandleEvent(Screen);
}

simulated static function HandleEvent(UIScreen Screen)
{
	if (IsStrategyAndReady())
	{
		GetOrCreateStats().OnScreenStackChanged();
	}
}

simulated static function UIHeroPromotionStats GetOrCreateStats()
{
	local UIHeroPromotionStats Stats;
	local UIAvengerHUD HUD;
	local UIPanel Panel;

	HUD = `HQPRES.m_kAvengerHUD;
	Panel = HUD.GetChildByName(class'UIHeroPromotionStats'.default.MCName, false);
	Stats = UIHeroPromotionStats(Panel);

	if (Stats == none && Panel != none)
	{
		// Dunno how this happened
		Panel.Remove();
	}

	if (Stats == none)
	{
		Stats = HUD.Spawn(class'UIHeroPromotionStats', HUD);
		Stats.InitPanel();
	}

	return Stats;
}

static function bool IsStrategyAndReady()
{
	local XComHQPresentationLayer HQPres;

	HQPres = `HQPRES;

	if (HQPres == none) return false;
	if (HQPres.m_kAvengerHUD == none) return false;
	if (!HQPres.m_kAvengerHUD.bIsInited) return false;

	return true;
}