### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 2d51630e-3b1a-11eb-04a6-83d082328694
jolts = open("input.txt") do f
	[parse(Int, l) for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 491ff0a0-3b1a-11eb-2e6f-3d60cefcc245
lst = vcat([0], sort(jolts), [maximum(jolts) + 3])

# ╔═╡ 486e48be-3b1a-11eb-0086-1b01d2f086ce
function relative_diff(lst)
	diffs = []
	for i in Iterators.drop(eachindex(lst), 1)
		push!(diffs, lst[i] - lst[i - 1])
	end
	return diffs
end

# ╔═╡ e72a8dfc-3b1a-11eb-2a6f-d79b3d1822fe
diffs = relative_diff(lst)

# ╔═╡ f003e036-3b1a-11eb-086c-ffde6f8fd3f2
count(x -> x == 3, diffs) * count(x -> x == 1, diffs)

# ╔═╡ edc6ba86-3b41-11eb-3179-0f6b5fc0c95b
memo = Vector{Union{Nothing, Int}}(nothing, length(lst))

# ╔═╡ 90930210-3b42-11eb-35f4-c9cda7739741
function count_comb(from_idx)
	if memo[from_idx] != nothing
		return memo[from_idx]
	end
	if from_idx == length(lst)
		return 1
	end
	ways = 0
	for i in from_idx+1:length(lst)
		if lst[i] - lst[from_idx] <= 3
			ways += count_comb(i)
		else
			break
		end
	end
	memo[from_idx] = ways
	return ways
end

# ╔═╡ be43c460-3b42-11eb-26b4-7f1ad072aafb
count_comb(1)

# ╔═╡ Cell order:
# ╠═2d51630e-3b1a-11eb-04a6-83d082328694
# ╠═491ff0a0-3b1a-11eb-2e6f-3d60cefcc245
# ╠═486e48be-3b1a-11eb-0086-1b01d2f086ce
# ╠═e72a8dfc-3b1a-11eb-2a6f-d79b3d1822fe
# ╠═f003e036-3b1a-11eb-086c-ffde6f8fd3f2
# ╠═edc6ba86-3b41-11eb-3179-0f6b5fc0c95b
# ╠═90930210-3b42-11eb-35f4-c9cda7739741
# ╠═be43c460-3b42-11eb-26b4-7f1ad072aafb
