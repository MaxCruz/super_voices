module SitesHelper

    def my_page_entries_info(collection, n, options = {})
        entry_name = options[:entry_name] || (collection.empty?? 'item' :
                                              collection.first.class.name.split('::').last.titleize)
        if (collection.total_pages - n) < 2
            case collection.size
            when 0; "No #{entry_name.pluralize} found"
            else; "Displaying all #{entry_name.pluralize}"
            end
        else
            %{Displaying %d - %d of %d #{entry_name.pluralize}} % [
                collection.offset + 1,
                collection.offset + collection.length,
                (collection.total_entries - n)
            ]
        end
    end

end
