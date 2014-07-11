//
//  main.m
//  SuPu
//
//  Created by xx on 12-9-17.
//  Copyright (c) 2012年 com.chichuang. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SPAppDelegate.h"
#import "HomeInterFace.h"
#import "InterFaceTestBasic.h"
#import "Member.h"
//supuycom@yahoo.cn

int main(int argc, char *argv[])
{
    @autoreleasepool {
//        InterFaceTestBasic *iftb = [[InterFaceTestBasic alloc] init];
//        [iftb testInterFace];
//        return nil;
//        NSString *aaa = @"{\"ErrorCode\": 0,\"Message\": null,\"Data\": {\"TopGoodsList\": [{\"Name\": \"今日特价\",\"Goods\": [{\"GoodsSN\": \"0101030011\",\"ImgFile\": \"72c608a5-90d3-4267-94e2-8192b3cd9355_small.JPG\",\"Price\": 72},{\"GoodsSN\": \"0103320014\",\"ImgFile\": \"f0971304-f13a-4d28-8e45-7ea6938c2622_small.jpg\",\"Price\": 133.5}]},{\"Name\": \"新品上架\",\"Goods\": [{\"GoodsSN\": \"0102011014\",\"ImgFile\": \"0e30cda6-c97a-4bba-b9c1-16918a94e6a8_small.jpg\",\"Price\": 239},{\"GoodsSN\": \"0102021008\",\"ImgFile\": \"2b7a4247-8f8c-4c04-b238-b0122c810faa_small.jpg\",\"Price\": 232.2}]},{\"Name\": \"超值推荐\",\"Goods\": [{\"GoodsSN\": \"0104520029\",\"ImgFile\": \"51894ef3-3d51-4077-a100-0fa27eb27ee7_small.jpg\",\"Price\": 53.5},{\"GoodsSN\": \"0107011004\",\"ImgFile\": \"3c2325d2-10e5-47b6-befa-c0ae402a77b5_small.jpg\",\"Price\": 31.8}]},{\"Name\": \"热卖商品\",\"Goods\": [{\"GoodsSN\": \"0107131004\",\"ImgFile\": \"58c0dad3-c43a-456c-bcd8-f6ac10d2f869_small.jpg\",\"Price\": 105},{\"GoodsSN\": \"0107111000\",\"ImgFile\": \"f7a6e3c5-319c-4647-8cc4-10a6236a2646_small.jpg\",\"Price\": 213.2}]}]}}";
//        NSArray *arr = (NSArray *)[JsonUtil fromSimpleJsonStrToSimpleObject:aaa className:[Member class] keyPath:@"Data.TopGoodsList.Goods" keyPathDeep:@"0.1.0"];
//        NSLog(@"%d",arr.count);
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([SPAppDelegate class]));
    }
}
