using Jspidy
using SQLite
using DataFrames
using Datetime

db_name = "history.sqlite";
SQLite.connect(pwd() * "/dev/" * db_name);

# save all constant data for saving disk space 
raw = Jspidy.get();
# drop table of const data and create new for additional items
if size(raw,1) > query("select count(*) from const_data")[1,1]
	droptable("const_data");
	createtable(raw[:,1:7], name="const_data", infer=true);
end

# timestamp
dt = string(today(), " ", hour(now()));
#dt = datetime("yyyy-MM-dd HH", string(now()));
var_data = raw[:, [1; 8:14]];
# save variable data
createtable(var_data, name="'$(string(dt))'", infer=true);

query("select * from '$(string(dt))'") 
