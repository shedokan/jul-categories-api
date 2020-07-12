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


## Things to improve:
- The [Ancestry gem](https://github.com/stefankroes/ancestry) was chose for simplicity and reliabilty(tested already, and used by many).

  In this sample project it's ok, using path based trees has many drawbacks, mainly: enforcing and validating the data, indexing and updating are slower(increases exponentially with branch length) and there's a limit on branch length.
  
  I would tend towards having another table for the relationship between each category and all of it's decendants - yes more rows, but given the fact they are fixed size integers I would expect faster indexing(not sure how MySQL is built though) and maybe even smaller index size in comparison with the VARCHAR index. As a bonus, all category -> decendant category relationships might even be kept in memory if the categories table is "small" enough.
  
  Needs more testing and a bigger dataset to see if it's worth the hassle and time spent :)
