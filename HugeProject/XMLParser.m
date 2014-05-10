//
//  XMLParser.m
//  HugeProject
//
//  Created by Aditya Narayan on 5/10/14.
//  Copyright (c) 2014 TurnToTech. All rights reserved.
//

#import "XMLParser.h"

@implementation XMLParser


-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    
    NSLog(@"Did start element: %@", elementName);
    NSLog(@"Dictionary: %@", attributeDict);
    
      if ( [elementName isEqualToString:@"root"])
      {
          NSLog(@"found rootElement");
          return;
      }
          
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    NSLog(@"Did end element: %@", elementName);
    if ([elementName isEqualToString:@"root"])
    {
        NSLog(@"rootelement end");
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    NSLog(@"str: %@", string);
    
//    NSString *tagName = @"column";
//    
//    if([tagName isEqualToString:@"column"])
//    {
//        NSLog(@"Value %@",string);
//    }
}


@end
