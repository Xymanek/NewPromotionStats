class UIScreenListener_PromotionHero extends UIScreenListener;

const PANEL_NAME = 'NewPromotionStats';

// This event is triggered after a screen is initialized
event OnInit(UIScreen Screen);

// This event is triggered after a screen receives focus
event OnReceiveFocus(UIScreen Screen);

// This event is triggered after a screen loses focus
event OnLoseFocus(UIScreen Screen);

// This event is triggered when a screen is removed
event OnRemoved(UIScreen Screen);

simulated function UIAvengerHUD GetHUD()
{
	return `HQPRES.m_kAvengerHUD;
}

simulated function AddIfCorrectScreen(UIScreen Screen)
{
	local UIArmory_PromotionHero PromotionScreen;

	PromotionScreen = UIArmory_PromotionHero(Screen);
	if (PromotionScreen == none) return;

	if (PromotionScreen.GetChildByName(PANEL_NAME, false) != none) return;


}