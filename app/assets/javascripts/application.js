//= require jquery
//= require bootstrap
//= require jquery_ujs
// require jquery-ui/widgets/draggable
// require jquery-ui/widgets/droppable
//= require jquery-ui/widgets/sortable
//= require farm_shed/all
//= require turbolinks
//= require tables
//= require edit_all

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

//--- DragSortTable -------------------------------------------------------
function DragSortTable(selector){
  this.table = $(selector);
  this.body = this.table.find('tbody');

  this.buildStoresOrder = function(){
    var order = [];

    $(this.body).find('tr').each(function(){
      order.push($(this).data('sort-order-id'));
    });

    return order;
  }

  this.init = function(callback){
    var t = this;

    $(this.body).sortable({
      handle: '.drag_handle',
      start: function(e, ui){
        var item = $(ui.item);
        item.addClass('sorting');
      },
      stop: function(e, ui){
        var item = $(ui.item);
        item.removeClass('sorting');
        var order = t.buildStoresOrder();
        callback(order)
      }
    });
  }
}
