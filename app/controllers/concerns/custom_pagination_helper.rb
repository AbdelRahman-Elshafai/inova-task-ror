module CustomPaginationHelper

    def jsonapi_meta(resources)

      { pagination: {
        current_page: resources.current_page,
        next_page: resources.next_page,
        prev_page: resources.prev_page,
        total_pages: resources.total_pages,
        total_count: resources.total_count
      } } if resources.respond_to?(:count)
    end
    def get_page_number(params)
      page_number = params[:page][:number].to_i
      page_number === 0 ? 1 : page_number
    end

    def get_page_size(params)
      page_size = params[:page][:size].to_i
      page_size === 0 ? 10 : page_size
    end

end



