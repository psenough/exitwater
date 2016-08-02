Shader "Custom/ExitWater" {
	Properties{
		_MainTex("Base (RGB)", 2D) = "white" {}

		_startTime("startTime", FLOAT) = 0
		_currTime("currTime", FLOAT) = 0
		//_above("above", FLOAT) = 0

		_WaterTex1("WaterTex1 (BW)", 2D) = "white" {}
		_fadeout1("fadeout1", FLOAT) = 0.2
		_scrolldown1("scrolldown1", FLOAT) = 0.2
		_intensity1("intensity1", FLOAT) = 0.75

		_WaterTex2("WaterTex2 (BW)", 2D) = "white" {}
		_fadeout2("fadeout2", FLOAT) = 0.2
		_scrolldown2("scrolldown2", FLOAT) = 0.2
		_intensity2("intensity2", FLOAT) = 0.75

		_WaterTex3("WaterTex3 (BW)", 2D) = "white" {}
		_fadeout3("fadeout3", FLOAT) = 0.2
		_scrolldown3("scrolldown3", FLOAT) = 0.2
		_intensity3("intensity3", FLOAT) = 0.75
	}
	SubShader{
		Pass{
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			uniform float _startTime;
			uniform float _currTime;
			//uniform float _above;

			sampler2D _WaterTex1;
			uniform float _fadeout1;
			uniform float _scrolldown1;
			uniform float _intensity1;

			sampler2D _WaterTex2;
			uniform float _fadeout2;
			uniform float _scrolldown2;
			uniform float _intensity2;

			sampler2D _WaterTex3;
			uniform float _fadeout3;
			uniform float _scrolldown3;
			uniform float _intensity3;

			sampler2D Ceto_OceanMask;

			float4 frag(v2f_img i) : COLOR{
				float4 c = tex2D(_MainTex, i.uv);
				float val = clamp((c.b*2.0 + c.g*1.25), 0.0, 1.0);
				float time = _currTime - _startTime;

				float4 wf1 = tex2D(_WaterTex1, float2(i.uv.x, i.uv.y + (time * _scrolldown1))) * smoothstep(1.0, 0.0, time * _fadeout1);
				float4 wf2 = tex2D(_WaterTex2, float2(i.uv.x, i.uv.y + (time * _scrolldown2))) * smoothstep(1.0, 0.0, time * _fadeout2);
				float4 wf3 = tex2D(_WaterTex3, float2(i.uv.x, i.uv.y + (time * _scrolldown3))) * smoothstep(1.0, 0.0, time * _fadeout3);

				float value = wf1.r*_intensity1 +wf2.r*_intensity2 + wf3.r*_intensity3;
				float4 com = tex2D(Ceto_OceanMask, i.uv);
				if (com.r > 0.45) {
					value = 0.0;
				}
				float4 result = tex2D(_MainTex, float2(i.uv.x + value, i.uv.y + value)) * 1.0;

				return result;
			}
			ENDCG
		}
	}

	/*SubShader{
		Tags{ "RenderType" = "Opaque" }

		CGPROGRAM
#pragma surface surf Lambert

	struct Input {
		float2 uv_MainTex;
		float2 uv_Water;
	};

	sampler2D _MainTex;
	sampler2D _Water;
	uniform float _Slide;

	void surf(Input IN, inout SurfaceOutput o)
	{
		//float time = _Slide + _Time.x;
		//float fader = smoothstep(1, 0.0, time * 7);
		//half4 waterflow = tex2D(_Water, float2(IN.uv_Water.x,IN.uv_Water.y + (time * 5)))*fader;
		//half4 col1 = tex2D(_MainTex, float2(IN.uv_MainTex.x + waterflow.r,IN.uv_MainTex.y + waterflow.r)) * 1;
		//o.Albedo = col1.rgb;
		//o.Albedo = float3(1.,0.,0.);
		//o.Alpha = 1;
		o.Albedo = tex2D(_MainTex, IN.uv_MainTex);
		o.Alpha = 0.5;
	}
	ENDCG
	}
		FallBack "Diffuse"*/
}