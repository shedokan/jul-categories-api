class ProductsController < ApplicationController
  def index
    vars = request.query_parameters
    if vars['category_id'] && vars['category_name']
      json_error 'Cannot supply both category_id and category_name'
      return
    end

    cat = nil
    if vars['category_id']
      index_by_id vars['category_id']
    elsif vars['category_name']
      index_by_name vars['category_name']
    else
      json_error 'Missing category_id or category_name'
      return
    end
  end

private
  def json_error(s, status=400)
    render :json => {error: s}, :status => status
  end

  def index_by_id(category_id)
    category_id = category_id&.to_i || -1
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

    return_products cat
  end

  def index_by_name(category_name)
    cat = nil
    begin
      cat = Category.find_by(name: category_name)
    rescue ActiveRecord::RecordNotFound
      json_error "No category with name #{category_id}", 404
      return
    rescue
      json_error "Server error", 500
      return
    end

    return_products cat
  end

  def return_products(cat)
    descendant_ids = cat.descendant_ids
    descendant_ids << cat.id

    render :json => Product.where(category_id: descendant_ids)
  end
end
