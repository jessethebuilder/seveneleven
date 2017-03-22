//= require jquery
//= require bootstrap
//= require jquery_ujs
//= require farm_shed/all
//= require turbolinks
//= require tables

function initStoreSearch(){
  // If a value is added to store_search input, redirect to store_search
  $('#store_search').blur(function(e){
    var val = $(this).val();
    if(val.length > 0){
      window.location = '/store_searches/' + val;
    }
  });
}

$(document).on("turbolinks:load", function(){
  initStoreSearch();
});

function padForTopNav(){
  var padding = $('#top_nav').height();
  $('body').css('padding-top', padding + 'px');
}

$(document).on("turbolinks:load", function(){
  padForTopNav();
});

$(window).resize(function(){
  padForTopNav();
});
