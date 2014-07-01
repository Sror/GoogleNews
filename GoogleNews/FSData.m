//
//  FSData.m
//  iBash
//
//  Created by Admin on 27.06.14.
//  Copyright (c) 2014 Sky. All rights reserved.
//

#import "FSData.h"

@interface FSData () <NSXMLParserDelegate>

@property (strong, nonatomic) NSMutableArray *privateNews; //will contain downloaded news
@property (strong, nonatomic) NSXMLParser *parser; //xml parser object
@property (strong, nonatomic) NSString *element; //element that parsing at moment
@property (strong, nonatomic) NSMutableDictionary *item; //contains the item title, url, picture, etc.
@property (strong, nonatomic) NSMutableString *itemTitle; // item title
@property (strong, nonatomic) NSMutableString *itemLink; // item link
@property (strong, nonatomic) NSMutableString *itemPubDate; //item's pub date
@property (strong, nonatomic) NSMutableString *itemDescription; //item's description (used for fetching an image)
@property (strong, nonatomic) NSMutableString *itemPictureAddres; //picture url addres
@end


@implementation FSData

+ (instancetype)sharedData
{
    static FSData *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [[super alloc] initUniqueInstance];
    });
    return shared;
}

//do not use default init method
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[FSData sharedData]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initUniqueInstance
{
    return [super init];
}

- (void)parseAtUrl:(NSURL *)url
{
    if (_privateNews) {
        [_privateNews removeAllObjects]; //clean after prev. use
    }
    _privateNews = [[NSMutableArray alloc] init];
    _parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    [_parser setDelegate:self];
    [_parser parse];
}

- (NSArray *)fetchData
{
    return [_privateNews copy];
}

#pragma mark -  Parser delegate methods

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    _element = elementName; //remember the current tag
    //i'm looking for <item>, if found - alloc required ivars
    if ([elementName isEqualToString:@"item"]) {
        _item = [[NSMutableDictionary alloc] init];
        _itemTitle = [[NSMutableString alloc] init];
        _itemLink = [[NSMutableString alloc] init];
        _itemPubDate = [[NSMutableString alloc] init];
        _itemDescription = [[NSMutableString alloc] init];
        _itemPictureAddres = [[NSMutableString alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    //store the text, found between <title> or <description> tags to appropriate ivars
    if ([_element isEqualToString:@"title"]) {
        [_itemTitle appendString:string];
    } else if ([_element isEqualToString:@"link"]) {
        [_itemLink appendString:string];
    } else if ([_element isEqualToString:@"pubDate"]) {
        [_itemPubDate appendString:string];
    } else if ([_element isEqualToString:@"description"]) {
        [_itemDescription appendString:string];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    //all tags are left behind, configuring the item object and pushing it to the news array
    //check to see whether the title and other elements are not Nil, to prevent any errors
    if (([elementName isEqualToString:@"item"]) && (_itemTitle != nil) && (_itemLink != nil) && (_itemPubDate != nil) && (_itemDescription != nil)) {
        [_item setObject:_itemTitle forKey:@"title"];
        [_item setObject:_itemLink forKey:@"link"];
        [_item setObject:_itemPubDate forKey:@"pubDate"];
        //get picture link
        NSRange startRange = [_itemDescription rangeOfString:@"<img src=\"//"];
        NSRange endRange = [_itemDescription rangeOfString:@"\" alt=\"\" border=\"1\""];
        NSRange pictureLink = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
        if (pictureLink.location == NSNotFound) {
            _itemPictureAddres = [NSMutableString stringWithFormat:@"null"];
            NSLog(@"Picture not found: %@", _itemPictureAddres);
        } else {
            NSString *link = [_itemDescription substringWithRange:pictureLink];
            _itemPictureAddres = [NSMutableString stringWithFormat:@"https://%@", link];
        }
        [_item setObject:_itemPictureAddres forKey:@"picture"];
        [_privateNews addObject:_item];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"Parser finished");
}

@end
