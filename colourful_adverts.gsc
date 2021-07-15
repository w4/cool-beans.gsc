/*
*    Infinity Loader :: Created By AgreedBog381 && SyGnUs Legends
*
*    Project : wreck it ralph
*    Author : 
*    Game : Call of Duty: Modern Warfare 2
*    Description : An empty canvas for anything you want!
*    Date : 14/07/2021 23:11:24
*
*/

showScrollerText() {
    self endon("disconnected");

    text = createText("Objective", 2, "LEFT", "CENTER", 100, 200, 0, "1", "", (1, 1, 1));
    
    messages = [];
    messages[0] = "COOL BEANS";
    messages[1] = "PRESS [{+actionslot 1}] FOR MENU";
    messages[2] = "RAZ WOZ ERE";
    messages[3] = "HOST: " + (level.host getName());
    
    for (;;) {
        text setTextRandom(messages[RandomInt(messages.size)]);
    }
}

setTextRandom(text) {
    switch (RandomInt(4)) {
        case 0:
            for (i = 0; i < text.size; i++) {
                if (text[i] == "[") {
                    i = charpos(text, i, "]") + 1;
                    continue;
                }
                self setSafeText(highlightSingleCharacter(text, i, "^3", "^7"));
                wait .3;
            }
        
            for (i = text.size; i >= 0; i--) {
                if (text[i] == "]") {
                    i = charposrev(text, i, "[") - 1;
                    continue;
                }
                self setSafeText(highlightSingleCharacter(text, i, "^3", "^7"));
                wait .3;
            }
        
            for (i = 0; i < 2; i++) {
                self setSafeText(text);
                wait .3;
            
                self setSafeText("^3" + text);
                wait .3;
            }
            break;
        case 1:
            for (i = 0; i < 15; i++) {
                self setSafeText("^" + RandomInt(8) + text);
                wait .3;
            }
            break;
        case 2:
            for (i = 0; i < 50; i++) {
                self setSafeText(randomHighlightEachCharacter(text));
                wait .1;
            }
            break;
        case 3:
            colour = "^" + RandomInt(8);
        
            for (i = 0; i < 4; i++) {
                self setSafeText(colour + text);
                wait .3;
                self setSafeText(text);
                wait .3;
            }
            break;
        //case 4:
        //    colour = "^" + RandomInt(8);
        //    for (i = text.size; i >= 0; i--) {
            //        self SetText(highlightEverythingAfterAndIncludingCharacter(text, i, colour));
            //    wait .3;
        //}            
        //   break;
        //case 5:
         //   colour = "^" + RandomInt(8);
         //  for (i = 0; i < text.size; i++) {
             //       for (j = text.size; j >= i; j--) {
                 //       self setText(highlightUpToCharacterAndSingleCharacter(text, i, j, colour));
             //   }
         //}
         //  break;
    }
}
    
highlightUpToCharacterAndSingleCharacter(text, upTo, single, highlight) {
    newText = highlight;
    
    for (i = 0; i < text.size; i++) {
        if (i == upTo) {
            newText += "^7";
        }
        
        if (i == single) {
            newText += highlight;
        }
        
        newText += text[i];
    }
    
    return newText;
}

highlightEverythingAfterAndIncludingCharacter(text, char, highlight) {
    newText = "";
    
    for (i = 0; i < text.size; i++) {
        if (i == char) {
            newText += highlight;
        }
        newText += text[i];
    }
    
    return newText;
}
    
randomHighlightEachCharacter(text) {
    newText = "";
    
    for (i = 0; i < text.size; i++) {
        if (text[i] == "[") {
            for(; i < charpos(text, i, "]") + 1; i++) {
                newText += text[i];
            }
            continue;
        }
        newText += "^" + RandomInt(8) + text[i];
    }
    
    return newText;
}

highlightSingleCharacter(text, character, highlight, rest) {
    newText = rest;
    
    for (i = 0; i < text.size; i++) {
        if (i == character) {
            newText += highlight + text[i] + rest;
        } else {
            newText += text[i];
        }
    }
    
    return newText;
}