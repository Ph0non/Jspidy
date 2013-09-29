Jspidy
======

Small script to process data from www.gw2spidy.com for trading post flipping

# How to

Getting Julia from [Julialang.org](http://julialang.org/downloads/) or [github](https://github.com/JuliaLang/julia) . Further you need [wget](http://gnuwin32.sourceforge.net/packages/wget.htm) (Binaries and Dependencies for Windows) or `sudo apt-get install wget` for a lot of Linux distributions.

### First time running julia
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
* `header = ["string1"; "string2"; "string3"; and so on]` (Default `["name"]`) -- Columns and order of output spreadsheet. For all possible header options see .
* `sby = "string"` (Default `"margin"`) -- Sort spreadsheet respective to this column. For all possible options see .
* `minsale = int` (Default `10000`) -- Minimum volume of sale offers.
* `minoffer = int` (Default `10000`) -- Minimum volume of buy offers.
* `minmargin = int` (Default `10`) -- Minimum margin.
* `rev = bool` (Default `true`) -- Reverse ordering of column specified by `sby`.

### Example

