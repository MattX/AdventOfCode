### A Pluto.jl notebook ###
# v0.12.15

using Markdown
using InteractiveUtils

# ╔═╡ 1c7b96a4-3781-11eb-3bf9-17679e63bf21
lines = open("input.txt") do f
	[l for l in readlines(f)]
end

# ╔═╡ 77134602-3781-11eb-17b6-6367763fd369
function get_groups(lines)
	groups = []
	current_group = []
	for l in lines
		if isempty(l)
			push!(groups, current_group)
			current_group = []
		else
			push!(current_group, l)
		end
	end
	if !isempty(current_group)
		push!(groups, current_group)
	end
	return groups
end

# ╔═╡ c16b84b2-3781-11eb-3ded-f3b8bb759bc4
groups = get_groups(lines)

# ╔═╡ dbbaaeae-3781-11eb-2352-df5e1238eb82
function count_answers(group)
	answered = Set()
	for person in group
		union!(answered, Iterators.Stateful(person))
	end
	return length(answered)
end

# ╔═╡ 41365bc2-3782-11eb-23f5-0312de54ad12
sum(count_answers(g) for g in groups)

# ╔═╡ a9b05c50-3782-11eb-2538-f54d130634f4
function count_answers_everyone(group)
	answered = Set(Iterators.Stateful(group[1]))
	for person in Iterators.drop(group, 1)
		intersect!(answered, Iterators.Stateful(person))
	end
	return length(answered)
end

# ╔═╡ c613efd0-3782-11eb-2fa6-85868d7b1d6b
sum(count_answers_everyone(g) for g in groups)

# ╔═╡ Cell order:
# ╠═1c7b96a4-3781-11eb-3bf9-17679e63bf21
# ╠═77134602-3781-11eb-17b6-6367763fd369
# ╠═c16b84b2-3781-11eb-3ded-f3b8bb759bc4
# ╠═dbbaaeae-3781-11eb-2352-df5e1238eb82
# ╠═41365bc2-3782-11eb-23f5-0312de54ad12
# ╠═a9b05c50-3782-11eb-2538-f54d130634f4
# ╠═c613efd0-3782-11eb-2fa6-85868d7b1d6b
