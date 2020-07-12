# README


## Requirements:
- Ruby 2.6.5
- Mysql 8.0

### Nice to have
Set MySQL to UTC:
- `SET GLOBAL time_zone = '+00:00';`

## Setup:
1. Checkout the repo
2. Install the requirements
3. `bundle install`
4. Create a database with the name `jul_categories_api_development`
5. Initialize the DB: `rails db:migrate db:seed`
6. Run the server: `rails server -b 0.0.0.0 -p 3000 -e development`
7. Get all products under the "Women" category:

   `curl http://localhost:3000/api/products?category_id=1`
   or
   `curl http://localhost:3000/api/products?category_name=Women`
