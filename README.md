Jspidy
======

Small script to process data from [gw2spidy](www.gw2spidy.com) for trading post flipping in the MMO [Guild Wars 2](https://www.guildwars2.com/).

## How to

Getting Julia from [Julialang.org](http://julialang.org/downloads/) or [github](https://github.com/JuliaLang/julia) . Further you need [wget](http://gnuwin32.sourceforge.net/packages/wget.htm) ( _binaries_ and _dependencies_ for Windows) or `sudo apt-get install wget` for a lot of Linux distributions. I try a Julia-only solution with HTTPClient but it was terrible slow.

### First time running Julia
```
Pkg.init()
Pkg.add("DataFrames")
Pkg.checkout("DataFrames") (only neccessary for 32bit machines)
```
### Using Jspidy
* Load module: `using Jspidy`
* Get data: `x = Jspidy.get()`
* Process data: `y = Jspidy.process(x)`
* Write data as csv with timestamp: `Jspidy.write(y)`

`Jspidy.get()` creates a `raw_data.csv` and update it, if the modification hour of the file is at last more than an hour ago. `Jspidy.process` returns a DataFrame with a specified header and additional useful columns like the netprice, margin and percentual margin of items. Further it accepts additional arguments for a more detailed output, see below.

### Optional arguments for `Jspidy.process`
* `header = [:symbol1; :symbol2; :symbol3; and so on]` (Default `[:name]`) — Columns and order of output spreadsheet. For all possible header options see [possible header options](#possible-header--sby-options).
* `sby = :symbol` (Default `"margin"`) — Sort spreadsheet respective to this column. For all possible options see [possible sby options](#possible-header--sby-options).
* `minsale = int` (Default `10000`) — Minimum volume of sale offers.
* `minoffer = int` (Default `10000`) — Minimum volume of buy offers.
* `minmargin = int` (Default `10`) — Minimum margin.
* `rev_opt = bool` (Default `true`) — Reverse ordering of column specified by `sby`.

### Example
```
julia> Jspidy.process(Jspidy.get(), header=[:data_id; :name], sby=:name, rev_opt=false, minmargin=30)
|-------|---------|-------------------------------------|----------|--------|----------------|
| Row # | data_id | name                                | netprice | margin | margin_percent |
| 1     | 42006   | "Azurite Crystal"                   | 210.8    | 37.8   | 17.93          |
| 2     | 43357   | "Dragon Coffer"                     | 629.85   | 40.85  | 6.49           |
| 3     | 43360   | "Dragon's Breath Bun"               | 214.2    | 44.2   | 20.63          |
| 4     | 38302   | "Drop of Magic Glue"                | 143.65   | 42.65  | 29.69          |
| 5     | 38291   | "Giant Wintersday Gift"             | 351.05   | 34.05  | 9.7            |
| 6     | 12387   | "Ginger Pear Tart"                  | 64.6     | 30.6   | 47.37          |
| 7     | 38290   | "Large Wintersday Gift"             | 334.9    | 46.9   | 14.0           |
⋮
| 10    | 38461   | "Pop Gun Skin"                      | 103.7    | 52.7   | 50.82          |
| 11    | 8893    | "Powerful Potion of Undead Slaying" | 173.4    | 33.4   | 19.26          |
| 12    | 38469   | "Princess Wand Skin"                | 608.6    | 56.6   | 9.3            |
| 13    | 38136   | "Small Wintersday Gift"             | 334.9    | 44.9   | 13.41          |
| 14    | 19761   | "Soft Wood Dowel"                   | 140.25   | 37.25  | 26.56          |
| 15    | 24757   | "Superior Rune of the Undead"       | 153.85   | 58.85  | 38.25          |
| 16    | 38130   | "Tiny Snowflake"                    | 454.75   | 52.75  | 11.6           |
| 17    | 38463   | "Wooden Dagger Skin"                | 79.05    | 42.05  | 53.19          |

```

### Possible header / sby options
* `data_id`  
* `name`  
* `rarity`  
* `restriction_level`  
* `img`  
* `type_id`  
* `sub_type_id`  
* `price_last_changed`  
* `max_offer_unit_price`  
* `min_sale_unit_price`  
* `offer_availability`  
* `sale_availability`  
* `sale_price_change_last_hour`  
* `offer_price_change_last_hour`
