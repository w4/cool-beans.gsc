/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 20:40:32
*
*/

command_god_mode() {
    self endon("disconnect");
    
    if (IsDefined(self.isInGodMode) && self.isInGodMode) {
        self IPrintLn("^1God mode disabled");
        self.isInGodMode = false;
        return;
    } else {
        self IPrintLn("^2God mode enabled");
        self.isInGodMode = true;
    }
    
    self.maxHealth = 90000;
    self.health    = self.maxHealth;
    
    while (self.isInGodMode) {
        wait 2;
        if (self.health < self.maxHeath) self.health = self.maxHealth;
    }
}
