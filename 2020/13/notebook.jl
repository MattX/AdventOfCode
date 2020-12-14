### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 9bf67d3a-3dc7-11eb-12e4-3f1a963ec083
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 494cc714-3dc8-11eb-0746-7f37e0096d9b
timestamp = parse(Int, lines[1])

# ╔═╡ 5bba713a-3dc8-11eb-03da-ef23d15aa0ed
buses = [parse(Int, x) for x in split(lines[2], ',') if x != "x"]

# ╔═╡ 704d0414-3dc8-11eb-3029-b913995cc129
function part1()
	waits = []
	for bus in buses
		next_bus = bus - mod(timestamp, bus)
		push!(waits, (next_bus, bus))
	end
	return waits
end

# ╔═╡ c2bc5204-3dc8-11eb-3c93-a12df0a446c7
part1()

# ╔═╡ 4ceb9b16-3dca-11eb-3066-195f49dd40d9
bus_cong = [(parse(Int, x), i - 1) for (i, x) in enumerate(split(lines[2], ',')) if x != "x"]

# ╔═╡ b0be2328-3dcf-11eb-2ae7-177fcea0bbda
# bus_cong = [(1789,0), (37,1), (47, 2), (1889, 3)]

# ╔═╡ f5754860-3dcb-11eb-273f-3bda25388292
function field_inverse(x, m)
	(old_r, r) = (m, x)
	(old_t, t) = (0, 1)
	while r != 0
		quotient = old_r ÷ r
		(old_r, r) = (r, old_r - quotient * r)
		(old_t, t) = (t, old_t - quotient * t)
	end
	if old_r > 1
		throw("error: $x has no inverse in F$m")
	end
	if old_t < 0
		return old_t + m
	else
		return old_t
	end
end

# ╔═╡ f63c5fc6-3dcc-11eb-2f27-7315c71ca8fc
field_inverse(33, 53) * 33 % 53

# ╔═╡ 62dd78e4-3dce-11eb-21a3-ffecd41567f3
M = reduce(*, (m for (m, a) in bus_cong))

# ╔═╡ b234d422-3dca-11eb-2213-5d4150b6b19a
function part2()
	total = 0
	for (m, a) in bus_cong
		a = mod(-a, m)
		b = M÷m
		total += (a * b * field_inverse(b, m)) % M
	end
	return total % M
end

# ╔═╡ 60ae3b94-3dcb-11eb-0f9d-2df2ddf67952
part2()

# ╔═╡ Cell order:
# ╠═9bf67d3a-3dc7-11eb-12e4-3f1a963ec083
# ╠═494cc714-3dc8-11eb-0746-7f37e0096d9b
# ╠═5bba713a-3dc8-11eb-03da-ef23d15aa0ed
# ╠═704d0414-3dc8-11eb-3029-b913995cc129
# ╠═c2bc5204-3dc8-11eb-3c93-a12df0a446c7
# ╠═4ceb9b16-3dca-11eb-3066-195f49dd40d9
# ╠═b0be2328-3dcf-11eb-2ae7-177fcea0bbda
# ╠═f5754860-3dcb-11eb-273f-3bda25388292
# ╠═f63c5fc6-3dcc-11eb-2f27-7315c71ca8fc
# ╠═62dd78e4-3dce-11eb-21a3-ffecd41567f3
# ╠═b234d422-3dca-11eb-2213-5d4150b6b19a
# ╠═60ae3b94-3dcb-11eb-0f9d-2df2ddf67952
