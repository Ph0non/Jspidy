Jspidy
======

Small script to process data from [gw2spidy](www.gw2spidy.com) for trading post flipping in the MMO [Guild Wars 2](https://www.guildwars2.com/).

## How to

Getting Julia from [Julialang.org](http://julialang.org/downloads/) or [github](https://github.com/JuliaLang/julia) . Further you need [wget](http://gnuwin32.sourceforge.net/packages/wget.htm) (Binaries and Dependencies for Windows) or `sudo apt-get install wget` for a lot of Linux distributions. I try a Julia-only solution with HTTPClient but it was terrible slow.

### First time running Julia
```
Pkg.init()
Pkg.add("DataFrames")
```
### Using Jspidy
* Load module: `using Jspidy`
* Get data: `x = Jspidy.get()`
* Process data: `y = Jspidy.process(x)`
* Write data as csv with timestamp: `Jspidy.write(y)`

`Jspidy.get()` create a `raw_data.csv` and update it, if the modification hour of the file is at last more than a hour ago. `Jspidy.process` returns a DataFrame with a specified header and additional useful columns like the netprice, margin and percentual margin of items. Further it accept additional arguments for a more detailed output, see below.

### Optional arguments for `Jspidy.process`
* `header = ["string1"; "string2"; "string3"; and so on]` (Default `["name"]`) — Columns and order of output spreadsheet. For all possible header options see [possible header options](#Possible header / sby options).
* `sby = "string"` (Default `"margin"`) — Sort spreadsheet respective to this column. For all possible options see [possible sby options](#Possible header / sby options).
* `minsale = int` (Default `10000`) — Minimum volume of sale offers.
* `minoffer = int` (Default `10000`) — Minimum volume of buy offers.
* `minmargin = int` (Default `10`) — Minimum margin.
* `rev = bool` (Default `true`) — Reverse ordering of column specified by `sby`.

### Example
```
julia> Jspidy.process(Jspidy.get(), header=["data_id"; "name"], sby="name", rev=false, minmargin=30)
12x5 DataFrame:
         data_id                                     name netprice margin margin(%)
[1,]       12451 "Bowl of Meat and Winter Vegetable Stew"   164.05  36.05     21.98
[2,]       12447               "Bowl of Spicy Meat Chili"     74.8   42.8     57.22
[3,]       43357                          "Dragon Coffer"   254.15  78.15     30.75
[4,]        9461                 "Master Maintenance Oil"   589.05  57.05      9.69
[5,]       12273                         "Minotaur Steak"    119.0   34.0     28.57
[6,]       38461                           "Pop Gun Skin"   376.55  75.55     20.06
[7,]       38469                     "Princess Wand Skin"    413.1  119.1     28.83
[8,]       38467                         "Slingshot Skin"    73.95  30.95     41.85
[9,]       38458                         "Toy Staff Skin"     69.7   38.7     55.52
[10,]      38460                         "Toy Sword Skin"     52.7   30.7     58.25
[11,]      36038                     "Trick-or-Treat Bag"    154.7   34.7     22.43
[12,]      38463                     "Wooden Dagger Skin"     78.2   32.2     41.18
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
