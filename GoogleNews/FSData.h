//
//  FSData.h
//  iBash
//
//  Created by Admin on 27.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSData : NSObject

/*
this array consists of a NSDictionary objects that contain key-object pairs. Here are these keys:
@"title" string
@"link" string
@"pubDate" string
@"picture" url
*/

// clue for improper use (produces compile time error)
+(instancetype) alloc __attribute__((unavailable("alloc not available, call sharedInstance instead")));
-(instancetype) init __attribute__((unavailable("init not available, call sharedInstance instead")));
+(instancetype) new __attribute__((unavailable("new not available, call sharedInstance instead")));

+ (instancetype)sharedData;
- (void)parseAtUrl:(NSURL *)url;

@property (strong, nonatomic) NSMutableArray *allNews; //will contain downloaded news

@end
