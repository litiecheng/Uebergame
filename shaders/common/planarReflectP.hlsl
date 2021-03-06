//-----------------------------------------------------------------------------
// Copyright (c) 2012 GarageGames, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to
// deal in the Software without restriction, including without limitation the
// rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
// sell copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
// IN THE SOFTWARE.
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Structures                                                                  
//-----------------------------------------------------------------------------

#include "shaderModel.hlsl"

struct ConnectData
{
   float4 hpos            : TORQUE_POSITION;
   float2 texCoord   : TEXCOORD0;
   float4 tex2       : TEXCOORD1;
};


struct Fragout
{
   float4 col : TORQUE_TARGET0;
};

TORQUE_UNIFORM_SAMPLER2D(texMap, 0);
TORQUE_UNIFORM_SAMPLER2D(refractMap, 1);

//-----------------------------------------------------------------------------
// Main                                                                        
//-----------------------------------------------------------------------------
Fragout main( ConnectData IN )
{
   Fragout OUT;

   float4 diffuseColor = TORQUE_TEX2D( texMap, IN.texCoord );
   float4 reflectColor = TORQUE_TEX2DPROJ(refractMap, IN.tex2);

   OUT.col = diffuseColor + reflectColor * diffuseColor.a;

   return OUT;
}
