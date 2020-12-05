### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 331d6606-35ee-11eb-3765-e7860cf35704
required_fields = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])

# ╔═╡ 5bf36404-35ee-11eb-2709-ffa968432899
lines = open("input.txt") do f
	readlines(f)
end

# ╔═╡ 9a9b207a-35ee-11eb-0c74-51bb9c9da637
function count_valid(lines, validator)
	valid = 0
	fields = Dict()
	for l in lines
		if isempty(l)
			if validator(fields)
				println(fields)
				valid += 1
			end
			fields = Dict()
		else
			merge!(fields, Dict(tuple(split(grp, ":")...) for grp in split(l)))
		end
	end
	return valid
end

# ╔═╡ 2d4d109a-35ef-11eb-132e-85d79bd91a1e
count_valid(lines, x -> issubset(required_fields, keys(x)))

# ╔═╡ 095da246-35f2-11eb-1055-01c68412ed73
hgt_regex = r"(?<height>\d+)(?<unit>cm|in)"

# ╔═╡ ffcfcc74-35ef-11eb-0c64-850777799123
regexes = Dict(
	"byr" => r"[0-9]{4}",
	"iyt" => r"[0-9]{4}",
	"eyr" => r"[0-9]{4}",
	"hcl" => r"\#[0-9a-f]{6}",
	"ecl" => r"amb|blu|brn|gry|grn|hzl|oth",
	"pid" => r"[0-9]{9}"
)

# ╔═╡ 5f1a6dae-3688-11eb-2e0f-c55e8df840cd
function fullmatch(regex, string)
	m = match(regex, string)
	if m != nothing && m.match == string
		return m
	else
		return nothing
	end
end

# ╔═╡ 9a8deca8-35ef-11eb-060e-abd74058a5c7
function valid_map(d)
	if !issubset(required_fields, keys(d))
		return false
	end
	for (k, v) in pairs(d)
		if haskey(regexes, k) && fullmatch(regexes[k], v) == nothing
			return false
		end
	end
	m = fullmatch(hgt_regex, d["hgt"])
	if m == nothing
		return false
	end
	if m[:unit] == "cm" 
		if !(150 <= parse(Int, m[:height]) <= 193)
			return false
		end
	elseif m[:unit] == "in"
		if !(59 <= parse(Int, m[:height]) <= 76)
			return false
		end
	else
		throw("error") 
	end
	return 1920 <= parse(Int, d["byr"]) <= 2002 &&
		2010 <= parse(Int, d["iyr"]) <= 2020 &&
		2020 <= parse(Int, d["eyr"]) <= 2030
end

# ╔═╡ ed306e3e-35ef-11eb-182e-d79f2d59f2b7
count_valid(lines, valid_map)

# ╔═╡ Cell order:
# ╠═331d6606-35ee-11eb-3765-e7860cf35704
# ╠═5bf36404-35ee-11eb-2709-ffa968432899
# ╠═9a9b207a-35ee-11eb-0c74-51bb9c9da637
# ╠═2d4d109a-35ef-11eb-132e-85d79bd91a1e
# ╠═095da246-35f2-11eb-1055-01c68412ed73
# ╠═ffcfcc74-35ef-11eb-0c64-850777799123
# ╠═5f1a6dae-3688-11eb-2e0f-c55e8df840cd
# ╠═9a8deca8-35ef-11eb-060e-abd74058a5c7
# ╠═ed306e3e-35ef-11eb-182e-d79f2d59f2b7
