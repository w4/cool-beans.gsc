/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 23:44:12
*
*/

createText(font, fontScale, align, relative,x, y, sort, alpha, text, color, glowColor, glowAlpha, isLevel)
{
    if(isDefined(isLevel))
    textElem = createServerFontString(font,fontScale);
    else
    textElem = self createFontString(font,fontScale);
    textElem setHudPoint(align, relative, x, y);
    textElem.hideWhenInMenu = true;
    textElem.archived  = false;
    textElem.sort = sort;
    textElem.alpha  = alpha;
    textElem.color  = color;
    textElem.glowColor = glowColor;
    textElem.glowAlpha = glowAlpha;
    self addToStringArray(text);
    textElem thread watchForOverFlow(text);
    return textElem;
}

overflowfix()
{
    level.overflow  = newHudElem();
    level.overflow.alpha = 0;
    level.overflow setText("marker");
    
    for (;;) {
        level waittill("CHECK_OVERFLOW");
        if (level.Strings.size >= 50) {
            level.overflow ClearAllTextAfterHudElem();
            level.Strings = [];
            level notify("FIX_OVERFLOW");
        }
    }
}

setSafeText(text)
{
    self notify("stop_TextMonitor");
    self addToStringArray(text);
    self thread watchForOverFlow(text);
}

addToStringArray(text)
{
    if(!isInArray(level.Strings,text))
    {
        level.Strings[level.Strings.size] = text;
        level notify("CHECK_OVERFLOW");
    }
}

watchForOverFlow(text)
{
    self endon("stop_TextMonitor");
    while(isDefined(self))
    {
        if(isDefined(text.size))
            self setText(text);
        else
        {
            self setText(undefined);
            self.label = text;
        }
        level waittill("FIX_OVERFLOW");
    }
}

isInArray(array,text)
{
    for(e=0;e<array.size;e++)
        if(array[e] == text)
            return true;
    return false;        
}

destroyAllOverflow(array)
{
    if(!isDefined(array))
        return;
    keys = getArrayKeys(array);
    for(a=0;a<keys.size;a++)
    if(isDefined(array[keys[a]][0]))
    for(e=0;e<array[keys[a]].size;e++)
        array[keys[a]][e] destroy();
    else
        array[keys[a]] destroy();
}