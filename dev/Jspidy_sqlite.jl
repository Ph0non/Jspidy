using Jspidy
using SQLite
using DataFrames

#db_name = "history.sqlite"
db_name = "./dev/test.sqlite";
table_name = "jtest";

connect(db_name);

db_data = Jspidy.process(Jspidy.get(), header=["data_id"; "name"; "max_offer_unit_price"; "min_sale_unit_price"], sby="data_id", rev=false);

createtable(db_data, name=table_name)


#Table
# data_id name max_offer_unit_price min_sale_unit_price netprice margin margin(%)



# 
#  data_id name rarity restriction_level img type_id sub_type_id price_last_changed max_offer_unit_price min_sale_unit_price offer_availability sale_availability sale_price_change_last_hour offer_price_change_last_hour