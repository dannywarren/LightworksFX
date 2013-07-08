//--------------------------------------------------------------//
// Strobe.fx
//
// Cuts between foreground and background clips at repeated
// intervals.
//
// https://github.com/dannywarren/LightworksFX
//
// Danny Warren
// danny@dannywarren.com
//--------------------------------------------------------------//

int _LwksEffectInfo
<
   string EffectGroup = "GenericPixelShader";
   string Description = "Strobe";
   string Category    = "Mixes";
> = 0;


//--------------------------------------------------------------//
// Lightworks Values
//--------------------------------------------------------------//

float _Progress;


//--------------------------------------------------------------//
// Params
//--------------------------------------------------------------//

float StrobeSpeed
<
   string Description = "Speed";
   float MinVal       = 0.0;
   float MaxVal       = 1.0;
> = 0.5;

float StrobeStart
<
   string Description = "Start";
   float MinVal       = 0.0;
   float MaxVal       = 1.0;
> = 0.0;

float StrobeEnd
<
   string Description = "End";
   float MinVal       = 0.0;
   float MaxVal       = 1.0;
> = 0.5;


//--------------------------------------------------------------//
// Inputs
//--------------------------------------------------------------//

texture fg;
texture bg;
sampler FgSampler = sampler_state { Texture = <fg>; };
sampler BgSampler = sampler_state { Texture = <bg>; };


//--------------------------------------------------------------//
// Strobe
//--------------------------------------------------------------//

float4 Strobe_main( float2 xy1 : TEXCOORD1, float2 xy2 : TEXCOORD2 ) : COLOR
{
   float4 fg = tex2D( FgSampler, xy1 );
   float4 bg = tex2D( BgSampler, xy2 );

   // Lightworks only gives us a float that tracks the progress
   // of the effect over time.  To determine how often to strobe,
   // we will take the progress and multiply it by the speed param,
   // and then chop off everything but the remaining fraction.
   // This should give us a float that counts upwards and then
   // starts over again as the effect progresses.
   float ProgressTimer = frac( _Progress * ( StrobeSpeed * 100 ) );

   // If the current timer is within the range specified by the
   // duration parameter, then show the foreground clip.
   if ( ( ProgressTimer >= StrobeStart ) && ( ProgressTimer <= StrobeEnd ) )
   {
      return fg;
   }   

   // Otherwise return the background clip.
   return bg;
}


//--------------------------------------------------------------//
// Techniques
//--------------------------------------------------------------//

technique Strobe    
{
   pass SinglePass { PixelShader = compile PROFILE Strobe_main(); } 
}

