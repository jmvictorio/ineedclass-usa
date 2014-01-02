//
//  RequestToJSON.m
//  iNeedClassUSA
//
//  Created by Jesus Victorio on 04/11/13.
//  Copyright (c) 2013 Jesus Victorio. All rights reserved.
//

#import "RequestToJSON.h"

@implementation RequestToJSON
@synthesize rows;

- (NSArray *)leerConsultaMysql:(int)opcion texto:(NSString *)string{
    NSURL *url;
    
    if(opcion==1){
        url = [NSURL URLWithString:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=1"];
    }
    if (opcion==2) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=2&texto=%@", string];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    if(opcion==3){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=3&texto=%@", string];
        url = [NSURL URLWithString:url2];
    }
    if (opcion==4) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=4&texto=%@", string];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    
    if(opcion==9){
        NSString *url2 = [NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=9&texto=%@", string];
        NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }

    if(opcion==10){
        NSString *url2 = [NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=10&texto=%@", string];
        NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==12){
        NSString *url2 = [NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=12&texto=%@", string];
        NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==13){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=13&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==14){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=14&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==17){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=17&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==18){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=18&texto=%@", string];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==301){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=301&id_exchange=%@", string];
        NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==1){
            rows = [dict objectForKey:@"states"];
        }
        if(opcion==2){
            rows = [dict objectForKey:@"cities"];
        }
        if(opcion==4){
            rows = [dict objectForKey:@"cities"];
        }
        if(opcion==7){
            rows = [dict objectForKey:@"levels"];
        }
        if(opcion==9){
            rows = [dict objectForKey:@"person"];
        }
        if(opcion==10){
            rows = [dict objectForKey:@"account"];
            //NSLog(@"%@", rows);
        }
        if(opcion==12){
            rows = [dict objectForKey:@"exchange1"];
        }
        if(opcion==13){
            rows = [dict objectForKey:@"exchange2"];
            //NSLog(@"%@", rows);
        }
        if(opcion==14){
            rows = [dict objectForKey:@"exchangeAccount"];
            //NSLog(@"%@", rows);
        }
        if(opcion==17){
            rows = [dict objectForKey:@"email"];
            //NSLog(@"%@", rows);
        }
        if(opcion==18){
            rows = [dict objectForKey:@"nameExchange"];
            //NSLog(@"%@", rows);
        }
        
    }
    return rows;
}
- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2 {
    NSURL *url;
    
    if (opcion==5) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=5&texto1=%@&texto2=%@", string1, string2];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    if(opcion==6){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=6&texto1=%@&texto2=%@", string1, string2];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==11){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=11&texto1=%@&texto2=%@", string1, string2];
        //NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }
    if(opcion==16){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=16&texto1=%@&texto2=%@", string1, string2];
        NSLog(@"%@",url2);
        url = [NSURL URLWithString:url2];
    }

   
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==5){
            rows = [dict objectForKey:@"count"];
        }
        if(opcion==6){
            rows = [dict objectForKey:@"languagesExchanges"];
            //NSLog(@"%@", rows);
        }
        if(opcion==11){
            rows = [dict objectForKey:@"login_inc"];
            //NSLog(@"%@", rows);
        }
        if(opcion==16){
            rows = [dict objectForKey:@"login"];
            //NSLog(@"%@", rows);
        }
        
        
    }
    return rows;
}
- (NSArray *)leerConsultaMysql:(int)opcion {
    NSURL *url;
    if(opcion==1){
        url = [NSURL URLWithString:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=3"];
    }
    if(opcion==3){
        url = [NSURL URLWithString:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=3"];
    }
    if(opcion==15){
        url = [NSURL URLWithString:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=15"];
    }
    
    
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==1){
            rows = [dict objectForKey:@"states"];
        }
        if(opcion==3){
            rows = [dict objectForKey:@"states"];
        }
        if(opcion==15){
            rows = [dict objectForKey:@"languages"];
            //NSLog(@"%@",rows);
        }
        
        
    }
    return rows;
}
- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2 texto3:(NSString *)string3{
    NSURL *url;
    if (opcion==7) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=7&texto1=%@&texto2=%@&texto3=%@", string1, string2, string3];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    if (opcion==8) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=8&texto1=%@&texto2=%@&texto3=%@", string1, string2, string3];
        url = [NSURL URLWithString:url2];
        NSLog(@"%@",url2);
    }
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==7){
            rows = [dict objectForKey:@"levels"];
        }
        if(opcion==8){
            rows = [dict objectForKey:@"people"];
        }
        
        
    }
    return rows;
}

- (NSArray *)leerConsultaMysql:(int)opcion texto1:(NSString *)string1 texto2:(NSString *)string2 texto3:(NSString *)string3 texto4:(NSString *)string4{
    NSURL *url;
    if (opcion==7) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=7&texto1=%@&texto2=%@&texto3=%@", string1, string2, string3];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    if (opcion==81) {
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=81&texto1=%@&texto2=%@&texto3=%@&texto4=%@", string1, string2, string3, string4];
        url = [NSURL URLWithString:url2];
        //NSLog(@"%@",url2);
    }
    NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
    // NSLog(jsonreturn);
    
    NSData *jsonData=[jsonreturn dataUsingEncoding:NSUTF32BigEndianStringEncoding];
    
    
    NSDictionary * dict=[NSJSONSerialization JSONObjectWithData:jsonData options:NSUTF32BigEndianStringEncoding error:nil];
    
    if(dict){
        if(opcion==7){
            rows = [dict objectForKey:@"levels"];
        }
        if(opcion==81){
            rows = [dict objectForKey:@"people"];
        }
        
        
    }
    return rows;
}
//INSERTS!!!

- (void)insert:(int)option array:(NSArray *)datas{
    NSURL *url;
     //NSLog(@"insert: %@", datas);
    if(option==101){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=101&id_login=%@&pass=%@&tel=%@&age=%@&genre=%@", [datas objectAtIndex:0], [datas objectAtIndex:1], [datas objectAtIndex:2], [datas objectAtIndex:3], [datas objectAtIndex:4]];
        
        url = [NSURL URLWithString:url2];
        //[url query];
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        jsonreturn=@"";
        //NSLog(@"insert: %@", url2);
    }
    if(option==102){
        NSString *id_exchange=[datas objectAtIndex:0];
        NSString *id_exchange1=[datas objectAtIndex:1];
        NSString *id_exchange2=[datas objectAtIndex:2];
        NSString *level=[datas objectAtIndex:3];
        NSString *city=[datas objectAtIndex:4];
        NSString *state=[datas objectAtIndex:5];
        NSString *observations=[datas objectAtIndex:6];
        
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=102&id_exchange=%@&id_exchange1=%@&id_exchange2=%@&level=%@&city=%@&state=%@&observations=%@", id_exchange, id_exchange1, id_exchange2, level, city, state, observations];
        url = [NSURL URLWithString:url2];
        //[url query];
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        jsonreturn=@"";
        //NSLog(@"insert: %@", jsonreturn);
    }
    if(option==201){
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=201&email=%@&pass=%@", [datas objectAtIndex:0], [datas objectAtIndex:1]];
        url = [NSURL URLWithString:url2];
        //[url query];
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        jsonreturn=@"";
        //NSLog(@"insert: %@", url2);
    }
    if(option==202){
        NSString *id_user=[datas objectAtIndex:0];
        NSString *id_exchange1=[datas objectAtIndex:1];
        NSString *id_exchange2=[datas objectAtIndex:2];
        NSString *level=[datas objectAtIndex:3];
        NSString *city=[[datas objectAtIndex:4] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *state=[[datas objectAtIndex:5] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *observations=[datas objectAtIndex:6];

        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=202&id_user=%@&id_exchange1=%@&id_exchange2=%@&level=%@&city=%@&state=%@&observation=%@", id_user, id_exchange1, id_exchange2, level, city, state, observations];

        url = [NSURL URLWithString:url2];
        //[url query];
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        jsonreturn=@"";
        //NSLog(@"insert: %@", url2);
    }
    if(option==203){
        NSString *id_login=[datas objectAtIndex:0];
        NSString *name=[[datas objectAtIndex:1] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *lastname=[[datas objectAtIndex:2] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *age=[datas objectAtIndex:3];
        NSString *tel=[datas objectAtIndex:4];
        NSString *genre=[datas objectAtIndex:5];
        NSString *city=[[datas objectAtIndex:6] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        NSString *state=[[datas objectAtIndex:7] stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        
        NSString *url2=[NSString stringWithFormat:@"http://s505130685.onlinehome.us/web2/consultaUSA.php?opcion=203&id_login=%@&name=%@&lastname=%@&age=%@&tel=%@&genre=%@&city=%@&state=%@", id_login, name, lastname, age, tel, genre, city, state];
        
        url = [NSURL URLWithString:url2];
        //[url query];
        NSString *jsonreturn= [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        jsonreturn=@"";
        NSLog(@"insert: %@", url2);
    }

    UIAlertView* mes=[[UIAlertView alloc] initWithTitle:@"iNeedClass"
                                                message:@"COMPLETE" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    
    [mes show];
    
    //NSLog(@"insert: %@", jsonreturn);

}

@end
