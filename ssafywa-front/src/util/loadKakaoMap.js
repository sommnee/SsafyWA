// src/utils/loadKakaoMap.js
export function loadKakaoMapScript(apiKey) {
    return new Promise((resolve, reject) => {
      if (typeof window.kakao !== 'undefined' && window.kakao.maps) {
        console.log('Kakao Maps API already loaded.');
        resolve(window.kakao);
        return;
      }
  
      console.log('Loading Kakao Maps API...');
      const script = document.createElement('script');
      script.src = `https://dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}&libraries=services`;
      script.onload = () => {
        console.log('Kakao Maps API script loaded.');
        window.kakao.maps.load(() => {
          console.log('Kakao Maps API initialized.');
          resolve(window.kakao);
        });
      };
      script.onerror = (error) => {
        console.error('Failed to load Kakao Maps API script:', error, error.message);
        reject(error);
      };
      document.head.appendChild(script);
    });
  }
  