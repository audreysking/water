document.addEventListener('turbolinks:load', function() {
  // slider初期化
  var slider_elems = document.querySelectorAll('.slider');
  // intervalオプションで切り替え時間を3秒に変える
  var slider_options = {
    interval: 3000,
    indicators: false,
    height: 400
  }
   
  M.Slider.init(slider_elems, slider_options);

})
