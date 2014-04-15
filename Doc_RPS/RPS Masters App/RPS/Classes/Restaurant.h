//
//  RestaurantStage.h
//  RPS
//
//  Created by chibitotoro on 12-04-19.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stage.h"

#import "Chef.h"
#import "Pan.h"
#import "Waitress.h"
@interface Restaurant : Stage{
    
    CCSprite * fan;
    CCAction * fanSpinAction;
    CCSpriteBatchNode * fanSpriteSheet;
    CCAnimation *fanAnimation;
    
    Chef * chef;
    Pan * pan;
    Waitress * waitress;
}

@property (nonatomic, retain) CCSprite * fan;
@property (nonatomic, retain) CCSpriteBatchNode * fanSpriteSheet;
@property (nonatomic, retain) Chef * chef;
@property (nonatomic, retain) Pan * pan;
@property (nonatomic, retain) Waitress * waitress;
-(void) pause;
-(void) resume;

@end
