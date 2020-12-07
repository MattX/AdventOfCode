### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 639d6688-384a-11eb-3e5b-cb3ec0708c9b
lines = open("input.txt") do f
	[l for l in readlines(f) if !isempty(l)]
end

# ╔═╡ a9e73a58-384a-11eb-0673-7933dd93cd83
line_regex = r"^(?<container>.+) bags contain (?<contents>.+)."

# ╔═╡ 288c100c-384b-11eb-0141-3317c09b2fe7
contents_regex = r"(?<n>[0-9]+) (?<color>.+) bags?|no other bags"

# ╔═╡ e5f338c8-384b-11eb-2efd-fd8d9de7aeba
match(contents_regex, "no other bags")

# ╔═╡ 049337a2-384b-11eb-02ca-5dd25dbf6017
match(line_regex, lines[4])

# ╔═╡ 84db5318-384b-11eb-22dc-b30bd9f81200
function parse_rule(line)
	m = match(line_regex, line)
	if m == nothing
		throw("error")
	end
	container = m[:container]
	contents = split(m[:contents], ", ")
	parsed = []
	for content in contents
		cm = match(contents_regex, content)
		if cm == nothing
			throw("also error")
		end
		if cm[:n] != nothing
			push!(parsed, (parse(Int, cm[:n]), cm[:color]))
		end
	end
	return (container, parsed)
end

# ╔═╡ 09cc9f10-384b-11eb-2907-012d1bc56843
rules = [parse_rule(r) for r in lines]

# ╔═╡ 47c203b8-384c-11eb-02a0-bb8afdf2b1b6
function get_all_colors(rules)
	colors = Set()
	for (container, contents) in rules
		push!(colors, container)
		union!(colors, [color for (n, color) in contents])
	end
	return colors
end

# ╔═╡ bce5deee-384c-11eb-06e4-d340234ad217
colors = collect(get_all_colors(rules))

# ╔═╡ dfd0539e-384c-11eb-38a9-132ee6df15fa
color_to_id = Dict(e => i for (i, e) in enumerate(colors))

# ╔═╡ fe205b6e-384c-11eb-1253-fd8e3afca753
function build_adjacency(rules, colors, color_to_id)
	contains = zeros(Int, length(colors), length(colors))
	for (container, contents) in rules
		container_id = color_to_id[container]
		for (n, color) in contents
			contains[container_id, color_to_id[color]] = n
		end
	end
	return contains
end

# ╔═╡ 6d375caa-384d-11eb-22bd-d90e776ad43c
adjacency = build_adjacency(rules, colors, color_to_id)

# ╔═╡ 92a8cc30-384d-11eb-20ba-e79b040f4631
shiny_gold_id = color_to_id["shiny gold"]

# ╔═╡ a18647d2-384d-11eb-3b91-a31ca9bd5f0c
function reverse_dfs(adjacency, from, visited)
	parents = 0
	visited[from] = true
	for (i_parent, connected) in enumerate(adjacency[:, from])
		if connected > 0 && !visited[i_parent]
			parents += reverse_dfs(adjacency, i_parent, visited) + 1
		end
	end
	return parents
end

# ╔═╡ 31d7e3fe-384e-11eb-2334-eddf4d78b682
reverse_dfs(adjacency, shiny_gold_id, zeros(Bool, length(colors)))

# ╔═╡ 9b7504fe-384e-11eb-0b93-650e2c9afa3a
function dfs(adjacency, from)
	children = 0
	for (i_parent, n_contained) in enumerate(adjacency[from, :])
		if n_contained > 0
			children += (dfs(adjacency, i_parent) + 1) * n_contained
		end
	end
	return children
end

# ╔═╡ abcab6b4-384e-11eb-0d0b-c55f2d25fd31
dfs(adjacency, shiny_gold_id)

# ╔═╡ Cell order:
# ╠═639d6688-384a-11eb-3e5b-cb3ec0708c9b
# ╠═a9e73a58-384a-11eb-0673-7933dd93cd83
# ╠═288c100c-384b-11eb-0141-3317c09b2fe7
# ╠═e5f338c8-384b-11eb-2efd-fd8d9de7aeba
# ╠═049337a2-384b-11eb-02ca-5dd25dbf6017
# ╠═84db5318-384b-11eb-22dc-b30bd9f81200
# ╠═09cc9f10-384b-11eb-2907-012d1bc56843
# ╠═47c203b8-384c-11eb-02a0-bb8afdf2b1b6
# ╠═bce5deee-384c-11eb-06e4-d340234ad217
# ╠═dfd0539e-384c-11eb-38a9-132ee6df15fa
# ╠═fe205b6e-384c-11eb-1253-fd8e3afca753
# ╠═6d375caa-384d-11eb-22bd-d90e776ad43c
# ╠═92a8cc30-384d-11eb-20ba-e79b040f4631
# ╠═a18647d2-384d-11eb-3b91-a31ca9bd5f0c
# ╠═31d7e3fe-384e-11eb-2334-eddf4d78b682
# ╠═9b7504fe-384e-11eb-0b93-650e2c9afa3a
# ╠═abcab6b4-384e-11eb-0d0b-c55f2d25fd31
