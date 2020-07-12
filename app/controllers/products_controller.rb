class ProductsController < ApplicationController
  def index
    vars = request.query_parameters
    unless vars['category_id']
      json_error 'Missing category_id'
      return
    end

    category_id = vars['category_id']&.to_i || -1
    unless category_id > 0
      json_error 'Invalid category_id, must be a positive integer'
      return
    end

    cat = nil
    begin
      cat = Category.find(category_id)
    rescue ActiveRecord::RecordNotFound
      json_error "No category with ID #{category_id}", 404
      return
    rescue
      json_error "Server error", 500
      return
    end

    descendant_ids = cat.descendant_ids
    descendant_ids << cat.id

    render :json => Product.where(category_id: descendant_ids)
  end

private
  def json_error(s, status=400)
    render :json => {error: s}, :status => status
  end

end
