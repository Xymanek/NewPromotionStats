class UIScreenListener_PromotionHero extends UIScreenListener;

event OnInit(UIScreen Screen)
{
	local UIArmory_PromotionHero PromotionScreen;
	local UIHeroPromotionStats Stats;

	PromotionScreen = UIArmory_PromotionHero(Screen);
	if (PromotionScreen == none) return;

	Stats = GetOrCreateStats();
	Stats.Show();

	Stats.PopulateData(PromotionScreen.GetUnitRef());
	Stats.AnimateIn();
}

event OnReceiveFocus(UIScreen Screen)
{
	local UIArmory_PromotionHero PromotionScreen;
	local UIHeroPromotionStats Stats;
	
	PromotionScreen = UIArmory_PromotionHero(Screen);
	if (PromotionScreen == none) return;

	Stats = GetOrCreateStats();
	Stats.Show();
}

event OnLoseFocus(UIScreen Screen)
{
	local UIArmory_PromotionHero PromotionScreen;
	local UIHeroPromotionStats Stats;
	
	PromotionScreen = UIArmory_PromotionHero(Screen);
	if (PromotionScreen == none) return;

	Stats = GetOrCreateStats();
	Stats.Hide();
}

event OnRemoved(UIScreen Screen)
{
	local UIArmory_PromotionHero PromotionScreen;
	local UIHeroPromotionStats Stats;
	
	PromotionScreen = UIArmory_PromotionHero(Screen);
	if (PromotionScreen == none) return;

	Stats = GetOrCreateStats();
	Stats.Hide();
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
