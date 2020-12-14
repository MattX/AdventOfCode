### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ b7f8e88c-3dc3-11eb-35d3-d3be2387cddf
instrs = open("input.txt") do f
	[(l[1], parse(Int, l[2:end])) for l in readlines(f) if !isempty(l)]
end

# ╔═╡ d269cc04-3dc3-11eb-3ddf-0121ab5a4fc1
function part1(instrs)
	position = [0, 0]
	angle = 0
	for instr in instrs
		if instr[1] == 'F'
			position += broadcast(round, [sin(angle*π/180), cos(angle*π/180)]) * instr[2]
		elseif instr[1] == 'N'
			position[1] -= instr[2]
		elseif instr[1] == 'E'
			position[2] += instr[2]
		elseif instr[1] == 'S'
			position[1] += instr[2]
		elseif instr[1] == 'W'
			position[2] -= instr[2]
		elseif instr[1] == 'R'
			angle += instr[2]
		elseif instr[1] == 'L'
			angle -= instr[2]
		end
	end
	return abs(position[1]) + abs(position[2])
end

# ╔═╡ 39c7e39e-3dc5-11eb-16c4-d5883abaac29
part1(instrs)

# ╔═╡ 5c190678-3dc6-11eb-0872-37a9ba432b25
function rotation_matrix(angle)
	return broadcast(x -> round(Int, x), [[cos(angle), -sin(angle)] [sin(angle), cos(angle)]])
end

# ╔═╡ f3f8c73c-3dc6-11eb-0a65-199a408b36a3
rotation_matrix(90)

# ╔═╡ 33600e90-3dc6-11eb-1a7a-1d07a29699f7
function part2(instrs)
	waypoint = [-1, 10]
	position = [0, 0]
	for instr in instrs
		if instr[1] == 'F'
			position += waypoint * instr[2]
		elseif instr[1] == 'N'
			waypoint[1] -= instr[2]
		elseif instr[1] == 'E'
			waypoint[2] += instr[2]
		elseif instr[1] == 'S'
			waypoint[1] += instr[2]
		elseif instr[1] == 'W'
			waypoint[2] -= instr[2]
		elseif instr[1] == 'R'
			waypoint = rotation_matrix(instr[2]*π/180) * waypoint
		elseif instr[1] == 'L'
			waypoint = rotation_matrix(-instr[2]*π/180) * waypoint
		end
	end
	return abs(position[1]) + abs(position[2])
end

# ╔═╡ cf94c346-3dc6-11eb-2620-5180fd8cce3f
part2(instrs)

# ╔═╡ Cell order:
# ╠═b7f8e88c-3dc3-11eb-35d3-d3be2387cddf
# ╠═d269cc04-3dc3-11eb-3ddf-0121ab5a4fc1
# ╠═39c7e39e-3dc5-11eb-16c4-d5883abaac29
# ╠═5c190678-3dc6-11eb-0872-37a9ba432b25
# ╠═f3f8c73c-3dc6-11eb-0a65-199a408b36a3
# ╠═33600e90-3dc6-11eb-1a7a-1d07a29699f7
# ╠═cf94c346-3dc6-11eb-2620-5180fd8cce3f
