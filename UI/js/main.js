// 主要JavaScript功能
document.addEventListener("DOMContentLoaded", function() {
  // 初始化底部导航栏
  initTabNavigation();
  
  // 初始化识别类型选择
  initRecognitionTypeSelection();
  
  // 初始化拍照和选择图片按钮
  initCameraAndGalleryButtons();
  
  // 初始化历史记录项点击事件
  initHistoryItemClicks();
});

// 初始化底部导航栏
function initTabNavigation() {
  const tabs = document.querySelectorAll(".tab-item");
  
  tabs.forEach(tab => {
    tab.addEventListener("click", function() {
      const screen = this.dataset.screen;
      navigateToScreen(screen);
    });
  });
}

// 页面导航函数
function navigateToScreen(screen) {
  // 在iframe环境中，通知父窗口进行导航
  if (window.parent && window.parent.navigateTo) {
    window.parent.navigateTo(screen);
  } else {
    // 直接导航到对应页面
    window.location.href = `screens/${screen}.html`;
  }
}

// 初始化识别类型选择
function initRecognitionTypeSelection() {
  const recognitionTypes = document.querySelectorAll(".recognition-type");
  
  if (recognitionTypes.length > 0) {
    recognitionTypes.forEach(type => {
      type.addEventListener("click", function() {
        // 移除所有active类
        recognitionTypes.forEach(t => t.classList.remove("active"));
        
        // 添加active类到当前选中项
        this.classList.add("active");
        
        // 设置当前识别类型
        const typeValue = this.dataset.type;
        if (window.RecognitionProcess) {
          window.RecognitionProcess.setType(typeValue);
        }
      });
    });
  }
}

// 初始化拍照和选择图片按钮
function initCameraAndGalleryButtons() {
  const cameraButton = document.querySelector(".camera-button");
  const galleryButton = document.querySelector(".gallery-button");
  
  if (cameraButton) {
    cameraButton.addEventListener("click", function() {
      // 在实际应用中，这里会调用设备相机
      console.log("打开相机");
      simulateImageCapture();
    });
  }
  
  if (galleryButton) {
    galleryButton.addEventListener("click", function() {
      // 在实际应用中，这里会打开图片选择器
      console.log("打开相册");
      simulateImageSelection();
    });
  }
}

// 模拟图像捕获
function simulateImageCapture() {
  // 模拟拍照并进行识别
  if (window.RecognitionProcess) {
    // 使用模拟图像数据
    const imageData = "data:image/jpeg;base64,/9j/4AAQSkZJRgABAQEASABIAAD/...";
    
    // 开始识别过程
    window.RecognitionProcess.startRecognition(imageData)
      .then(result => {
        console.log("识别结果:", result);
        // 导航到结果页面
        navigateToScreen("results");
      })
      .catch(error => {
        console.error("识别失败:", error);
        alert("识别失败，请重试");
      });
  } else {
    // 如果RecognitionProcess不可用，直接导航到结果页面
    navigateToScreen("results");
  }
}

// 模拟图像选择
function simulateImageSelection() {
  // 与simulateImageCapture类似，但模拟从相册选择图片
  simulateImageCapture();
}

// 初始化历史记录项点击事件
function initHistoryItemClicks() {
  const historyItems = document.querySelectorAll(".history-item");
  
  if (historyItems.length > 0) {
    historyItems.forEach(item => {
      item.addEventListener("click", function() {
        const historyId = this.dataset.id;
        console.log("查看历史记录项:", historyId);
        
        // 导航到结果页面并传递历史记录ID
        navigateToScreen("results");
      });
    });
  }
}

// 在全局范围内提供导航函数
window.navigateToScreen = navigateToScreen;
