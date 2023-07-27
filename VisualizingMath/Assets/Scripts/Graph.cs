using UnityEngine;

public class Graph : MonoBehaviour
{
    [SerializeField]
    Transform pointPrefab;

    [SerializeField, Range(10, 100)]
    int resolution = 10;

    // 储存所有的cube点
    Transform[] points;

    private void Awake()
    {
        // -1~+1 距离除以cube个数resolution
        float step = 2f / resolution;

        var position = Vector3.zero;
        var scale = Vector3.one * step;

        // 创建数组
        points = new Transform[resolution];

        for (int i = 0; i < points.Length; i++)
        {
            // 设置函数
            // awake中设置x坐标
            position.x = (i + 0.5f) * step - 1f;

            // f(x) = x
            //position.y = position.x;
            // f(x) = x*x;
            //position.y = position.x * position.x;

            // f(x) = x*x*x;
            // update中设置y左边使其动态
            //position.y = position.x * position.x * position.x;


            // 储存实例出来的cube并获取
            Transform point = points[i] = Instantiate(pointPrefab);

            // 更新cube坐标
            point.localPosition = position;
            point.localScale = scale;
            // set parent
            point.SetParent(this.transform, false);
        }
    }

    private void Update()
    {
        float time = Time.time;
        for (int i = 0; i < points.Length; i++)
        {
            Transform point = points[i];
            // 无法修改localPosition因为这是属性，获取的只是坐标的一份拷贝而不是引用
            Vector3 position = point.localPosition;

            // 设置一个sin函数,并跟随时间变化
            position.y = Mathf.Sin(Mathf.PI * (position.x + time));
            point.localPosition = position;

        }
    }
}