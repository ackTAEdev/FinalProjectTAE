/*
 
 File: matrix.h
 
 Abstract: simple 4x4 matrix computations
 
 */

#ifndef MATRIX_H
#define MATRIX_H

//Identity Matrix
void mat4f_LoadIdentity(float* m);
//Scale
void mat4f_LoadScale(float* s, float* m);

//Rotation X
void mat4f_LoadXRotation(float radians, float* mout);

//Rotation Y
void mat4f_LoadYRotation(float radians, float* mout);

//Rotation Z
void mat4f_LoadZRotation(float radians, float* mout);

//Rotation Load
void mat4f_LoadRotation(float* mout, float deg, float xAxis, float yAxis, float zAxis);

//Translation
void mat4f_LoadTranslation(float* t, float* mout);

//Perspective
void mat4f_LoadPerspective(float fov_radians, float aspect, float zNear, float zFar, float* mout);

//Ortho
void mat4f_LoadOrtho(float left, float right, float bottom, float top, float near, float far, float* mout);

//Multiply Matrix
void mat4f_MultiplyMat4f(const float* a, const float* b, float* mout);

#endif /* MATRIX_H */
