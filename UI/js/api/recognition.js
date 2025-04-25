// 图像识别API交互模块
const ImageRecognitionAPI = {
  // 通用物体识别
  generalObjectRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 1234567890,
          result_num: 5,
          result: [
            { keyword: "笔记本电脑", score: 0.97, root: "电子产品" },
            { keyword: "MacBook", score: 0.92, root: "电子产品" },
            { keyword: "电脑", score: 0.89, root: "电子产品" },
            { keyword: "办公设备", score: 0.78, root: "办公用品" },
            { keyword: "科技产品", score: 0.75, root: "电子产品" }
          ]
        });
      }, 1500);
    });
  },
  
  // 菜品识别
  dishRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 2345678901,
          result_num: 5,
          result: [
            { name: "红烧肉", probability: 0.96, calorie: "289kcal/100g" },
            { name: "东坡肉", probability: 0.89, calorie: "302kcal/100g" },
            { name: "梅菜扣肉", probability: 0.82, calorie: "278kcal/100g" },
            { name: "回锅肉", probability: 0.76, calorie: "312kcal/100g" },
            { name: "肉类菜肴", probability: 0.72, calorie: "290kcal/100g" }
          ]
        });
      }, 1500);
    });
  },
  
  // 动物识别
  animalRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 3456789012,
          result: [
            { name: "金毛犬", score: 0.98, baike_info: { description: "金毛寻回犬是单猎犬，比较流行的狗的品种。在猎捕野禽的寻回犬中培养出来的，游泳的续航力极佳。" } },
            { name: "拉布拉多犬", score: 0.87, baike_info: { description: "拉布拉多猎犬是一种中大型犬类，是非常受欢迎的家犬之一，因原产地在加拿大的纽芬兰与拉布拉多省而得名。" } },
            { name: "狗", score: 0.85, baike_info: { description: "狗是一种家养的肉食动物，是应用最广泛的家畜之一，具有嗅觉灵敏、听觉发达、视觉敏锐等特点。" } }
          ]
        });
      }, 1500);
    });
  },
  
  // 植物识别
  plantRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 4567890123,
          result: [
            { name: "熊童子", score: 0.99, baike_info: { description: "熊童子是景天科拟石莲花属多肉植物，原产于墨西哥。叶片呈莲座状排列，叶色灰绿，叶尖有红褐色的小尖，叶缘有白色的睫毛，远看犹如小熊的脚掌，故名"熊童子"。" } },
            { name: "景天科植物", score: 0.95, baike_info: { description: "景天科是双子叶植物纲石竹目下的一科，有130属1500种，全世界分布，我国有33属270种。" } },
            { name: "多肉植物", score: 0.92, baike_info: { description: "多肉植物是指植物的根、茎、叶三种营养器官中，至少有一种是肥厚多汁并且具备储藏大量水分功能的植物。" } }
          ]
        });
      }, 1500);
    });
  },
  
  // 果蔬识别
  fruitVegetableRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 5678901234,
          result: [
            { name: "苹果", score: 0.98, nutrition: { calorie: "52kcal/100g", protein: "0.3g/100g", fat: "0.2g/100g", carbohydrate: "13.7g/100g", vitamin_c: "4mg/100g" } },
            { name: "红富士", score: 0.92, nutrition: { calorie: "54kcal/100g", protein: "0.3g/100g", fat: "0.2g/100g", carbohydrate: "14.1g/100g", vitamin_c: "4.2mg/100g" } },
            { name: "青苹果", score: 0.85, nutrition: { calorie: "50kcal/100g", protein: "0.3g/100g", fat: "0.2g/100g", carbohydrate: "13.3g/100g", vitamin_c: "3.8mg/100g" } }
          ]
        });
      }, 1500);
    });
  },
  
  // 地标识别
  landmarkRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 6789012345,
          result: {
            landmark: "埃菲尔铁塔",
            score: 0.97,
            location: "法国巴黎",
            baike_info: { description: "埃菲尔铁塔是一座位于法国巴黎战神广场的镂空结构铁塔，于1889年建成，高300米，天线高24米，总高324米。" }
          }
        });
      }, 1500);
    });
  },
  
  // 车型识别
  carRecognition: function(imageData) {
    return new Promise((resolve) => {
      setTimeout(() => {
        resolve({
          log_id: 7890123456,
          result: [
            { name: "特斯拉Model 3", score: 0.98, year: "2021", baike_info: { description: "特斯拉Model 3是特斯拉公司推出的一款纯电动轿车，是特斯拉公司的第三款车型。" } },
            { name: "特斯拉", score: 0.95, year: "2021", baike_info: { description: "特斯拉公司是一家美国电动汽车及能源公司，产销电动汽车、太阳能板、及储能设备。" } },
            { name: "电动汽车", score: 0.92, year: "2021", baike_info: { description: "电动汽车是指以车载电源为动力，用电机驱动车轮行驶，符合道路交通、安全法规各项要求的车辆。" } }
          ]
        });
      }, 1500);
    });
  },
  
  // 获取识别历史
  getRecognitionHistory: function() {
    return [
      {
        id: "hist001",
        type: "plant",
        result: { name: "熊童子", score: 0.99 },
        image_url: "https://images.unsplash.com/photo-1520412099551-62b6bafeb5bb?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHBsYW50fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-15 14:30"
      },
      {
        id: "hist002",
        type: "qrcode",
        result: { content: "https://example.com", score: 1.0 },
        image_url: "https://images.unsplash.com/photo-1588412079929-790f9ef0d8e6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHFyJTIwY29kZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-15 11:15"
      },
      {
        id: "hist003",
        type: "text",
        result: { text: "英文文档", score: 0.95 },
        image_url: "https://images.unsplash.com/photo-1544947950-fa07a98d237f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJvb2t8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-14 16:45"
      },
      {
        id: "hist004",
        type: "fruit",
        result: { name: "苹果", score: 0.98 },
        image_url: "https://images.unsplash.com/photo-1560806887-1e4cd0b6cbd6?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8YXBwbGV8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-14 12:20"
      },
      {
        id: "hist005",
        type: "landmark",
        result: { name: "埃菲尔铁塔", score: 0.97 },
        image_url: "https://images.unsplash.com/photo-1511739001486-6bfe10ce785f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8ZWlmZmVsJTIwdG93ZXJ8ZW58MHx8MHx8&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-09 09:30"
      },
      {
        id: "hist006",
        type: "card",
        result: { text: "名片", score: 0.94 },
        image_url: "https://images.unsplash.com/photo-1577563908411-5077b6dc7624?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YnVzaW5lc3MlMjBjYXJkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=800&q=60",
        timestamp: "2023-10-08 15:10"
      }
    ];
  }
};

// 导出API模块
window.ImageRecognitionAPI = ImageRecognitionAPI; 