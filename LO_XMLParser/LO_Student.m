//
//  LO_Student.m
//  LO_XMLParser
//
//  Created by fuxiaohui on 15/8/19.
//  Copyright (c) 2015年 Henan Lanou Technology Co. Ltd. All rights reserved.
//

#import "LO_Student.h"

@implementation LO_Student

- (NSString *)description
{
    return [NSString stringWithFormat:@"name:%@, gender:%@, age:%@", self.name, self.gender, self.age];
}

@end
