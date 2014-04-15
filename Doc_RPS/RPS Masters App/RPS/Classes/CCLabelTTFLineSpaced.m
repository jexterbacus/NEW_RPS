//
//  CCLabelTTFLineSpaced.m
//  RPS
//
//  Created by chibitotoro on 12-05-05.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CCLabelTTFLineSpaced.h"

@implementation CCLabelTTFLineSpaced

+ (id) labelWithString:(NSString*)string dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size lineSpace:(CGFloat)space{
    return [[[self alloc] initWithString: string dimensions:dimensions alignment:alignment fontName:name fontSize:size lineSpace:(CGFloat)space]autorelease];
}

- (id) initWithString:(NSString*)str dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment fontName:(NSString*)name fontSize:(CGFloat)size lineSpace:(CGFloat)space{
    if( (self=[super init]) ) {
        anchorPoint_ = ccp(0.5f, 0.5f);
        [self setContentSize:dimensions];
        self.isRelativeAnchorPoint = NO;
        
        int pos = 0;
        int i = 0;
        while (pos<[str length]) {
            int end = 0;
            int lastCut = -1;
            bool finished=NO;
            while (finished==NO) {
                CGSize actualSize = [[str substringWithRange:NSMakeRange(pos, end)] sizeWithFont:[UIFont fontWithName:name size:size]];
                
                if (actualSize.width > dimensions.width || pos+end == [str length]) {
                    if (pos+end == [str length] && actualSize.width <= dimensions.width) lastCut = end;
                    finished=YES;
                }
                else {
                    if ([[str substringWithRange:NSMakeRange(pos+end, 1)] isEqualToString:@" "] || [[str substringWithRange:NSMakeRange(pos+end, 1)] isEqualToString:@"."] || [[str substringWithRange:NSMakeRange(pos+end, 1)] isEqualToString:@","]) {
                        lastCut = end;
                    }
                    end++;
                }
            }
            
            NSString * strLine = [str substringWithRange:NSMakeRange(pos, lastCut)];
            
            CCLabelTTF * line = [CCLabelTTF labelWithString:strLine dimensions:CGSizeMake(dimensions.width, size*2) alignment:alignment fontName:name fontSize:size];
            [line setAnchorPoint:ccp(0,1)];
            [line setPosition:ccp(0,-i*space)];
            [self addChild:line];
            
            pos=pos+lastCut;
            i++;
        }
    }
    return self;
}
@end
