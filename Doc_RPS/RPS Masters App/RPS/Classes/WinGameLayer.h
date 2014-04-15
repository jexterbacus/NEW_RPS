//
//  WinGameLayer.h
//  RPS
//
//  Created by chibitotoro on 12-05-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"
@interface WinGameLayer : CCLayer{
    
    CCSprite * sprBackground;
    
    CCMenu * menu;
    
    CCMenuItemImage * itmReturn;
    
    Character * winCharacter;
    int winEffect;

    bool transitioning;
}

+(CCScene *) scene;

-(void) returnCallback;

@end
