### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 28e42822-36e9-11eb-00e6-e5ade6b555e3
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 7ae5962e-36e9-11eb-015c-39e4f676965c
function replace_many(str, replacements)
	for r in replacements
		str = replace(str, r)
	end
	return str
end

# ╔═╡ 9a31905c-36e9-11eb-16e3-0d84b55d3457
row_replacements = ["B" => "1", "F" => "0"]

# ╔═╡ be7d1132-36e9-11eb-3465-5dc519011fcb
seat_replacements = ["R" => "1", "L" => "0"]

# ╔═╡ 4d9d7448-36e9-11eb-2b82-b707afa6cfea
function decode_pass(pass)
	row_string = pass[1:7]
	row_num = replace_many(row_string, row_replacements)
	row = parse(Int, row_num; base=2)
	
	seat_string = pass[8:10]
	seat_num = replace_many(seat_string, seat_replacements)
	seat = parse(Int, seat_num; base=2)
	
	return (row, seat)
end

# ╔═╡ f38b39d0-36e9-11eb-1e5c-c77cec42ac74
function seat_id(rs)
	row, seat = rs
	return row * 8 + seat
end

# ╔═╡ 6d06face-36ea-11eb-3152-65738f22c875
maximum(seat_id(decode_pass(p)) for p in lines)

# ╔═╡ bbe31e2a-36ea-11eb-2312-c7204bcc5d8c
ids = sort([seat_id(decode_pass(p)) for p in lines])

# ╔═╡ 2acdc358-36eb-11eb-2e56-8d72a30f88b9
function gap(lst)
	for i in Iterators.drop(eachindex(lst), 1)
		if lst[i-1] != lst[i] - 1
			return lst[i-1] + 1
		end
	end
end

# ╔═╡ 53e0e676-36eb-11eb-23db-3f582090ca3f
gap(ids)

# ╔═╡ Cell order:
# ╠═28e42822-36e9-11eb-00e6-e5ade6b555e3
# ╠═7ae5962e-36e9-11eb-015c-39e4f676965c
# ╠═9a31905c-36e9-11eb-16e3-0d84b55d3457
# ╠═be7d1132-36e9-11eb-3465-5dc519011fcb
# ╠═4d9d7448-36e9-11eb-2b82-b707afa6cfea
# ╠═f38b39d0-36e9-11eb-1e5c-c77cec42ac74
# ╠═6d06face-36ea-11eb-3152-65738f22c875
# ╠═bbe31e2a-36ea-11eb-2312-c7204bcc5d8c
# ╠═2acdc358-36eb-11eb-2e56-8d72a30f88b9
# ╠═53e0e676-36eb-11eb-23db-3f582090ca3f
