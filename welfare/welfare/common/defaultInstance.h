//
//  defaultInstance.h
//  FengChao
//
//  Created by Wang Daolong on 1/28/13.
//  Copyright (c) 2013 Baidu, Inc. All rights reserved.
//

/*使用注意:用下面方面生成的对象不应被release，否则可能会引起崩溃
 //todo:support reuse
 */

#define DefaultInstanceForClassHeader(CLASSNAME) + (CLASSNAME *)defaultInstance
#define DefaultInstanceForClass(CLASSNAME) DefaultInstanceForClassMethod(CLASSNAME, defaultInstance)


#define DefaultInstanceForClassMethodHeader(CLASSNAME, METHODNAME) + (CLASSNAME *) METHODNAME
#define DefaultInstanceForClassMethod(CLASSNAME, METHODNAME) \
+ (CLASSNAME *) METHODNAME {    \
	static CLASSNAME *METHODNAME##_;\
	static dispatch_once_t predicate;\
	dispatch_once(&predicate, ^{\
        METHODNAME##_ = [[self alloc] init];\
        SEL setupSelector = @selector(setup);\
        if ([METHODNAME##_ respondsToSelector:setupSelector]) {\
            IMP imp = [METHODNAME##_ methodForSelector:setupSelector]; \
            void (*func)(id, SEL) = (void *)imp; \
            func(METHODNAME##_, setupSelector); \
        }\
    });\
	return METHODNAME##_;\
}


