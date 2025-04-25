// 图像识别处理模块
const RecognitionProcess = {
  // 当前识别类型
  currentType: 'general',
  
  // 识别类型映射
  typeMap: {
    general: { name: '通用物体识别', icon: 'fas fa-cube', color: '#007aff' },
    dish: { name: '菜品识别', icon: 'fas fa-utensils', color: '#ff9500' },
    animal: { name: '动物识别', icon: 'fas fa-paw', color: '#34c759' },
    plant: { name: '植物识别', icon: 'fas fa-leaf', color: '#5856d6' },
    fruit: { name: '果蔬识别', icon: 'fas fa-apple-alt', color: '#ff2d55' },
    landmark: { name: '地标识别', icon: 'fas fa-monument', color: '#af52de' },
    car: { name: '车型识别', icon: 'fas fa-car', color: '#007aff' }
  },
  
  // 设置识别类型
  setType: function(type) {
    if (this.typeMap[type]) {
      this.currentType = type;
      return true;
    }
    return false;
  },
  
  // 获取当前识别类型信息
  getCurrentTypeInfo: function() {
    return this.typeMap[this.currentType];
  },
  
  // 开始识别过程
  startRecognition: function(imageData) {
    return new Promise((resolve, reject) => {
      // 显示加载状态
      this.showLoadingState();
      
      // 根据当前类型调用相应的API
      let apiPromise;
      switch(this.currentType) {
        case 'general':
          apiPromise = ImageRecognitionAPI.generalObjectRecognition(imageData);
          break;
        case 'dish':
          apiPromise = ImageRecognitionAPI.dishRecognition(imageData);
          break;
        case 'animal':
          apiPromise = ImageRecognitionAPI.animalRecognition(imageData);
          break;
        case 'plant':
          apiPromise = ImageRecognitionAPI.plantRecognition(imageData);
          break;
        case 'fruit':
          apiPromise = ImageRecognitionAPI.fruitVegetableRecognition(imageData);
          break;
        case 'landmark':
          apiPromise = ImageRecognitionAPI.landmarkRecognition(imageData);
          break;
        case 'car':
          apiPromise = ImageRecognitionAPI.carRecognition(imageData);
          break;
        default:
          apiPromise = ImageRecognitionAPI.generalObjectRecognition(imageData);
      }
      
      // 处理API响应
      apiPromise
        .then(result => {
          // 隐藏加载状态
          this.hideLoadingState();
          
          // 保存到历史记录
          this.saveToHistory(imageData, result);
          
          // 返回结果
          resolve({
            type: this.currentType,
            typeInfo: this.getCurrentTypeInfo(),
            result: result
          });
        })
        .catch(error => {
          // 隐藏加载状态
          this.hideLoadingState();
          
          // 返回错误
          reject(error);
        });
    });
  },
  
  // 显示加载状态
  showLoadingState: function() {
    // 在实际应用中，这里会更新UI显示加载状态
    console.log('识别中...');
    
    // 创建加载指示器
    const loadingEl = document.createElement('div');
    loadingEl.id = 'recognition-loading';
    loadingEl.className = 'fixed inset-0 flex items-center justify-center bg-black bg-opacity-50 z-50';
    loadingEl.innerHTML = `
      <div class="bg-white rounded-lg p-6 flex flex-col items-center">
        <div class="loading mb-4"></div>
        <div class="text-lg font-medium">${this.getCurrentTypeInfo().name}中...</div>
        <div class="text-sm text-gray-500 mt-2">请稍候</div>
      </div>
    `;
    
    document.body.appendChild(loadingEl);
  },
  
  // 隐藏加载状态
  hideLoadingState: function() {
    // 在实际应用中，这里会更新UI隐藏加载状态
    console.log('识别完成');
    
    // 移除加载指示器
    const loadingEl = document.getElementById('recognition-loading');
    if (loadingEl) {
      loadingEl.remove();
    }
  },
  
  // 保存到历史记录
  saveToHistory: function(imageData, result) {
    // 在实际应用中，这里会将结果保存到本地存储或服务器
    console.log('保存到历史记录', result);
    
    // 这里只是模拟，实际应用中会有更复杂的逻辑
    const history = {
      id: 'hist' + Date.now(),
      type: this.currentType,
      result: result,
      image_data: imageData,
      timestamp: new Date().toLocaleString()
    };
    
    // 在实际应用中，这里会将历史记录保存到本地存储或服务器
    // localStorage.setItem('recognition_history', JSON.stringify([history, ...this.getHistory()]));
  },
  
  // 获取历史记录
  getHistory: function() {
    // 在实际应用中，这里会从本地存储或服务器获取历史记录
    // return JSON.parse(localStorage.getItem('recognition_history') || '[]');
    
    // 这里使用模拟数据
    return ImageRecognitionAPI.getRecognitionHistory();
  },
  
  // 清除历史记录
  clearHistory: function() {
    // 在实际应用中，这里会清除本地存储或服务器中的历史记录
    // localStorage.removeItem('recognition_history');
    console.log('历史记录已清除');
  }
};

// 导出模块
window.RecognitionProcess = RecognitionProcess; 