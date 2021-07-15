/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : kick it kev
*    Game : Call of Duty: Modern Warfare 2
*    Description : Starts Multiplayer code execution!
*    Date : 13/07/2021 23:40:01
*
*/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
//Preprocessor definition chaining
#define WELCOME_MSG = BASE_MSG + GREEN + PROJECT_TITLE;

//Preprocessor global definitions
#define RED = "^1";
#define GREEN = "^2";
#define BASE_MSG = "Infinity Loader | Project: ";
#define PROJECT_TITLE = "wreck it ralph noob press [{+actionslot 1}]";

//Preprocessor directives
#ifdef RELEASE
    #define BUILD = "Release Build";
#else
    #ifndef DEBUG
        #define BUILD = "Build type not set";
    #else
        #define BUILD = "Debug Build";
    #endif
#endif

init()
{
    level thread onPlayerConnect();
}

onPlayerConnect()
{
    for(;;)
    {
        level waittill("connected", player);

        if (player IsHost()) {
            level.host = player;
            player thread overflowfix();
        }
        
        player setupMenu();
        player thread showScrollerText();
        player thread onPlayerSpawned();
    }
}

welcome()
{
    notifyData             = spawnstruct();
    notifyData.titleText   = "Alright " + getName();
    notifyData.notifyText  = "sapnin fella";
    notifyData.notifyText2 = "take it easy";
    notifyData.glowColor   = (0.0, 0.0, 1.0);
    notifyData.duration    = 5;
    notifyData.iconName    = "cardicon_prestige10_02";
    self thread maps\mp\gametypes\_hud_message::notifyMessage(notifyData);
}

onPlayerSpawned()
{
    self endon("disconnect");
    level endon("game_ended");
    for(;;)
    {
        self waittill("spawned_player");
        
        self welcome();
        
        // singleton for this player
        if(isDefined(self.playerSpawned))
            continue;
        self.playerSpawned = true;

        self freezeControls(false);
        
        // Will appear each time when the player spawns, that's just an example.
        self iprintln(RED + BUILD);
        self iprintln(WELCOME_MSG);
    
        //Your code goes here...Good Luck!
    }
}
