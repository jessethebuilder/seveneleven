module StoreListsHelper
  def is_in_current_store_list?(store)
    store_type = store.class.name.pluralize.underscore
    current_store_list.send(store_type).include?(store)
  end
end
