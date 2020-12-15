### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 485ad63e-3f2b-11eb-05de-83589dae60cc
input = [parse(Int, n) for n in split("16,1,0,18,12,14,19", ',')]

# ╔═╡ 90a2ae26-3f2b-11eb-36b8-7d6d402bdd25
function part1(input)
	num_turn = Dict(n => i for (i, n) in enumerate(input[1:end-1]))
	last = input[end]
	for turn in length(input):30000000-1
		if haskey(num_turn, last)
			next = turn - num_turn[last]
		else
			next = 0
		end
		num_turn[last] = turn
		last = next
	end
	return last
end

# ╔═╡ b83bd69c-3f2b-11eb-3fa2-a12272437124
part1(input)

# ╔═╡ Cell order:
# ╠═485ad63e-3f2b-11eb-05de-83589dae60cc
# ╠═90a2ae26-3f2b-11eb-36b8-7d6d402bdd25
# ╠═b83bd69c-3f2b-11eb-3fa2-a12272437124
