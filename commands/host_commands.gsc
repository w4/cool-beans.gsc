/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 21:07:09
*
*/

command_advertise() {
    foreach(p in level.players) {
        p thread doAdvertise();
    }
}

doAdvertise() {
    self endon("disconnect");
    advert = self createText("Objective", 2.0, "CENTER", "CENTER", 0, 0, 0, "1", "", (1, 1, 1));
    advert setText("^1This is a Cool Beans lobby");
    wait 4;
    advert setText("^2No uncool beans allowed.");
    wait 4;
    advert setText("^3Be cool and respectful");
    wait 4;
    advert setText("^4Take it easy");
    wait 4;
    advert destroy();
}

command_toggle_ranked_match() {
    if (getDvarInt("xblive_privatematch") == 0) {
        self setClientDvar("xblive_hostingprivateparty", 1);
        setDvar("xblive_hostingprivateparty", 1);
        setDvar("xblive_privatematch", 1);
        self IPrintLn("^1Set to private match");
    } else {
        gametype1 = getDvar("ui_gametype");
        gametype2 = getDvar("party_gametype");
        gametype3 = getDvar("g_gametype");
        setDvar("onlinegameandhost", 1);
        setDvar("party_teambased", 1);
        self setClientDvar("xblive_hostingprivateparty", 0);
        setDvar("xblive_privatematch", 0);
        setDvar("xblive_loggedin", 1);
        self setClientDvar("xblive_loggedin", 1);
        setDvar("xblive_hostingprivateparty", 0);
        setDvar("ui_gametype", gametype1);
        setDvar("g_gametype", gametype3);
        self IPrintLn("^2Set to ranked match");
    }
}