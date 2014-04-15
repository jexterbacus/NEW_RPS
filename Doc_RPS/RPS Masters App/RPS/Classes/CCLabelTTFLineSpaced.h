//
//  CCLabelTTFLineSpaced.h
//  RPS
//
//  Created by chibitotoro on 12-05-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCLabelTTFLineSpaced : CCLabelTTF{
    
}

+ (id) labelWithString:(NSString*)string dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size lineSpace:(CGFloat)space;

- (id) initWithString:(NSString*)str dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size lineSpace:(CGFloat)space;

@end