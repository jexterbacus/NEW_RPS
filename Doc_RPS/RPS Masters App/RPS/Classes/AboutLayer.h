//
//  AboutLayer.h
//  RPS
//
//  Created by chibitotoro on 12-03-08.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <GameKit/GameKit.h>
#import "cocos2d.h"
#import "CCLabelTTFLineSpaced.h"

@interface AboutLayer : CCLayer{
    CCLabelTTF * lblContent;
    
    CCMenuItemImage * itmReturn;
    
    CCMenu * menu;
    CCSprite * sprBackground;
}
+(CCScene *) scene;

@end
