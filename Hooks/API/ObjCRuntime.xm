#import "../SharedDefine.pch"
#import <objc/runtime.h>
#import <Foundation/Foundation.h>

/*
To Implement:
objc_getMetaClass(const char *name)
Ivar object_setInstanceVariable(id obj, const char *name, void *value)
Ivar object_getInstanceVariable(id obj, const char *name, void **outValue)
Ivar class_getInstanceVariable(Class cls, const char *name)
Ivar class_getClassVariable(Class cls, const char *name) 
Method class_getInstanceMethod(Class cls, SEL name)
Method class_getClassMethod(Class cls, SEL name)
IMP class_getMethodImplementation_stret(Class cls, SEL name) 
BOOL class_addProtocol(Class cls, Protocol *protocol) 
void class_replaceProperty(Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount) 
SEL method_getName(Method m) 
IMP method_getImplementation(Method m) 
IMP method_setImplementation(Method m, IMP imp) 
BOOL class_addProperty(Class cls, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount)  
void method_exchangeImplementations(Method m1, Method m2) 
Protocol *objc_getProtocol(const char *name)
objc_property_t protocol_getProperty(Protocol *proto, const char *name, BOOL isRequiredProperty, BOOL isInstanceProperty)
void protocol_addProtocol(Protocol *proto, Protocol *addition) 
void objc_registerProtocol(Protocol *proto) 
void protocol_addProperty(Protocol *proto, const char *name, const objc_property_attribute_t *attributes, unsigned int attributeCount, BOOL isRequiredProperty, BOOL isInstanceProperty)
const char **objc_copyImageNames(unsigned int *outCount) 
const char *class_getImageName(Class cls) 
IMP imp_implementationWithBlock(id block)
id imp_getBlock(IMP anImp)
void objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy)
id objc_getAssociatedObject(id object, const void *key)



See: https://developer.apple.com/library/prerelease/mac/documentation/Cocoa/Reference/ObjCRuntimeRef/index.html


*/


//Old Func Pointers
Class (*old_NSClassFromString)(NSString *aClassName);
NSString* (*old_NSStringFromClass)(Class aClass);
NSString* (*old_NSStringFromProtocol)(Protocol* proto);
Protocol* (*old_NSProtocolFromString)(NSString* namestr);
NSString* (*old_NSStringFromSelector)(SEL aSelector);
SEL (*old_NSSelectorFromString)(NSString* aSelectorName);
BOOL (*old_class_addMethod)(Class cls, SEL name, IMP imp,const char *types);
BOOL (*old_class_addIvar)(Class cls, const char *name, size_t size,uint8_t alignment, const char *types);
Class (*old_objc_getClass)(const char *name);
IMP (*old_class_getMethodImplementation)(Class cls, SEL name);
IMP (*old_class_replaceMethod)(Class cls, SEL name, IMP imp, const char *types); 

//New Func
Class new_NSClassFromString(NSString* aClassName){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSClassFromString");
		WTAdd(aClassName,@"ClassName");
		WTSave;
		WTRelease;	
	}
	return old_NSClassFromString(aClassName);
}
NSString* new_NSStringFromClass(Class aClass){
	NSString* orig=old_NSStringFromClass(aClass);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromClass");
	WTAdd(orig,@"ClassName");
	WTSave;
	WTRelease;
	}
	return orig;
}

NSString* new_NSStringFromProtocol(Protocol* proto){
	NSString* orig=old_NSStringFromProtocol(proto);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromProtocol");
	WTAdd(orig,@"ProtocalName");
	WTSave;
	WTRelease;
	}
	return orig;
}

Protocol* new_NSProtocolFromString(NSString* namestr){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSProtocolFromString");
		WTAdd(namestr,@"ProtocalName");
		WTSave;
		WTRelease;	
	}
	return old_NSProtocolFromString(namestr);
}

NSString* new_NSStringFromSelector(SEL aSelector){
	NSString* orig=old_NSStringFromSelector(aSelector);
	if(WTShouldLog){
	WTInit(@"ObjCRuntime",@"NSStringFromSelector");
	WTAdd(orig,@"SelectorName");
	WTSave;
	WTRelease;
	}
	return orig;


}
SEL new_NSSelectorFromString(NSString* aSelectorName){
	if(WTShouldLog){
		WTInit(@"ObjCRuntime",@"NSSelectorFromString");
		WTAdd(aSelectorName,@"SelectorName");
		WTSave;
		WTRelease;	
	}
	return old_NSSelectorFromString(aSelectorName);

}
BOOL new_class_addMethod(Class cls, SEL name, IMP imp,const char *types){
	if(WTShouldLog){
    NSString* TypeString=[NSString stringWithUTF8String:types];
    NSString* ClassName;
    NSString* SelectorName=NSStringFromSelector(name);
    NSString* IMPAddress=[NSString stringWithFormat:@"%p",imp];
    NSString* Types=[NSString stringWithUTF8String:types];
    if(SelectorName!=nil&&[SelectorName isEqualToString:@""]==false){
        ClassName=NSStringFromClass(cls);
    }
    else{
        ClassName=@"WTFJH-UnknownClassName";
    }
    WTInit(@"ObjCRuntime",@"class_addMethod");
    WTAdd(TypeString,@"Type");
    WTAdd(ClassName,@"ClassName");
    WTAdd(SelectorName,@"SelectorName");
    WTAdd(IMPAddress,@"IMPAddress");
    WTAdd(Types,@"Types");
    WTSave;
    WTRelease;


    [TypeString release];
    [IMPAddress release];
    [Types release];
	}
    return old_class_addMethod(cls,name,imp,types);
    
}

BOOL new_class_addIvar(Class cls, const char *name, size_t size,uint8_t alignment, const char *types){
	if(WTShouldLog){
    NSString* ClassName=NSStringFromClass(cls);
    NSString* IvarName=[NSString stringWithUTF8String:name];
    NSString* Types=[NSString stringWithUTF8String:types];
    WTInit(@"ObjCRuntime",@"class_addIvar");
    WTAdd(ClassName,@"ClassName");
    WTAdd(IvarName,@"IvarName");
    WTAdd(Types,@"Types");
    WTSave;
    WTRelease;
    [IvarName release];
    [Types release];
	}
    
    return old_class_addIvar(cls,name,size,alignment,types);
    
}
Class new_objc_getClass(char* Name){
	if(WTShouldLog){
		NSString* ClassName=[NSString stringWithUTF8String:Name];
		WTInit(@"ObjCRuntime",@"objc_getClass");
		WTAdd(ClassName,@"ClassName");
		WTSave;
		WTRelease;
		[ClassName release];
	}
	return old_objc_getClass(Name);
}

IMP new_class_getMethodImplementation(Class cls, SEL name){
	IMP ret;
	if(WTShouldLog){
		NSString* ClassName=NSStringFromClass(cls);
		NSString* SELName=NSStringFromSelector(name);
		ret=old_class_getMethodImplementation(cls,name);
		NSString* IMPAddress=[NSString stringWithFormat:@"%p",ret];
		WTInit(@"ObjCRuntime",@"class_getMethodImplementation");
		WTAdd(ClassName,@"ClassName");
		WTAdd(SELName,@"SelectorName");
		WTAdd(IMPAddress,@"IMPAddress");
		WTSave;
		WTRelease;
		[IMPAddress release];
	}
	else{
		ret=old_class_getMethodImplementation(cls,name);
	}
	return ret;



}
IMP new_class_replaceMethod(Class cls, SEL name, IMP imp, const char *types){

	IMP ret;
	if(WTShouldLog){
		NSString* ClassName=NSStringFromClass(cls);
		NSString* SELName=NSStringFromSelector(name);
		ret=old_class_replaceMethod(cls,name,imp,types);
		NSString* NewIMPAddress=[NSString stringWithFormat:@"%p",ret];
		NSString* OldIMPAddress=[NSString stringWithFormat:@"%p",imp];
		WTInit(@"ObjCRuntime",@"class_replaceMethod");
		WTAdd(ClassName,@"ClassName");
		WTAdd(SELName,@"SelectorName");
		WTAdd(NewIMPAddress,@"NewIMPAddress");
		WTAdd(OldIMPAddress,@"OldIMPAddress");
		WTSave;
		WTRelease;
		[NewIMPAddress release];
		[OldIMPAddress release];
	}
	else{
		ret=old_class_replaceMethod(cls,name,imp,types);
	}
	return ret;




}
extern void init_ObjCRuntime_hook() {
   MSHookFunction((void*)NSClassFromString,(void*)new_NSClassFromString, (void**)&old_NSClassFromString);
   MSHookFunction((void*)NSStringFromClass,(void*)new_NSStringFromClass, (void**)&old_NSStringFromClass);
   MSHookFunction((void*)NSStringFromProtocol,(void*)new_NSStringFromProtocol, (void**)&old_NSStringFromProtocol);
   MSHookFunction((void*)NSProtocolFromString,(void*)new_NSProtocolFromString, (void**)&old_NSProtocolFromString);
   MSHookFunction((void*)NSStringFromSelector,(void*)new_NSStringFromSelector, (void**)&old_NSStringFromSelector);
   MSHookFunction((void*)NSSelectorFromString,(void*)new_NSSelectorFromString, (void**)&old_NSSelectorFromString);
   MSHookFunction((void*)class_addMethod,(void*)new_class_addMethod, (void**)&old_class_addMethod);
   MSHookFunction((void*)class_addIvar,(void*)new_class_addIvar, (void**)&old_class_addIvar);
   MSHookFunction((void*)objc_getClass,(void*)new_objc_getClass, (void**)&old_objc_getClass);
   MSHookFunction((void*)class_getMethodImplementation,(void*)new_class_getMethodImplementation, (void**)&old_class_getMethodImplementation);
   MSHookFunction((void*)class_replaceMethod,(void*)new_class_replaceMethod, (void**)&old_class_replaceMethod);

}
