# run(`sqlite3 ./dev/test.db "create table t2 (t2key INTEGER PRIMARY KEY, data TEST)"`)

#db_name = "history.sqlite"
db_name = "./dev/test.db";
table_name = "jtest";
Jsdb{T<:String}(sqlex::T, dbname::T=db_name) = run(`sqlite3 $(dbname) "$(sqlex)"`)

cols = colnames(Jspidy.get());

# create table
Jsdb("create table $(table_name) (data_id INTEGER PRIMARY KEY, name TEXT, rarity INTEGER, restriction_level INTEGER, img TEXT, type_id INTEGER, sub_type_id INTEGER, price_last_changed DATE, max_offer_unit_price INTEGER, min_sale_unit_price INTEGER, offer_availability INTEGER, sale_availability INTEGER, sale_price_change_last_hour INTEGER, offer_price_change_last_hour INTEGER)")

# populate database
db_data = Jspidy.get();
col_string = replace("'" * string(colnames(db_data))[1:end-1] * "'", "\n", "','")
for i=1:size(db_data,1)
	val_string = replace("\"" * string(matrix(db_data[i,:]))[1:end-1] * "\"", "\t", "\",\"");
	Jsdb("insert into $(table_name) ($(col_string)) values ($(val_string))")
end

# read database
Jsdb("select * from jtest order by rowid");

# 
#  data_id name rarity restriction_level img type_id sub_type_id price_last_changed max_offer_unit_price min_sale_unit_price offer_availability sale_availability sale_price_change_last_hour offer_price_change_last_hour