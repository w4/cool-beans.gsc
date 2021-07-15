/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 20:50:00
*
*/

command_unlimited_ammo() {
    self endon("disconnect");

    if (IsDefined(self.isUsingUnlimitedAmmo) && self.isUsingUnlimitedAmmo) {
        self IPrintLn("^1Unlimited ammo disabled");
        self.isUsingUnlimitedAmmo = false;
        return;
    } else {
        self IPrintLn("^2Unlimited ammo enabled");
        self.isUsingUnlimitedAmmo = true;
    }
    
    while (self.isUsingUnlimitedAmmo) {
        self setWeaponAmmoStock(self getCurrentWeapon(), 99);
        self setWeaponAmmoClip(self getCurrentWeapon(), 99);
        
        currentOffhand = self GetCurrentOffhand();
        if (currentOffhand != "none") {
            self setWeaponAmmoStock(currentOffhand, 99);
            self setWeaponAmmoClip(currentOffhand, 99);
        }
        
        wait .25; 
    }
}

command_no_recoil() {
    self IPrintLn("^2No recoil enabled");
    self player_recoilScaleOn(0);
}

command_golden_deagle() {
    self GiveWeapon("deserteaglegold_mp", 0, false);
}