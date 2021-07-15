/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 21:01:33
*
*/

command_level_70() {
    self setplayerdata("experience", 2516000);
}

setPrestige(prestige) {
    self setplayerdata("prestige", prestige);
    self command_level_70();
    self IPrintLn("^2Set to prestige " + prestige);
}

command_prestige_9() {
    self setPrestige(9);
}

command_prestige_10() {
    self setPrestige(10);
}

command_prestige_11() {
    self setPrestige(11);
}

command_colour_classes() {
    j = 1;
    for (i = 0; i < 10; i++) {
        self setPlayerData("customClasses", i, "name", "^" + j + (self getPlayerData("customClasses", i, "name")));
        j++;
        if (j >= 6) j = 1;
    }
    
    self IPrintLn("^3Enjoy your colourful classes");
}

command_clan_tag() {
    if (!IsDefined(self.clanTagIndex)) {
        self.clanTagIndex = 0;
    } else {
        self.clanTagIndex++;
    }
    
    newClanTag = "";
    
    switch (self.clanTagIndex) {
        case 0:
            newClanTag = "{@@}";
            break;
        case 1:
            newClanTag = "^3CB";
            break;
        case 2:
            newClanTag = "FUCK";
        default:
            self.clanTagIndex = -1;
    }
    
    self setClientDvar("clanName", newClanTag);
    self IPrintLn("^3Set clantag to " + (newClanTag == "{@@}" ? "Unbound" : newClanTag));
}
