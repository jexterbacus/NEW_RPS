//
//  SinglePlayerChallengerLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SinglePlayerVersusLayer : CCLayer {
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
@end
