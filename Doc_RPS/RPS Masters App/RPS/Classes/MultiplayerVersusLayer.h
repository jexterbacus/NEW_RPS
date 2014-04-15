//
//  MultiplayerVersusLayer.h
//  RPS
//
//  Created by chibitotoro on 12-05-14.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Boy.h"
#import "Girl.h"
#import "Robot.h"
#import "Snowman.h"
#import "Dog.h"
#import "MultiplayerOptionsLayer.h"

@interface MultiplayerVersusLayer : CCLayer {
    CCSprite * sprBackground;
    bool transitioning;
    
    CCSprite * sprSpeedLinesTop;
    CCSprite * sprSpeedLinesBottom;
    CCSprite * sprVersus;
    CCSprite * sprTopLabel;
    CCSprite * sprBottomLabel;
    
    CCSprite * sprTopAvatar;
    CCSprite * sprBottomAvatar;
    
    CCLabelTTF * lblLeft;
    CCLabelTTF * lblRight;
    
    float timer;
    
    
}

+(CCScene *) scene;

@property(nonatomic,assign) bool transitioning;
@end