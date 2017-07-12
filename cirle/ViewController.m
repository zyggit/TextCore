//
//  ViewController.m
//  cirle
//
//  Created by zyg on 2017/7/12.
//  Copyright © 2017年 zyg. All rights reserved.
//

#import "ViewController.h"
#import "view.h"
#import <CoreText/CoreText.h>
@interface ViewController ()
@property(nonatomic,strong)view *myview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor= [UIColor grayColor];
    // Do any additional setup after loading the view, typically from a nib.
    _myview = [[view alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
    [self.view addSubview:_myview];
    UIImage*img =  [self addWatemarkTextAfteriOS7_WithLogoImage:[UIImage imageNamed:@"page-1-提示.png"] watemarkText:@"测试"];
    UIImage *newimg = [self watermarkImage:[UIImage imageNamed:@"page-1-提示.png"] withName:@"充电电池的" withFontSize:18];
    UIImageView *imgview = [[UIImageView alloc] initWithImage:newimg];
    imgview.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [self.view addSubview:imgview];
}

- (UIImage *)addWatemarkTextAfteriOS7_WithLogoImage:(UIImage *)logoImage watemarkText:(NSString *)watemarkText{
    int w = logoImage.size.width;
    int h = logoImage.size.height;
    UIGraphicsBeginImageContext(logoImage.size);
    [[UIColor whiteColor] set];
    [logoImage drawInRect:CGRectMake(0, 0, w, h)];
    UIFont * font = [UIFont systemFontOfSize:18.0];
    [watemarkText drawInRect:CGRectMake(10, 55, 130, 80) withAttributes:@{NSFontAttributeName:font,NSForegroundColorAttributeName:[UIColor whiteColor]}];
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIImage *)watermarkImage:(UIImage *)img withName:(NSString *)name withFontSize:(float)fontsize{
        int w = img.size.width;
        
        int h = img.size.height;
        
        int hypotenuse = 0;//画布对角边长
        
        float font = fontsize;
        
        hypotenuse = sqrt(w*w + h*h);
        
        name = [name stringByAppendingString:@"    "];
        
        int i = 0;
        
        while (i < 10)
        {//水印循环布满整个屏幕
            i++;
            
            CGSize detailSize = [name sizeWithFont:[UIFont systemFontOfSize:font] constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
            if (detailSize.width > hypotenuse)
            {
                break;
            }
            name = [name stringByAppendingString:name];
        }
        
        UIGraphicsBeginImageContext(img.size);
        
        [img drawInRect:CGRectMake(0, 0, w, h)];
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        [self MyDrawText:context rect:CGRectMake(0, 0, w, h) str:name font:font];
    
        UIImage *aimg = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        return aimg;
}
- (void)MyDrawText:(CGContextRef)myContext rect:(CGRect)contextRect str:(NSString*)waterStr font:(float)font
{
    float w, h;
    w = contextRect.size.width;
    h = contextRect.size.height;
    CGAffineTransform myTextTransform; // 2
    CGContextSetCharacterSpacing (myContext, 0); // 4
    CGContextSetTextDrawingMode (myContext, kCGTextFillStroke); // 5
    CGContextSetRGBFillColor (myContext, 0, 0, 1, 0.55); // 6
    CGContextSetRGBStrokeColor (myContext, 0, 0, 1, 0.55); // 7
    myTextTransform =  CGAffineTransformMakeRotation ((M_PI * 0.25)); // 8选择文字M_PI为π-180°
    CGContextSetTextMatrix (myContext, myTextTransform); // 9
    //
    UniChar *characters;
    CGGlyph *glyphs;
    CFIndex count;
    CTFontRef ctFont = CTFontCreateWithName(CFSTR("STHeitiSC-Light"), font, NULL);//
    CTFontDescriptorRef ctFontDesRef = CTFontCopyFontDescriptor(ctFont);
    CFNumberRef pointSizeRef = (CFNumberRef)CTFontDescriptorCopyAttribute(ctFontDesRef,kCTFontSizeAttribute);
    CGFontRef cgFont = CTFontCopyGraphicsFont(ctFont,&ctFontDesRef );
    CGContextSetFont(myContext, cgFont);
    CGFloat fontSize = font;
    NSString* str2 = waterStr;
    CFNumberGetValue(pointSizeRef, kCFNumberCGFloatType,&fontSize);
    CGContextSetFontSize(myContext, font*2);//字体大小并不是字号 在字体的基础上*2
    CGContextSetAlpha(myContext, 0.55);
    count = CFStringGetLength((CFStringRef)str2);
    characters = (UniChar *)malloc(sizeof(UniChar) * count);
    glyphs = (CGGlyph *)malloc(sizeof(CGGlyph) * count);
    CFStringGetCharacters((CFStringRef)str2, CFRangeMake(0, count), characters);
    CTFontGetGlyphsForCharacters(ctFont, characters, glyphs, count);
    CGContextScaleCTM(myContext, 1, -1);//画出来的文字会颠倒，使用这个方法给倒回来，参数意思为真正绘图坐标 = 参数*设置的坐标
    CGContextMoveToPoint(myContext, w/2, h/2);
    CGContextShowGlyphsAtPoint(myContext, 0, -h/2, glyphs, str2.length);
    CGContextShowGlyphsAtPoint(myContext, 0, -h, glyphs, str2.length);
    CGContextShowGlyphsAtPoint(myContext, h /2, -h, glyphs, str2.length);
    free(characters);
    free(glyphs);
    //    CGContextShowTextAtPoint(myContext, 40, 40, "only english", 9); // 10
}

@end
