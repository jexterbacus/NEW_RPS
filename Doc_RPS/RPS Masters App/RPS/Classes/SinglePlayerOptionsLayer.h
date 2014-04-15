//
//  SinglePlayerOptionsLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "Dog.h"
#import "Robot.h"
#import "Snowman.h"
#import "Boy.h"
#import "Girl.h"

@interface SinglePlayerOptionsLayer : CCLayer{
    
    CCLabelTTF * lblCharacterName;
    
    CCMenuItemImage * itmBoy;
    CCMenuItemImage * itmGirl;
    CCMenuItemImage * itmRobot;
    CCMenuItemImage * itmSnowman;
    CCMenuItemImage * itmDog;
    
    CCMenuItemImage * itmStart;
    CCMenuItemImage * itmReturn;
    
    CCSprite * sprSelectedFrame;
    Character * chrSelected;
    
    
    CCSprite * sprBackground;
    CCSprite * sprSinglePlayerLabel;
    CCSprite * sprBestOf;
    
    CCMenuItemImage * itmThree;
    CCMenuItemImage * itmFive;
    CCMenuItemImage * itmSeven;
    
    CCMenu *menu;
    
    
    NumRounds numRounds;
    CharacterType characterType;
}
+(CCScene *) scene;

-(void)selectNumRounds:(NumRounds)rounds;
-(void) selectCharacter:(CharacterType)character;
-(void) startMatch;
-(void) createCharacterAvatars;
-(void) createRoundButtons;
-(void) createMenuButtons;

@end
