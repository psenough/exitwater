using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
[RequireComponent(typeof(Camera))]
public class ExitWater : MonoBehaviour {

    public Texture2D waterTexture1;
    [Range(0.1f, 1.0f)]
    public float fadeout1 = 0.2f;
    [Range(0.1f, 2.0f)]
    public float scrolldown1 = 0.12f;
    [Range(0.0f, 1.0f)]
    public float intensity1 = 0.25f;

    public Texture2D waterTexture2;
    [Range(0.1f, 1.0f)]
    public float fadeout2 = 0.12f;
    [Range(0.1f, 2.0f)]
    public float scrolldown2 = 0.2f;
    [Range(0.0f, 1.0f)]
    public float intensity2 = 0.25f;

    public Texture2D waterTexture3;
    [Range(0.1f, 1.0f)]
    public float fadeout3 = 0.22f;
    [Range(0.1f, 2.0f)]
    public float scrolldown3 = 0.52f;
    [Range(0.0f, 1.0f)]
    public float intensity3 = 0.25f;

    private Material material;
    private float startTime = 0.0f;
    private bool above = true;

    public Shader ExitWaterShader;

    void Awake()
    {
        //material = new Material(Shader.Find("Custom/ExitWater"));
        material = new Material(ExitWaterShader);
        startTime = Time.time;
    }

    void Update()
    {
        //Debug.Log("camera y: " + Camera.main.transform.position.y);
        float thisy = Camera.main.transform.position.y;
        if ((thisy > 0.0f) && (above == false))
        {
            above = true;
            startTime = Time.time;
        }
        if (thisy < 0.0f) {
            above = false;
            //startTime = 0.0f;
        }
    }

    void OnRenderImage(RenderTexture source, RenderTexture destination)
    {

        if (waterTexture1 != null)
        {
            waterTexture1.wrapMode = TextureWrapMode.Repeat;
            waterTexture1.filterMode = FilterMode.Bilinear;
        }

        if (waterTexture2 != null)
        {
            waterTexture2.wrapMode = TextureWrapMode.Repeat;
            waterTexture2.filterMode = FilterMode.Bilinear;
        }

        if (waterTexture3 != null)
        {
            waterTexture3.wrapMode = TextureWrapMode.Repeat;
            waterTexture3.filterMode = FilterMode.Bilinear;
        }

        material.SetTexture("_WaterTex1", waterTexture1);
        material.SetFloat("_fadeout1", fadeout1);
        material.SetFloat("_scrolldown1", scrolldown1);
        material.SetFloat("_intensity1", intensity1);

        material.SetTexture("_WaterTex2", waterTexture2);
        material.SetFloat("_fadeout2", fadeout2);
        material.SetFloat("_scrolldown2", scrolldown2);
        material.SetFloat("_intensity2", intensity2);

        material.SetTexture("_WaterTex3", waterTexture3);
        material.SetFloat("_fadeout3", fadeout3);
        material.SetFloat("_scrolldown3", scrolldown3);
        material.SetFloat("_intensity3", intensity3);

        material.SetFloat("_startTime", startTime);
        material.SetFloat("_currTime", Time.time);
        //material.SetFloat("_above", above ? 1.0f : 0.0f);

        Graphics.Blit(source, destination, material);
    }
}
