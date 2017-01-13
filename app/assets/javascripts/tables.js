var query_object;
var table;

function activateTable(table_selector, default_order_by, default_order_direction){
  // Entry Point
  // Set globals

  query_object = queryStringToObject();
  if(!query_object['order_by']){
    query_object['order_by'] = default_order_by;
  }

  if(!query_object['order_direction']){
    query_object['order_direction'] = default_order_direction;
  }

  table = $(table_selector);

  activateSortByLinks();

  activateFilterTerms();
}

function activateFilterTerms(){
  var headers = $(table).find('a[data-filter-by]');
  // var query_object = queryStringToObject();
  buildFilterInputs(headers, query_object);
  activateFilterInputs(headers, query_object);
  activateFilterTermClearer();
  selectAllOnSelectAll(table);
}

function activateSortByLinks(){
  var headers = $(table).find('th').find('a');
  var loc = window.location;
  var path = loc.origin + loc.pathname;

  // order_by and direction
  var selected = query_object['order_by'];
  var direction = query_object['order_direction'];
  var next_direction = direction === "asc" ? "desc" : "asc";

  var filter_bys = query_object['filter_bys'];
  var filter_terms = query_object['filter_terms'];

  for(var i = 0; i < headers.length; i++){
    var h = $(headers[i]);
    var order_by = h.data('order-by');
    var url = path + '?order_by=' + order_by
    if(filter_bys){
      url = url + "&filter_bys=" + filter_bys + "&filter_terms=" + filter_terms;
    }

    h.attr('href', url);

    if(order_by === selected){
      var url = h.attr('href') + '&order_direction=' + next_direction;
      h.attr('href', url);
      h.addClass('selected');
      h.addClass(direction);
    }
  }

  indicateOrder();
}

function buildFilterInputs(headers){
  for(var i = 0; i < headers.length; i++){
    var h = $(headers[i]);
    var key = h.data('filter-by');

    var e = $('<input type="text" class="form-control"></input>');
    e.addClass('filter_by_input');
    e.attr('name', key);
    e.attr('id', key);

    if(query_object['filter_bys'] && query_object['filter_terms']){
      var bys = query_object['filter_bys'].split(',');
      var terms = query_object['filter_terms'].split(',');
      for(var j = 0; j < bys.length; j++){
        if(bys[j] === key){
          e.val(terms[j]);
        }
      }
    }
  $(e).insertBefore(headers[i]);
 }
}

function activateFilterInputs(){
  var inputs = $('.filter_by_input');

  for(var i = 0; i < inputs.length; i++){
    var input = $(inputs[i]);
    input.on('change', function(e){
      // console.log(e);
      // if(this.value){

        var loc = window.location;
        var order_by = query_object['order_by'];
        var order_direction = query_object['order_direction'];

        var bys = [];
        var terms = [];
        for(var j = 0; j < inputs.length; j++){
          if(inputs[j].value){
            var input = $(inputs[j]);
            bys.push(input.attr('name'));
            terms.push(input.val());
          }
        }
        var path = loc.origin + loc.pathname + '?order_by=' + order_by +
                   '&order_direction=' + order_direction

        if(bys.length > 0){
          path = path + '&filter_bys=' +
          bys.join(',') + "&filter_terms=" + terms.join(',');
        }

        window.location = path;
      // }
    });
  }
}

function indicateOrder(){
  // Relies on classes set in activateTableMenu
  var selected = table.find('th').find('.selected');

  var direction = $(selected).hasClass('desc') ? "up" : "down"
  var indicator = $('<span></span>');
  indicator.addClass('glyphicon');
  indicator.addClass('glyphicon-chevron-' + direction);
  selected.append(indicator);
}

function activateFilterTermClearer(){
  var header = table.find('th:first');
  var box = $('<div class="filter_term_clearer_box"></div>');
  var clear_link = $('<a href="#" class="filter_term_clearer">Clear Filters</a>');
  box.append(clear_link);
  clear_link.click(function(e){
    e.preventDefault();
    clearFilterTerms();
  });
  header.prepend(box);

}

function clearFilterTerms(){
  var path = window.location.origin + window.location.pathname +
            "?order_by=" + query_object['order_by'] + "&order_direction=" +
            query_object['order_direction'];
  window.location = path;
}

//------------- Select All -----------------------------------


function selectAllOnSelectAll(table){
  var select_all = table.find('.select_all_stores');
  setSelectAll(select_all);

  select_all.on('change', function(){
    var selects = table.find('.store_select');
    var bool_select;

    if(this.checked){
      bool_select = true;
    } else {
      bool_select = false;
    }

    for(var i = 0; i < selects.length;  i++){
      var select = $(selects[i]);
      if(select.prop('checked') != bool_select){
        select.prop('checked', bool_select);
        select.trigger('change');
      }
    }
  });
}

function setSelectAll(select_all){
  var selects = $('.store_select');
  for(var i = 0; i < selects.length; i++){
    if(!selects[i].checked){
      select_all.prop('checked', false);
      return false;
    }
  }
  select_all.prop('checked', true);
  return true;
}

//------------------- Update Playlist --------------------------------

function updateCurrentPlaylistOnCheck(store_type){
  // store_type used for routing AJAX request
  var selects = $('#' + store_type + '_store_table').find('.store_select');

  for(var i = 0; i < selects.length; i++){
    $(selects[i]).change(function(){
      if(this.checked){

      $.ajax({
          method: 'POST',
          url: '/playlists/add_to_current?store_type=' + store_type + '&store_id=' + this.id
        });
      } else {
        $.ajax({
          method: 'POST',
          url: '/playlists/remove_from_current?store_type=' + store_type + '&store_id=' + this.id
        });
      }
    });
  }
}
