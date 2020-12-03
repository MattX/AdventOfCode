### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 99aebdbc-3525-11eb-3471-05aac1c24b1d
lines = open("input.txt") do f
	hcat([collect(l) for l in readlines(f) if !isempty(l)]...)
end

# ╔═╡ 5f5eb928-3525-11eb-1d4f-35bb4c40ff74
terrain = map(x -> x=='#', lines)

# ╔═╡ 899975d6-3528-11eb-18a6-d5f84322a42c
size(terrain)

# ╔═╡ 309a2a36-3526-11eb-3bc9-b91bc5301ff1
function positions(x_slope, y_slope, dims)
	x_dim, y_dim = dims
	counter = Iterators.countfrom(0)
	coords = ((1 + i * x_slope % x_dim, 1 + i * y_slope) for i in counter)
	return Iterators.takewhile(i -> i[2] <= y_dim, coords)
end

# ╔═╡ a01004dc-3529-11eb-20e6-3de43f5b49be
println("start")

# ╔═╡ 5918aa54-3527-11eb-3072-df82c2111b85
function count_trees(slope_x, slope_y)
	trees = 0
	for coord in positions(slope_x, slope_y, size(terrain))
		println(coord)
		if terrain[coord...]
			trees = trees + 1
		end
	end
	return trees
end

# ╔═╡ 3737de9e-3529-11eb-1103-01d0cf7a3273
count_trees(3, 1)

# ╔═╡ da651172-3529-11eb-0fa3-31b6044ced25
count_trees(1, 1) * count_trees(3, 1) * count_trees(5, 1) * count_trees(7, 1) * count_trees(1, 2)

# ╔═╡ Cell order:
# ╠═99aebdbc-3525-11eb-3471-05aac1c24b1d
# ╠═5f5eb928-3525-11eb-1d4f-35bb4c40ff74
# ╠═899975d6-3528-11eb-18a6-d5f84322a42c
# ╠═309a2a36-3526-11eb-3bc9-b91bc5301ff1
# ╠═a01004dc-3529-11eb-20e6-3de43f5b49be
# ╠═5918aa54-3527-11eb-3072-df82c2111b85
# ╠═3737de9e-3529-11eb-1103-01d0cf7a3273
# ╠═da651172-3529-11eb-0fa3-31b6044ced25
