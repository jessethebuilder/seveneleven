function indicateOrder(table_selector){
  // Relies on classes set in activateTableMenu
  var table = $(table_selector);
  var selected = table.find('th').find('.selected');

  var direction = $(selected).hasClass('desc') ? "up" : "down"
  var indicator = $('<span></span>');
  indicator.addClass('glyphicon');
  indicator.addClass('glyphicon-chevron-' + direction);
  selected.append(indicator);
}

function activateTableMenu(table_selector, selected, direction){
  var table = $(table_selector);
  var headers = $(table).find('th').find('a');
  var loc = window.location;
  var path = loc.origin + loc.pathname;

  var next_direction = direction === "asc" ? "desc" : "asc";

  for(var i = 0; i < headers.length; i++){
    var h = $(headers[i]);
    var order_by = h.data('order-by');
    h.attr('href', path + '?order_by=' + order_by);

    if(order_by === selected){
      h.attr('href', h.attr('href') + '&order_direction=' + next_direction);
      h.addClass('selected');
      h.addClass(direction);
    }
  }

  indicateOrder(table_selector);
}

function updateCurrentStoreListOnCheck(store_type){
  // store_type used for routing AJAX request
  var selects = $('#' + store_type + '_store_table').find('.store_select');

  for(var i = 0; i < selects.length; i++){
    $(selects[i]).change(function(){
      if(this.checked){

      $.ajax({
          method: 'POST',
          url: '/store_lists/add_to_current?store_type=' + store_type + '&store_id=' + this.id
        });
      } else {
        $.ajax({
          method: 'POST',
          url: '/store_lists/remove_from_current?store_type=' + store_type + '&store_id=' + this.id
        });
      }
    });
  }
}
