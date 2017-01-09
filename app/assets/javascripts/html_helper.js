function toggleClassOnHover(selector, klass){
  $(selector).hover(function(){
    $(this).addClass(klass);
  }, function(){
    $(this).removeClass(klass);
  });
}
