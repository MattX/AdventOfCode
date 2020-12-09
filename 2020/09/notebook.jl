### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ cc026dac-3a39-11eb-30ba-edc9cf279bb2
numbers = open("input.txt") do f
	[parse(Int, l) for l in readlines(f) if !isempty(l)]
end

# ╔═╡ 65a982c6-3a3a-11eb-1dff-51531b3351c3
function find_sum_in(target, nums)
	for i in 1:length(nums)
		for j in i+1:length(nums)
			if nums[i] + nums[j] == target
				return true
			end
		end
	end
	return false
end

# ╔═╡ edaa1b70-3a39-11eb-165e-2f0400b12666
function part1(numbers)
	for i in Iterators.drop(eachindex(numbers), 25)
		if !find_sum_in(numbers[i], view(numbers, i-25:i-1))
			return numbers[i]
		end
	end
end

# ╔═╡ c378a3b4-3a3a-11eb-3aaf-d35a025524c2
part1(numbers)

# ╔═╡ de0ecdc0-3a3a-11eb-3fc6-f1a95b6f2aca
function part2(numbers, target)
	start_id = 1
	end_id = 2
	while true
		current_sum = sum(view(numbers, start_id:end_id))
		if current_sum == target
			return numbers[start_id:end_id]
		elseif current_sum > target
			start_id += 1
			if start_id == end_id
				end_id += 1
			end
		else
			end_id += 1
		end
	end
end

# ╔═╡ 4d8e8758-3a3b-11eb-3f27-7b763a765b5f
weakness = part2(numbers, part1(numbers))

# ╔═╡ 5f093b9a-3a3b-11eb-28fb-efcadaeb8df1
minimum(weakness) + maximum(weakness)

# ╔═╡ Cell order:
# ╠═cc026dac-3a39-11eb-30ba-edc9cf279bb2
# ╠═65a982c6-3a3a-11eb-1dff-51531b3351c3
# ╠═edaa1b70-3a39-11eb-165e-2f0400b12666
# ╠═c378a3b4-3a3a-11eb-3aaf-d35a025524c2
# ╠═de0ecdc0-3a3a-11eb-3fc6-f1a95b6f2aca
# ╠═4d8e8758-3a3b-11eb-3f27-7b763a765b5f
# ╠═5f093b9a-3a3b-11eb-28fb-efcadaeb8df1
