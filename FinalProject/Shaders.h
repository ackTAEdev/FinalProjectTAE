/*
 
 File: Shaders.h
 
 Abstract: Shader utilities for compiling, linking and validating shaders.
 
*/

#ifndef SHADERS_H
#define SHADERS_H

#include <OpenGLES/ES2/gl.h>
#include <OpenGLES/ES2/glext.h>
#include <Foundation/Foundation.h>

/* Shader Utilities */
GLint compileShader(GLuint *shader, GLenum type, GLsizei count, NSString *file);
GLint linkProgram(GLuint prog);
GLint validateProgram(GLuint prog);
void destroyShaders(GLuint vertShader, GLuint fragShader, GLuint prog);

#endif /* SHADERS_H */
