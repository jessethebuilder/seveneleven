function editAllTable(table_selector){
  this.table = $(table_selector);
  this.inputs = this.table.find('input');
  this.current_row_id;

  this.trackEdits = function(){
    var t = this;
    this.inputs.change(function(){
      var row = $(this).closest('.outer_row');
      t.current_row_id = row.attr('data-store-id');
      row.removeClass('edited');
      row.addClass('editing');
    });

    this.inputs.focus(function(){
      var new_row = $(this).closest('.outer_row');
      var store_id = new_row.attr('data-store-id');
      if(typeof t.current_row_id != 'undefined' && store_id != t.current_row_id){
        // if new row is selected
        var old_row = $('tr[data-store-id="' + t.current_row_id + '"]');
        var form = old_row.find('form');
        t.uploadFile(form, 'fz_image');
        form.submit();

      }
    });
  }

  this.uploadFile = function(form, field){
    var file_field = form.closest('tr').find('#na_store_' + field);
    // only 1 file per file field
    var file = file_field[0].files[0];
    if(typeof file != 'undefined'){
      this.readFile(file).then(function(file_data){
        var action = form.attr('action');

        $.ajax({
          url: action + '.js',
          method: 'PUT',
          data: {
            na_store: {
              fz_image: file_data
              // field: file_data
            }
          }
        });
      });
    }
  }

  this.readFile = function(file){
    return new Promise(function(fulfill, reject){
      var reader = new FileReader();
      reader.onload = function(e){
        var file_data = e.target.result;
        fulfill(file_data);
      }
      reader.readAsDataURL(file);
    });
  }

  this.showFzImageInput = function(link){
    var box = link.closest('.fz_image');
    var thumb = box.find('.thumb');
    var input = box.find('input[type="file"]');

    thumb.addClass('hidden');
    input.removeClass('hidden');
  }

  this.initFzImageEditControl = function(){
    var t = this;
    // Show file upload on edit image control click
    $('.edit_fz_image_control').click(function(e){
      e.preventDefault();

      t.showFzImageInput($(this));
    });
  }

  this.initFzImageDeleteControl = function(){
    var t = this;
    $('.delete_fz_image_control').click(function(e){
      e.preventDefault();

      var control = $(this);
      var outer_row = control.closest('.outer_row');
      var store_id = outer_row.attr('data-store-id');

      $.ajax({
        url: '/na_stores/' + store_id + '/delete_fz_image.js',
        method: 'delete',
        complete: function(){
          t.showFzImageInput(control);
        }
      });

    });
  }

  this.initFzImageControls = function(){
    this.initFzImageEditControl();
    this.initFzImageDeleteControl();
  }

  this.init = function(){
    this.trackEdits();
    this.initFzImageControls();
  }
}
