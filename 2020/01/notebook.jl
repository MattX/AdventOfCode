### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 149baf98-343e-11eb-28e2-3171768aa7e8
nums = open("input.txt") do f
	[parse(Int, i) for i in readlines(f) if !isempty(i)]
end

# ╔═╡ 3a545f3a-343e-11eb-3e4a-fb794e809e41
function part1(nums)
	for i in eachindex(nums)
		for j in range(i+1, stop=size(nums, 1))
			if nums[i] + nums[j] == 2020
				return nums[i] * nums[j]
			end
		end
	end
end

# ╔═╡ 981be298-343e-11eb-257a-ebd974cc6e62
part1(nums)

# ╔═╡ a1cf249c-343e-11eb-186f-cb009b549b3e
function part2(nums)
	for i in eachindex(nums)
		for j in range(i+1, stop=size(nums, 1))
			for k in range(j+1, stop=size(nums, 1))
				if nums[i] + nums[j] + nums[k] == 2020
					return nums[i] * nums[j] * nums[k]
				end
			end
		end
	end
end

# ╔═╡ b61b2c34-343e-11eb-1a4b-4925fefeaba9
part2(nums)

# ╔═╡ Cell order:
# ╠═149baf98-343e-11eb-28e2-3171768aa7e8
# ╠═3a545f3a-343e-11eb-3e4a-fb794e809e41
# ╠═981be298-343e-11eb-257a-ebd974cc6e62
# ╠═a1cf249c-343e-11eb-186f-cb009b549b3e
# ╠═b61b2c34-343e-11eb-1a4b-4925fefeaba9
