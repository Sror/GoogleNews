//
//  FSData.h
//  iBash
//
//  Created by Admin on 27.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSData : NSObject


@property (strong, nonatomic) NSMutableArray *news; //will contain downloaded news
/*
this array consists of a NSDictionary objects that contain key-object pairs. Here are these keys:
@"title" string
@"link" string
@"pubDate" string
@"picture" url
*/

- (void)parseAtUrl:(NSURL *)url;
- (NSArray *)fetchData;

@end
