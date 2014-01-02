//
//  RequestToJSON.h
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 04/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestToJSON : NSObject

@property (retain, nonatomic) NSArray *rows;

- (NSArray *)leerConsultaMysql:(int)opcion;
- (NSArray *)leerConsultaMysql:(int)opcion texto:(NSString *)string;
- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2;
- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2 texto3:(NSString *)string3;
- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2 texto3:(NSString *)string3 texto4:(NSString *)string4;
- (void)insert:(int)option array:(NSArray *)datas;
@end
