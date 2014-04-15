//
//  MultiplayerOptionsLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"
#import "Dog.h"
#import "Robot.h"
#import "Snowman.h"
#import "Boy.h"
#import "Girl.h"

@interface MultiplayerOptionsLayer : CCLayer {
    
    CCLabelTTF * lblCharacterName;
    
    CCLabelTTF * lblUsername;
    
    CCMenuItemImage * itmBoy;
    CCMenuItemImage * itmGirl;
    CCMenuItemImage * itmRobot;
    CCMenuItemImage * itmSnowman;
    CCMenuItemImage * itmDog;
    
    CCMenuItemImage * itmSearch;
    CCMenuItemImage * itmReturn;
    
    CCSprite * sprSelectedFrame;
    Character * chrSelected;
    
    
    CCSprite * sprBackground;
    CCSprite * sprMultiplayerLabel;
    CCSprite * sprSignedInAs;
    
    CCMenuItemImage * itmFriend;
    CCMenuItemImage * itmRandom;

    
    CCMenu *menu;
    
    
    NumRounds numRounds;
    CharacterType characterType;
    
    int opponent;
}
+(CCScene *) scene;

-(void)selectOpponent:(int)o;
-(void) selectCharacter:(CharacterType)character;
-(void) createCharacterAvatars;
-(void) createRoundButtons;
-(void) createMenuButtons;
-(void) startMatch;



@end

