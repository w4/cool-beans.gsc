/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 00:38:54
*
*/

setupMenu() {
    self thread listenForMenuOpenCloseEvents();
}

listenForMenuOpenCloseEvents() {
    self endon("disconnect");
    self notifyonplayercommand("MenuShow", "+actionslot 1");
    self notifyonplayercommand("MenuClose", "+melee");
    
    for(;;) {
        if (!self.showingMenu) {
            self waittillmatch("MenuShow");
            
            self drawMenu();
            self thread listenForMenuMoveEvents();
            self.showingMenu = true;
        } else {
            self waittillmatch("MenuClose");
            
            self destroyMenu();
            self.showingMenu = false;
        }
        
        self notify(self.showingMenu ? "MenuShowing" : "MenuClosed");
        self freezeControls(self.showingMenu);
    }
}

listenForMenuMoveEvents() {
    self endon("disconnect");
    self endon("MenuClosed");
    self thread listenForMenuButtonEvent("up", "+actionslot 1");
    self thread listenForMenuButtonEvent("down", "+actionslot 2");
    self thread listenForMenuButtonEvent("left", "+actionslot 3");
    self thread listenForMenuButtonEvent("right", "+actionslot 4");
    self thread listenForMenuButtonEvent("do", "+gostand");
    
    for(;;) {
        self waittill("MenuButtonPress", buttonName);
        
        updateMenu = false;
        
        switch(buttonName) {
            case "up":
                updateMenu = true;
                self.currentSelectedMenuItem -= 1;
                break;
            case "down":
                updateMenu = true;
                self.currentSelectedMenuItem += 1;
                break;
            case "left":
                updateMenu = true;
                self.currentSelectedTab -= 1;
                self.currentSelectedMenuItem = 0;
                break;
            case "right":
                updateMenu = true;
                self.currentSelectedTab += 1;
                self.currentSelectedMenuItem = 0;
                break;
            case "do":
                self doSelectedMenuItem();
                break;
        }
        
        if(updateMenu) {
            self redrawMenu();
        }
    }
}

doSelectedMenuItem() {
    tab          = getCurrentSelectedTab().items;
    keys         = GetArrayKeys(tab);
    selectedItem = tab[keys[self.currentSelectedMenuItem]];
    
    self thread [[selectedItem]]();
}

redrawMenu() {
    self destroyMenu();
    self drawMenu();
}

listenForMenuButtonEvent(buttonName, command) {
    self endon("disconnect");
    self endon("MenuClosed");
    self notifyonplayercommand(buttonName, command);
    
    for(;;) {
        self waittillmatch(buttonName);
        self notify("MenuButtonPress", buttonName);
    }
}

getTabs() {
    menuItems = [];
    
    menuItems["Account"] = SpawnStruct();
    menuItems["Account"].required_level = 1;
    menuItems["Account"].menu_items = [];
    menuItems["Account"].menu_items["Level 70"] = ::command_level_70;
    menuItems["Account"].menu_items["Prestige 9"] = ::command_prestige_9;
    menuItems["Account"].menu_items["Prestige 10"] = ::command_prestige_10;
    menuItems["Account"].menu_items["Prestige 11"] = ::command_prestige_11; // broken?
    menuItems["Account"].menu_items["Colourful Classes"] = ::command_colour_classes; // broken?
    menuItems["Account"].menu_items["Cycle Clantag"] = ::command_clan_tag;
    
    menuItems["Infections"] = SpawnStruct();
    menuItems["Infections"].required_level = 1;
    menuItems["Infections"].menu_items = [];
    menuItems["Infections"].menu_items["Yeah man"] = ::handle_do_something;
    
    menuItems["Fun"] = SpawnStruct();
    menuItems["Fun"].required_level = 1;
    menuItems["Fun"].menu_items = [];
    menuItems["Fun"].menu_items["Unlimited Ammo"] = ::command_unlimited_ammo;
    menuItems["Fun"].menu_items["No Recoil"] = ::command_no_recoil;
    menuItems["Fun"].menu_items["Give Golden Deagle"] = ::command_golden_deagle;
    
    menuItems["Admin"] = SpawnStruct();
    menuItems["Admin"].required_level = 3;
    menuItems["Admin"].menu_items = [];
    menuItems["Admin"].menu_items["God Mode"] = ::command_god_mode;
    
    menuItems["Host"] = SpawnStruct();
    menuItems["Host"].required_level = 4;
    menuItems["Host"].menu_items = [];
    menuItems["Host"].menu_items["Advertise"] = ::command_advertise;
    menuItems["Host"].menu_items["Toggle Ranked Match"] = ::command_toggle_ranked_match;
    
    return menuItems;
}

getCurrentSelectedTab() {
    tabs     = getTabs();
    tabNames = GetArrayKeys(tabs);
    
    ret       = SpawnStruct();
    ret.name  = tabNames[self.currentSelectedTab];
    ret.items = tabs[tabNames[self.currentSelectedTab]].menu_items;
    
    return ret;
}

createMenuText(text, y, colour, size) {
    return createText(
        "Objective",
        size,
        "LEFT",
        "TOP",
        170,
        y,
        0,
        "1",
        text,
        colour
    );
}

// #1976D2 dark primary colour
// #BBDEFB light primary colour
// #2196F3 primary colour
// #FFFFFF text colour
// #03A9F4 accent colour
// #212121 primary text
// #757575 secondary text
// #BDBDBD divider colour
drawMenu() {
    if (!IsDefined(self.currentSelectedTab)) {
        self.currentSelectedTab = 0;
    }
    
    if (!IsDefined(self.currentSelectedMenuItem)) {
        self.currentSelectedMenuItem = 0;
    }
    
    tabs = getTabs();
    if(self.currentSelectedTab < 0) {
        self.currentSelectedTab = tabs.size - 1;
    } else if (self.currentSelectedTab >= tabs.size) {
        self.currentSelectedTab = 0;
    }
        
    if(self.currentSelectedMenuItem < 0) {
        self.currentSelectedMenuItem = GetArrayKeys(getCurrentSelectedTab().items).size - 1;
    } else if (self.currentSelectedMenuItem >= GetArrayKeys(getCurrentSelectedTab().items).size) {
        self.currentSelectedMenuItem = 0;
    }
    
    self.menuUiElements = SpawnStruct();
    
    self.menuUiElements.headerBackground = createRectangle("LEFT", "TOP", 160, 0, 300, 100, (0.098039216, 0.462745098, 0.823529412), "white", -1, .9);
    self.menuUiElements.header           = createMenuText("cool beans", 0, (1, 1, 1), 2);
    
    self.menuUiElements.background = createRectangle("LEFT", "TOP", 160, 100, 300, 1000, (0.129411765, 0.588235294, 0.952941176), "white", -1, .9);
    
    selectedTab = getCurrentSelectedTab();

    self.menuUiElements.tab        = SpawnStruct();
    self.menuUiElements.tab.header = createMenuText("[{+actionslot 3}] " + selectedTab.name + " [{+actionslot 4}]", 20, (0.733333333, 0.870588235, 0.984313725), 1.3);
    self.menuUiElements.tab.items  = [];

    items = getArrayKeys(selectedTab.items);
    for (i = 0; i < items.size; i++) {
        self.menuUiElements.tab.items[i] = createMenuText(items[i], 75 + (i * 20), i == self.currentSelectedMenuItem ? (0.733333333, 0.870588235, 0.984313725) : (1, 1, 1), 1.3);
    }
}

destroyMenu() {
    self.menuUiElements.headerBackground destroy();
    self.menuUiElements.background destroy();
    self.menuUiElements.header destroy();
    self.menuUiElements.tab.header destroy();
    destroyAll(self.menuUiElements.tab.items);
    
    self.menuUiElements destroy();
}

handle_do_something() {
    self iprintln("hello world!");
}
