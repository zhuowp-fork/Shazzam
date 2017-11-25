sampler2D inputSampler : register(S0);
/// <summary>The center of the gradient. </summary>
/// <minValue>0,0</minValue>
/// <maxValue>1,1</maxValue>
/// <defaultValue>.5,.5</defaultValue>
float2 CenterPoint : register(C0);

/// <summary>The primary color of the gradient. </summary>
/// <defaultValue>Blue</defaultValue>
float4 StartColor : register(C1);

/// <summary>The secondary color of the gradient. </summary>
/// <defaultValue>Red</defaultValue>
float4 EndColor : register(C2);

/// <summary>The starting angle of the gradient, counterclockwise from X-axis</summary>
/// <minValue>0</minValue>
/// <maxValue>360</maxValue>
/// <defaultValue>0</defaultValue>
float StartAngle : register(C3);

/// <summary>The arc length angle of the gradient, counterclockwise from X-axis</summary>
/// <minValue>-360</minValue>
/// <maxValue>360</maxValue>
/// <defaultValue>360</defaultValue>
float ArcLength : register(C4);

static float4 transparent = float4(0, 0, 0, 0); // WPF uses pre-multiplied alpha everywhere internally for a number of performance reasons.
static float Pi = 3.141592f;

float4 lerp_rgba(float4 x, float4 y, float s)
{
    float a = lerp(x.a, y.a, s);
    float3 rgb = lerp(x.rgb, y.rgb, s) * a;
    return float4(rgb.r, rgb.g, rgb.b, a);
}

float angle_to_start(float2 uv)
{
    float2 v = uv - CenterPoint;
    int sign = ArcLength > 0 ? -1 : 1;
    float a = degrees(atan2(v.y, v.x)) * sign;
    a = StartAngle + a;
    if (a < 0)
    {
        return 360 + a;;
    }
    return a;
}

float interpolate(float min, float max, float value)
{
    if (min == max)
    {
        return 0.5f;
    }

    if (min < max)
    {
        return clamp((value - min) / (max - min), 0, 1);
    }

    return clamp((value - max) / (min - max), 0, 1);
}

float4 main(float2 uv : TEXCOORD) : COLOR
{
    if (abs(ArcLength) < 0.01)
    {
        return lerp_rgba(StartColor, EndColor, 0.5);
    }

    return lerp_rgba(
        StartColor,
        EndColor,
        interpolate(
            StartAngle,
            StartAngle + ArcLength,
            angle_to_start(uv)));
}
