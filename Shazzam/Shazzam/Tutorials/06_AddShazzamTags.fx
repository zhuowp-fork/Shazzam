﻿/// These are Shazzam elements, they are not part of the HLSL specification
/// <description>Add Paramters</description>
/// <class>ChangeColor1</class>
/// =============================================================================

sampler2D ourImage : register(s0);

//  Shazzam contains a number of XML tags
//  that provide extra information for each top-level variable 
//   

/// <summary>Modifies the Red value.</summary> // appears in the Shazzam tooltips
/// <minValue>0</minValue>
/// <maxValue>1</maxValue>
/// <defaultValue>1</defaultValue>
float RedValue : register(C0);

/// <summary>Modifies the Green value.</summary> 
/// <minValue>0</minValue>
/// <maxValue>1</maxValue>
/// <defaultValue>.5</defaultValue>
float GreenValue : register(C1);
/// <summary>Modifies the Blue value.</summary> 
/// <minValue>0</minValue>
/// <maxValue>1</maxValue>
/// <defaultValue>.5</defaultValue>
float BlueValue : register(C2);
float4 main(float2 locationInSource : TEXCOORD) : COLOR
{
	// create a variable to hold our color
  float4 color;
  // get the color of the current pixel
  color = tex2D( ourImage , locationInSource.xy);


	// assign the variables
	color.r *= RedValue; 
  color.g *= GreenValue;
  color.b *= BlueValue;


// modify these variable at runtime in Shazzam with the controls in the 'Change Shader Settings' tab.



		return color;

}
