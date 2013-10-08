using Jspidy
using SQLite
using DataFrames
using Datetime

#db_name = "history.sqlite"
db_name = "./dev/test.sqlite";

connect(db_name);

raw = Jspidy.get();
# createtable(raw[:,1:7], name="const_data", infer=true);
# query("create table data_link (t1key INTEGER PRIMARY KEY, input_date)")


if size(raw,1) > query("select count(*) from const_data")[1,1]
	droptable("const_data");
	createtable(raw[:,1:7], name="const_data", infer=true);
end

dt = datetime("yyyy-MM-dd HH", string(now()));
var_data = raw[:, [1; 8:14]];
createtable(var_data, name="'$(string(dt))'", infer=true);

query("select * from '$(string(dt))'")