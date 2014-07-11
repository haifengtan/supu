//
//  OUOFunctions.h
//  OUOKit
//
//  Created by 杨福军 on 12-9-5.
//  Copyright (c) 2012年 杨福军. All rights reserved.
//

static inline BOOL ouoIsEmpty(id thing);
BOOL ouoAnyEmpty(id obj, ...);

UIButton *OUOButtonMake(NSString *imageName, SEL handler, id target);