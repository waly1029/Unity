// 声明一个自定义Shader，名为"Graph/Point Surface"
Shader "Graph/Point Surface" {

    // 声明该Shader的属性，这里只有一个属性"_Smoothness"，范围是0到1，默认值为0.5
    Properties {
        _Smoothness ("Smoothness", Range(0, 1)) = 0.5
    }

    // 定义渲染器的子着色器
    SubShader {
        // 使用CG编程语言
        CGPROGRAM
        // 声明使用的表面着色器为Standard，同时启用完整前向渲染阴影
        #pragma surface ConfigureSurface Standard fullforwardshadows
        // 声明渲染目标版本为3.0
        #pragma target 3.0

        // 定义输入结构体Input，其中包含float3类型的worldPos变量
        struct Input {
            float3 worldPos;
        };

        // 声明一个float类型的变量_Smoothness，用于存储属性中的"_Smoothness"值
        float _Smoothness;

        // 定义函数ConfigureSurface，它接收Input类型的input参数和inout修饰的SurfaceOutputStandard类型的surface参数
        void ConfigureSurface(Input input, inout SurfaceOutputStandard surface) {
            // 将input的worldPos赋值给表面输出的Albedo，即使用世界坐标作为表面的漫反射颜色
            // x red
            // y green
            // z blue
            surface.Albedo.rg = saturate(input.worldPos.xy * 0.5 + 0.5);
            // 将_Smoothness赋值给表面输出的Smoothness，即使用属性中定义的"_Smoothness"作为表面的平滑度值
            surface.Smoothness = _Smoothness;
        }

        // 结束CG编程部分
        ENDCG
    }
    // 如果上面的子着色器不支持，则回退使用Diffuse着色器
    FallBack "Diffuse"
}
