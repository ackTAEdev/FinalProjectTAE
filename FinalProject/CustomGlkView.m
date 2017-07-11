//
//  CustomGlkView.m
//  FinalProject
//
//  Created by Akshay C Khanna on 11/07/2017.
//  Copyright © 2017 Akshay C Khanna. All rights reserved.
//

#import "CustomGlkView.h"

@implementation CustomGlkView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


#pragma mark
-(void)drawInRect:(CGRect)rect{
glClear(GL_COLOR_BUFFER_BIT);


//Draw a triangle

float *triangle = (float *)malloc(sizeof(float) * 6);
    triangle[0] = 0.0;
    triangle[2] = 1.0;
    triangle[3] = 0.0;
    triangle[4] = 0.0;
    triangle[5] = -1.0;
    
    
    glVertexAttribPointer(0, 2, GL_FLOAT, GL_FALSE, 0, triangle);
    
    glDrawArrays(GL_TRIANGLES, 0, 3);
    
}




@end
