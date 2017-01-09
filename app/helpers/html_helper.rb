module HtmlHelper
  def image_select(form_builder, image_attr, preview_version: :thumb, label: image_attr.to_s.titlecase, multiple: false, accepts_remote_url: true)
    render :partial => 'utilities/image_select.html.erb', :locals => {:f => form_builder,
                                                          :image_attr => image_attr, :preview_version => preview_version,
                                                          :multiple => multiple, :accepts_remote => accepts_remote_url,
                                                          :label => label}
  end

  #------------- Quick Options -------------------

  def quick_options(*options, ajax: false)
    html = initiate_quick_options
    html += '<ul class="quick_options">'

    options << yield if block_given?
    options.each do |o|
      html += '<li>'
      html += link_to o[0], o[1], remote: ajax
      html += '</li>'
    end
    html += '</ul>'
    #html += '</div>'

    html.html_safe
  end

  def initiate_quick_options

    "<script>$(document).ready(function(){
        toggleClassOnHover('.quick_options li', 'quick_option_selected');
      })</script>"
  end

  #------------ For Select tools -----------------------
  def for_select(collection, id_method, value_method, selected_items: nil, alphabetize: true)
    if block_given?
      options = collection.each.collect{ |item| [item.send(id_method), item.send(value_method), yield(item)] }
    else
      options = collection.each.collect{ |item| [item.send(id_method), item.send(value_method)] }
    end

    farm_select_options(options.sort_by{ |o| o[0].to_s }, selected_items: selected_items, alphabetize: false)
   end

  def array_for_select(arr, selected_items: nil, alphabetize: true)
    options = arr.each.collect{ |i| [i.to_s.titlecase, i] }
    farm_select_options(options, selected_items: selected_items, alphabetize: alphabetize)
    end

  def hash_for_select(hash, selected_items: nil, alphabetize: true)
    options = []
    hash.each{ |k, v| options << [v, k] }
    farm_select_options(options, selected_items: selected_items, alphabetize: alphabetize)
  end

  def array_of_hashes_for_select(array, id_key, value_key, selected_items: nil, alphabetize: true)
    options = array.collect{ |hash| [hash[id_key], hash[value_key]] }
    farm_select_options(options, selected_items: selected_items, alphabetize: alphabetize)
  end

  def hash_of_arrays_for_select(hash, data_attr: 'key', selected_items: nil, alphabetize: true)
    options = []
    hash.each do |k, v|
      v.each do |model|
        options << [model, model, {"data-#{data_attr}" => k}]
      end
    end
    farm_select_options(options, selected_items: selected_items, alphabetize: alphabetize)
  end

  def farm_select_options(options, selected_items: nil, alphabetize: true, escape: true)
    options.sort!{ |x, y| x[0] <=> y[0] } if alphabetize
    # options.each
    options_for_select(options, selected_items)
  end
end
