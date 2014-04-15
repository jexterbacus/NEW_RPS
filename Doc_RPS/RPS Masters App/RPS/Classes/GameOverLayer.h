//
//  GameOverLayer.h
//  RPS
//
//  Created by chibitotoro on 12-05-03.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "AppDelegate.h"

@interface GameOverLayer : CCLayer {
    
    CCSprite * sprBackground;
    
    CCMenu * menu;
    
    CCMenuItemImage * itmReturn;
    CCMenuItemImage * itmContinue;
    
    CCLabelTTF * lblContinue;
    CCLabelTTF * lblTimer;
    
    int eftCountdown;
    float timer;
    bool transitioning;
    
}
+(CCScene *) scene;

-(void) returnCallback;
@end
