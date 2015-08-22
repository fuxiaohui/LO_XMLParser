//
//  ViewController.m
//  LO_XMLParser
//
//  Created by fuxiaohui on 15/8/19.
//  Copyright (c) 2015年 Henan Lanou Technology Co. Ltd. All rights reserved.
//

#import "ViewController.h"
#import "LO_Student.h"
#import "GDataXMLNode.h"

@interface ViewController ()<NSXMLParserDelegate>

@property (nonatomic, retain) NSMutableArray *studentArray;
@property (nonatomic, retain) NSString *string;
@property (nonatomic, retain) LO_Student *student;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //张三男18
    
    //XML
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)parserWithSAX:(id)sender {
    //找到资源路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    //创建url
    NSURL *url = [[NSURL alloc] initFileURLWithPath:filePath];
    //根据url创建解析类
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    //设置代理
    parser.delegate = self;
    //开始解析
    [parser parse];
}

- (IBAction)parserWithDOM:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Student" ofType:@"xml"];
    
    NSError *error = nil;
    
    NSString *content = [[NSString alloc] initWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if (error == nil) {
        NSLog(@"%@", content);
    } else {
        NSLog(@"%@", error);
        return;
    }
    
    GDataXMLDocument *docment = [[GDataXMLDocument alloc] initWithXMLString:content options:0 error:nil];
    
    //取到根节点
    GDataXMLElement *rootElement = [docment rootElement];
    
    //查找子节点
    NSArray *studentElements = [rootElement elementsForName:@"student"];
    
    NSLog(@"%@", studentElements);
    
    self.studentArray = [NSMutableArray arrayWithCapacity:3];
    
    for (GDataXMLElement *element in studentElements) {
        
        LO_Student *student = [[LO_Student alloc] init];
        student.name = [[[element elementsForName:@"name"] firstObject] stringValue];
        student.age = [[[element elementsForName:@"age"] firstObject] stringValue];
        student.gender = [[[element elementsForName:@"gender"] firstObject] stringValue];
        [self.studentArray addObject:student];
    }
    
    NSLog(@"%@", self.studentArray);
}

#pragma mark - NSXMLParserDelegate

- (void)parserDidStartDocument:(NSXMLParser *)parser {
    NSLog(@"开始解析文档");
    self.studentArray = [NSMutableArray arrayWithCapacity:0];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    NSLog(@"已经结束解析文档");
    for (LO_Student *student in self.studentArray) {
        NSLog(@"%@", student);
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    NSLog(@"遇到开始标签:%@", elementName);
    if ([elementName isEqualToString:@"student"]) {
        self.student = [[LO_Student alloc] init];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    NSLog(@"遇到结束标签:%@", elementName);
    if ([elementName isEqualToString:@"name"]) {
        self.student.name = self.string;
    } else if ([elementName isEqualToString:@"gender"]) {
        self.student.gender = self.string;
    } else if ([elementName isEqualToString:@"age"]) {
        self.student.age = self.string;
    } else if ([elementName isEqualToString:@"student"]) {
        [self.studentArray addObject:self.student];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"遇到内容:%@", string);
    self.string = string;
}

@end






