//
//  MainMenuLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-07.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@interface MainMenuLayer : CCLayer{
    
    CCSprite * sprLogo;
    CCSprite * sprBackground;
    
    CCSprite * sprSinglePlayer;
    CCSprite * sprMultiplayer;
    CCSprite * sprAbout;
    CCSprite * sprOptions;

    
    CCMenuItemImage * itmSinglePlayer;
    CCMenuItemImage * itmMultiplayer;
    CCMenuItemImage * itmOptions;
    CCMenuItemImage * itmAbout;
    CCMenuItemImage * itmHowToPlay;
    
    CCMenuItemImage * itmAchievement;
    CCMenuItemImage * itmLeaderboard;
    
    
    CCMenu *menu;
}
+(CCScene *) scene;

@end
