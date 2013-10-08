module Jspidy

using DataFrames

if WORD_SIZE == 32
	import Base.filesize;
	filesize(path...) = return int32(stat(path...).size);
end

# import rawdata
function get()
	if !(isfile(pwd() * "/raw_data.csv") && int(strftime("%H", time()))-int(strftime("%H", mtime(pwd() * "/raw_data.csv"))) < 1)
		run(`wget -q -O $(pwd())/raw_data.csv http://www.gw2spidy.com/api/v0.9/csv/all-items/all`);
	end
	df = readtable(pwd() * "/raw_data.csv");
	return df;
end 

# process everything
function process{T<:DataFrame}(df::T; 
	header=["name"]::Array{ASCIIString,1},
	sby="margin"::ASCIIString,
	minsale=10000::Int,
	minoffer=10000::Int,
	minmargin=10::Int,
	rev=true::Bool)

#	@assert prod({in(header[i], colnames(df)) for i=1:length(header)});
	@assert in(sby, [colnames(df); "netprice"; "margin"; "margin_percent"]);

	sub_df = df[convert(BitArray, {df[i, "sale_availability"] .> minsale && df[i, "offer_availability"] .> minoffer for i=1:size(df,1)}), colnames(df)];

	c1 = DataFrame("netprice" = round(sub_df[:,"min_sale_unit_price"]*0.85, 2));
	c2 = DataFrame("margin" = round((c1[1] - sub_df[:, "max_offer_unit_price"]),2));
	c3 = DataFrame("margin_percent" = round(c2[1] ./ c1[1]*100 ,2));

	return sortby!([sub_df c1 c2 c3][c2[1] .>= minmargin, :], sby, rev ? Base.Order.Reverse : Base.Order.Forward)[[header; "netprice"; "margin"; "margin_percent"]];
end

#write csv to disk
function write{T<:DataFrame}(df::T)
	writetable(*(pwd() , (@windows ? "\\" : "/") , "gw2spidy ", strftime("%d.%m.%Y %HUhr", TmStruct(time())), ".csv"), df);
end

end